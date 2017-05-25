//
//  FZKTBluetoothManager.m
//  Connector
//
//  Created by czl on 2017/5/15.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKTBluetoothManager.h"
#import <BabyBluetooth.h>
#import <SVProgressHUD.h>
#import "SRBLESendData.h"

#import "SRBLEReceivedData.h"

#import "SRBLEBluetoothInfo.h"
#import "SRBLEEncryptionInfo.h"
#import "SRBLEControlResult.h"


#import <YYTimer.h>
#import "FZKTBLEParse.h"
#import "FZKTCPClient.h"

#import "FZKTBleControlCallBack.h"

#import "FZKTDispatch_after.h"


#define channelOnPeropheralView @"peripheralView"

//串行发送队列
static dispatch_queue_t ble_queue() {
    static dispatch_queue_t ble_serial_queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ble_serial_queue = dispatch_queue_create("com.sirui.ble", DISPATCH_QUEUE_SERIAL);
    });
    
    return ble_serial_queue;
}


@interface FZKTBluetoothManager ()

@property (nonatomic,strong) BabyBluetooth *baby;


/**
 保存 FZKTBleControlCallBack
 */
@property (nonatomic,strong) NSMutableArray *callBackArray;

/**
 检查心跳定时器
 */
@property (nonatomic,strong) YYTimer *timer;


/**
 连接延迟操作处理
 */
@property (nonatomic,strong) FZKTDispatch_after *dispatch_aft;

/**
 当前设备mac地址
 */
//@property (nonatomic,copy) NSString *macId;


/**
 当前设备信息
 */
@property (nonatomic,strong)FZKTBluetoothInfoModel  *bleInfo;



@end

@implementation FZKTBluetoothManager
{
    
    
    CBPeripheral *currentPeripheral;//当前设备
    
    CBCharacteristic *ble_write;//蓝牙验证与心跳
    
    CBCharacteristic *terminal_write;//终端写出特征
    
    NSMutableData *datas; //收到数据
    
    NSDate *lastHeartTime;//收到心跳时间
    
   
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.baby = [BabyBluetooth shareBabyBluetooth];
        
        //代理
        [self babyCenterManagerDeledate];
        
        
        [self babyPeripheralsDelegate];
        
        
//        self.baby.scanForPeripherals().begin();
    }
    return self;
}

+ (instancetype)shareBluetoothManager{
    
    
    static FZKTBluetoothManager *install = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        install = [FZKTBluetoothManager new];
    });
    return install;
}


- (void)babyCenterManagerDeledate{
    __weak typeof(self) weakSelf = self;
    
    [self.baby setBlockOnCentralManagerDidUpdateState:^(CBCentralManager *central) {
        if (central.state != CBCentralManagerStatePoweredOn) {
            //            [SVProgressHUD showInfoWithStatus:@"设备打开成功，开始扫描设备"];
            [weakSelf reSet];
            
//            [[NSNotificationCenter defaultCenter]postNotificationName:kBleStateNotifacation object:@(CBPeripheralStateDisconnected)];
        }
    }];
    
    //设置扫描到设备的委托
    [self.baby setBlockOnDiscoverToPeripherals:^(CBCentralManager *central, CBPeripheral *peripheral, NSDictionary *advertisementData, NSNumber *RSSI) {
        
        if ([peripheral.name isEqualToString:[NSString stringWithFormat:@"btu-%@",weakSelf.bleInfo.mac]]) {
            currentPeripheral = peripheral;
            //取消扫描
            [weakSelf.baby cancelScan];
            weakSelf.baby.having(peripheral).and.channel(channelOnPeropheralView).then.connectToPeripherals().discoverServices().discoverCharacteristics().readValueForCharacteristic().discoverDescriptorsForCharacteristic().readValueForDescriptors().begin();
        }

        
    }];
    
    //设备过滤
    [self.baby setFilterOnDiscoverPeripherals:^BOOL(NSString *peripheralName, NSDictionary *advertisementData, NSNumber *RSSI) {
        
        if ([peripheralName isEqualToString:[NSString stringWithFormat:@"btu-%@",weakSelf.bleInfo.mac]]) {
            return YES;
        }
        
        return NO;
    }];
    
    
    
    
}

- (void)babyPeripheralsDelegate{
    
    __weak typeof(self)weakSelf = self;
    
    
    
    
    //设置设备连接成功的委托,同一个baby对象，使用不同的channel切换委托回调
    [self.baby setBlockOnConnectedAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral) {
        
        if ([peripheral.name isEqualToString:[NSString stringWithFormat:@"btu-%@",weakSelf.bleInfo.mac]]) {
            
            [[NSNotificationCenter defaultCenter]postNotificationName:kBleStateNotifacation object:@(CBPeripheralStateConnected)];
        }
        
    }];
    
    //设置设备连接失败的委托
    [self.baby setBlockOnFailToConnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        NSLog(@"设备：%@--连接失败",peripheral.name);
        
        if ([peripheral.name isEqualToString:[NSString stringWithFormat:@"btu-%@",weakSelf.bleInfo.mac]]) {
            
            [weakSelf reSet];
            
//            [[NSNotificationCenter defaultCenter]postNotificationName:kBleStateNotifacation object:@(CBPeripheralStateDisconnected)];
        }
    }];
    
    //设置设备断开连接的委托
    [self.baby setBlockOnDisconnectAtChannel:channelOnPeropheralView block:^(CBCentralManager *central, CBPeripheral *peripheral, NSError *error) {
        
        if ([peripheral.name isEqualToString:[NSString stringWithFormat:@"btu-%@",weakSelf.bleInfo.mac]]) {
            
            [weakSelf reSet];
            
           
        }

        
    }];
    
    //设置发现设service的Characteristics的委托
    [self.baby setBlockOnDiscoverCharacteristicsAtChannel:channelOnPeropheralView block:^(CBPeripheral *peripheral, CBService *service, NSError *error) {
        //        NSLog(@"===service name:%@",service.UUID);
        //获取指定服务
        if ([service.UUID.UUIDString isEqualToString:SRUUID_Peripheral_service]) {
            //              解析指定服务的特征
            [weakSelf parsePerialCharachles:service.characteristics periphral:peripheral];
        }
        
    }];
    
    
    //扫描选项->CBCentralManagerScanOptionAllowDuplicatesKey:忽略同一个Peripheral端的多个发现事件被聚合成一个发现事件
    NSDictionary *scanForPeripheralsWithOptions = @{CBCentralManagerScanOptionAllowDuplicatesKey:@YES};
    /*连接选项->
     CBConnectPeripheralOptionNotifyOnConnectionKey :当应用挂起时，如果有一个连接成功时，如果我们想要系统为指定的peripheral显示一个提示时，就使用这个key值。
     CBConnectPeripheralOptionNotifyOnDisconnectionKey :当应用挂起时，如果连接断开时，如果我们想要系统为指定的peripheral显示一个断开连接的提示时，就使用这个key值。
     CBConnectPeripheralOptionNotifyOnNotificationKey:
     当应用挂起时，使用该key值表示只要接收到给定peripheral端的通知就显示一个提
     */
    NSDictionary *connectOptions = @{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnDisconnectionKey:@YES,
                                     CBConnectPeripheralOptionNotifyOnNotificationKey:@YES};
    
    [self.baby setBabyOptionsAtChannel:channelOnPeropheralView scanForPeripheralsWithOptions:scanForPeripheralsWithOptions connectPeripheralWithOptions:connectOptions scanForPeripheralsWithServices:nil discoverWithServices:nil discoverWithCharacteristics:nil];
    
    
    
    
}

- (void)parsePerialCharachles:(NSArray<CBCharacteristic *> *) characteristics periphral:(CBPeripheral *)peripheral{
    
    for (CBCharacteristic *obj in characteristics) {
        
        if ([obj.UUID isEqual:[CBUUID UUIDWithString:SRUUID_Characteristic_Write_BLE]]) {
         
            
            
            ble_write = obj;
            
            currentPeripheral = peripheral;
            
            //查询认证信息
            [self sendData:[SRBLESendData queryBleAuthData].dataValue toCharacteristic:obj toPeripheral:peripheral];
            
        } else if ([obj.UUID isEqual:[CBUUID UUIDWithString:SRUUID_Characteristic_Read_Terminal]]) {
            //订阅消息通知
            [peripheral setNotifyValue:YES forCharacteristic:obj];
            
            //特征通知处理
            [self.baby notify:peripheral
               characteristic:obj
                        block:^(CBPeripheral *peripheral, CBCharacteristic *characteristics, NSError *error) {
                            
                            NSString *receiveStr = [[NSString alloc]initWithData:characteristics.value encoding:NSUTF8StringEncoding];
                            
                            if (error ||receiveStr.length==0) {
                                NSLog(@"【蓝牙】特性数据读取错误:%@ %@", characteristics, [error localizedDescription]);
                                return;
                            }
                            
                            [datas appendData:characteristics.value];
                            
                            NSData *last = [characteristics.value subdataWithRange:NSMakeRange(characteristics.value.length-1, 1)];
                            
                            BOOL hasBreak = [last isEqualToData:[SRBLEData transferEndFlagData]];
                            
                            if (hasBreak) {
                                
                                SRBLEReceivedData *received = [[SRBLEReceivedData alloc] initWithData:datas];
                                datas = [NSMutableData new];
                                if (!received) {
                                    NSLog(@"【蓝牙】数据解析错误");
                                    return;
                                }
                                
                                if (received.operationMessageType == SRBLEMessageType_Publish) {
//                                    凡是服务器过来数据且是 SRBLEMessageType_Publish 都应答
                                    [self sendData:[SRBLESendData dataWithAckTerminalType:received.terminalType
                                                                     operationInstruction:received.operationInstruction].dataValue toCharacteristic:terminal_write toPeripheral:currentPeripheral];
                                }
                                
                                if (received.operationInstruction == SRBLEOperationInstruction_B301) {
                                    //设备主动上报状态解析
                                    [FZKTBLEParse BLEReceivedData:datas];
                                    
                                }else if (received.operationInstruction == SRBLEOperationInstruction_A605) {
                                    
                                    
                                    //认证应答
                                    [self sendData:[SRBLESendData bleAuthDataWithID:[received bluetoothInfo].authCode].dataValue toCharacteristic:ble_write toPeripheral:currentPeripheral];
                                    
                                    
                                    
                                    //2. 查询终端加密信息
                                    [self sendData:[SRBLESendData queryEncryptionInfo].dataValue toCharacteristic:terminal_write toPeripheral:peripheral];
                                    
                                    //查询设备状态
                                    [self sendData:[SRBLESendData dataWithQueryStatus].dataValue toCharacteristic:terminal_write toPeripheral:peripheral];
                                    
                                    //开启心跳监听
                                    [self.timer fire];
                                    
                                }else if(received.operationInstruction == SRBLEOperationInstruction_HEART){
                                    
                                    //发送心跳
                                    lastHeartTime = [NSDate date];
                                    
                                    [self sendData:[SRBLESendData buildHeart].dataValue toCharacteristic:ble_write toPeripheral:currentPeripheral];
                                    
                                }else if (received.operationInstruction == SRBLEOperationInstruction_B502){
                                    //获取流水号 >0才有效
//                                    NSLog(@"502收到查询流水号指令:%d",[received controlNumber]);
                                    
                                    if ([received controlNumber]) {
                                        FZKTBleControlCallBack *call = [self runControl502];
                                        if (call) {
                                            call.isRun502 = YES;
                                            call.serialNumber502(nil,@([received controlNumber]));
                                            
                                        }
                                    }
                                    
                                    
                                    
                                    
                                    
                                }else if (received.operationInstruction == SRBLEOperationInstruction_B402){
                                    
                                    //控制指令结果处理
                                    FZKTBleControlCallBack *call = [self runControl402];
                                    if (call) {
                                        call.isRun402 = YES;
                                        call.control402(nil,[received controlResult].resultString);
                                        [self.callBackArray removeObject:call];
                                    }

                                    
                                }else if (received.operationInstruction == SRBLEOperationInstruction_B203){
                                    
                                    //验证终端是否第一次使用，如果是第一次使用就设置终端id  和key
                                    if ([[received encryptionInfo].idStr isEqualToString:@"0"]||[[received encryptionInfo].keyCRC isEqualToString:@"0"]) {
                                        
                                        SRBLESendData *config = [SRBLESendData configDataWithID:self.bleInfo.bluetoothID andKey:self.bleInfo.key];
                                        //  2. 设置终端配置信息
                                        [self sendData:config.dataValue toCharacteristic:terminal_write toPeripheral:peripheral];
                                    }
//                                    NSLog(@"接收到bleid:%@,key:%@",[received encryptionInfo].idStr,[received encryptionInfo].keyCRC);
                                }
                                
 
                            }
                            
                        }];
            
            
            
        } else if ([obj.UUID isEqual:[CBUUID UUIDWithString:SRUUID_Characteristic_Write_Terminal]]) {
            
            terminal_write = obj;
        }
    }
    
}


- (void)sendData:(NSData *)data toCharacteristic:(CBCharacteristic *)characteristic toPeripheral:(CBPeripheral *)peripheral{
    
    
    dispatch_async(ble_queue(), ^{
        
//        NSLog(@"发送信息时间间隔%fms",(CFAbsoluteTimeGetCurrent()-oldTIme)*1000);
        
//        NSLog(@"蓝牙发送总数据<<<<<<<<<<<<<<<<  characteristic %@-------%@",characteristic,  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
        
        //循环发送数据，每个包最大20字节,不足补0
        //    @autoreleasepool {
        for (NSInteger index = 0; index < data.length; ) {
            NSMutableData *newdata = [NSMutableData dataWithData:[data subdataWithRange:NSMakeRange(index, MIN(data.length-index, kMaxBLESendLength))]];
            
            //不足20补0
            if (newdata.length < kMaxBLESendLength) {
                UInt8 temp[kMaxBLESendLength-newdata.length];
                memset(temp, 0x00, sizeof(temp));
                [newdata appendBytes:temp length:sizeof(temp)];
            }
            
            //            BTLog(LOG_DEBUG,@"蓝牙发送数据 20 >>>>>>>>>>>>>>>>>>> %@", [[NSString alloc] initWithData:new encoding:NSUTF8StringEncoding]);
            
            [peripheral writeValue:newdata
                 forCharacteristic:characteristic
                              type:CBCharacteristicWriteWithResponse];
            
            index += kMaxBLESendLength;
        }
        
        //刚好20字节，发送完成后再发送结束符
        if (data.length % kMaxBLESendLength == 0) {
            UInt8 temp[kMaxBLESendLength];
            memset(temp, 0x00, sizeof(temp));
            NSData *newd = [[NSData alloc] initWithBytes:temp length:kMaxBLESendLength];
            [peripheral writeValue:newd
                 forCharacteristic:characteristic
                              type:CBCharacteristicWriteWithResponse];
        }
        //        发送时间间隔50毫秒
//        sleep();
        [NSThread sleepForTimeInterval:kBLESendDataMinInterval*0.001];
    });
    
    //    }
}



#pragma mark - getter
- (YYTimer *)timer{
    
    if (!_timer) {
        _timer = [YYTimer timerWithTimeInterval:kBLEExecuteTimeout target:self selector:@selector(CheckTheHeart) repeats:YES];
    }
    
    return _timer;
    
}

- (FZKTDispatch_after *)dispatch_aft{

    if (!_dispatch_aft) {
        _dispatch_aft = [FZKTDispatch_after new];
    }
    return _dispatch_aft;
}

-(NSMutableArray *)callBackArray{

    if (!_callBackArray) {
        _callBackArray = [NSMutableArray new];
    }
    return _callBackArray;
}

- (void)CheckTheHeart{
    //    NSLog(@"上次心跳时间%f",fabs([lastHeartTime timeIntervalSinceNow]));
    
    NSTimeInterval interval = fabs([lastHeartTime timeIntervalSinceNow]);
    if(nil!=lastHeartTime && interval > 3*kBLEExecuteTimeout){ //没有收到对端心跳
        [self disConnect];
        
    }else if(interval>kBLEExecuteTimeout){
        
        if ([self canSendDataToBLE]) {
            [self sendData:[SRBLESendData buildHeart].dataValue toCharacteristic:ble_write toPeripheral:currentPeripheral];
        }else{
            [self disConnect];
            
        }
        
    }
    
}


#pragma mark -  连接
- (void)connect:(FZKTBluetoothInfoModel *)bleInfo{
    
    
    if (!bleInfo || ([self.bleInfo.mac isEqualToString:bleInfo.mac]&&[self canSendDataToBLE])) {
        return;
    }
    if(self.baby.centralManager.state==CBManagerStatePoweredOff){
        [SVProgressHUD showErrorWithStatus:@"蓝牙未打开"];
        return;
    }
    
    
    [self disConnect];
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kBleStateNotifacation object:@(CBPeripheralStateConnecting)];
    
    _bleInfo = bleInfo;
    
    _carId = bleInfo.carId;
    
    self.baby.scanForPeripherals().begin();
    
 
   [self.dispatch_aft runDispatch_after:10.0 block:^{
        
        if (![self canSendDataToTerminal]) {
            [self reSet];
        }

    }];
    
    
}


#pragma mark - 断开连接
- (void)disConnect{
    
    [self.baby cancelAllPeripheralsConnection];
    
    [self reSet];
    
}


/**
 数据重置
 */
- (void)reSet{
    
    [self.timer invalidate];
    
    currentPeripheral = nil;
    
    lastHeartTime = nil;
    
    datas = [NSMutableData new];
    
    ble_write = nil;
    
    terminal_write = nil;
    
    //    self.macId = nil;
    
    self.bleInfo = nil;
    
    _carId = 0;
    
     [[NSNotificationCenter defaultCenter]postNotificationName:kBleStateNotifacation object:@(CBPeripheralStateDisconnected)];
    
    //上报蓝牙状态给服务器
//    [[FZKTCPClient shareTCPClient] sendTCPRequest:[FZKTCPRequest bleStatusWithVehicleID:[[NSUserDefaults standardUserDefaults] integerForKey:@"kSelectCarId"] isConnected:NO] withCompleteBlock:nil];
    
}

#pragma mark - 是否可以发送数据到蓝牙
- (BOOL)canSendDataToBLE{
    
    return currentPeripheral && currentPeripheral.state == CBPeripheralStateConnected && ble_write;;
}

#pragma mark -  是否可以发送数据到终端设备
- (BOOL)canSendDataToTerminal{
    
    return currentPeripheral && currentPeripheral.state == CBPeripheralStateConnected && terminal_write;
}

#pragma mark -  发送控制指令
- (void)sendCommand:(SRBLEInstruction)command withCompleteBlock:(CompleteBlock)completeBlock{
    
    
    //1、查询控制滚动码
    SRBLESendData *query = [SRBLESendData queryControlNumber];
    
    [self sendData:query.dataValue toCharacteristic:terminal_write toPeripheral:currentPeripheral];
    
    __weak typeof(self) weakSelf = self;
    
    __block FZKTBleControlCallBack *callBack = [FZKTBleControlCallBack new];
    
 

    

    
    callBack.serialNumber502= ^(NSError *error, id responseObject){
        
        //发送控制指令
        SRBLESendData *data = [SRBLESendData dataWithControlInstruction:command
                                                          controlNumber:[responseObject integerValue]
                                                                    key:weakSelf.bleInfo.key
                                                                  idStr:weakSelf.bleInfo.bluetoothID];
        
        [weakSelf sendData:data.dataValue toCharacteristic:terminal_write toPeripheral:currentPeripheral];
        
//        NSLog(@"502回调完成completeBlock:%@",completeBlock);
    };
    
    callBack.control402 = ^(NSError *error, id responseObject){
//        NSLog(@"402回调完成completeBlock:%@",completeBlock);
        completeBlock(error,responseObject);
        
        
    };
    
    callBack.timeOutFail = ^(NSError *error, id responseObject){
        
        completeBlock(error,nil);
        NSLog(@"失败回调:%@",responseObject);
        [weakSelf.callBackArray removeObject:responseObject];
        
    };
    
    [self.callBackArray addObject:callBack];
    
    
    
}


- (FZKTBleControlCallBack *)runControl502{
    
    for (FZKTBleControlCallBack *callBack in self.callBackArray) {
        if (!callBack.isRun502) {
//            NSLog(@"执行流水号502控制指令地址：%@",callBack);
            return callBack;
        }
    }
    return nil;
}


- (FZKTBleControlCallBack *)runControl402{
    
    for (FZKTBleControlCallBack *callBack in self.callBackArray) {
        if (!callBack.isRun402) {
//            NSLog(@"执行控制指令402地址：%@",callBack);
            return callBack;
        }
    }
    return nil;
    
}


@end
