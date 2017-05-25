//
//  FZKTCarStateParse.m
//  Connector
//
//  Created by czl on 2017/5/19.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKTCarStateManager.h"
#import "SRBLEReceivedData.h"
#import "FZKBVehicleStatusInfoModel.h"
#import "SRBLEVehicleStatus.h"
//#import "FZKBVehicleBasicInfoModel.h"
#import "FZKTLV.h"
#import "FZKTCPResponse.h"
#import <MJExtension.h>
#import "FZKTBluetoothInfoModel.h"
#import "FZKTCPClient.h"
#import "FZKBVehicleStatusHttpAction.h"
#import "FZKCUserDefaults.h"
#import "FZKTBluetoothManager.h"
#import "FZKBTotalInfosModel.h"
#import "FZKBLoginModel.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface FZKTCarStateManager ()

/**
 定时器
 */
@property (nonatomic,strong) NSTimer *timer;


@end
@implementation FZKTCarStateManager
{
    
    NSInteger carid;
}
SingleImplementation(CarStateManager)


-(instancetype)init{
    
    if (self=[super init]) {
        //监听app激活
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActiveNotification) name:UIApplicationDidBecomeActiveNotification object:nil];
        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(query:) name:kBleStateNotifacation object:nil];
        
        carid = 0;
    }
    return self;
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)query:(NSNotification *)noti{
    
    if ([noti.object integerValue]==CBPeripheralStateDisconnected) {
        
        [self queryCar];
        
    }
}

#pragma mark - 查询车辆状态
- (void)queryCarState{
    
    //判断tcp是否登录以及是否处于连接状态tcp，如果tcp连接就不走tcp查询，如果没有就走http查询
    if(![[FZKTCPClient shareTCPClient]connectState]){
        [self queryCar];
        
    }
    
}



- (void)queryCar{
    
    FZKBVehicleStatusHttpAction *work =[[FZKBVehicleStatusHttpAction alloc] init];
    
    
    [work vehicleStatusActionWithVehicleID:@(kCurrentCarModleId)];
    
    //    [work addInterceptor:[SRInterceptorUtil buildLoading:@"正在查询车辆状态........" With:nil]];
    //    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
    [work onSuncc:^(FZKActionResult *result) {
        
        if(result.paramters[@"entity"]){
            
            [FZKTCarStateManager parseResponse:result.paramters[@"entity"] type:SRCarStateParseTypeHTTP];
            
            
        }
        
    }];
    
    [work onError:^(FZKActionResult *result) {
        
    }];
    
    [work run];
}

#pragma mark - 定时器

- (NSTimer *)timer{
    
    if (!_timer) {
        
        _timer = [NSTimer timerWithTimeInterval:5.0 target:self selector:@selector(queryCarState) userInfo:nil repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:kCFRunLoopCommonModes];
    }
    return _timer;
}



/**
 暂停定时器
 */
- (void)stopTime{
    
    [self.timer invalidate];
    self.timer = nil;
}


/**
 开启定时器
 */
- (void)startTime{
    [self.timer fire];
}

- (void)applicationDidBecomeActiveNotification{
    
    [self applicationDidBecomeActiveNotification:kCurrentCarModleId];
    
}

- (void)applicationDidBecomeActiveNotification:(NSInteger)carId{
    
    //判断展车模式
    //    if(){
    //        return;
    //    }
    
    if ([FZKCUserDefaults isLogin]) {
        
        if (![[FZKTCPClient shareTCPClient] connectState]) {
            [[FZKTCPClient shareTCPClient]connect];
        }
        if (![[FZKTBluetoothManager shareBluetoothManager]canSendDataToTerminal] || carid!=carId) {
            carid = carId;
            [[FZKTBluetoothManager shareBluetoothManager]connect:[FZKTCarStateManager getCurrentBleMac:carid]];
        }
        
        
        [self startTime];
        
    }
    
}



- (void)applicationDidLoginout{
    
    [self stopTime];
    
    carid = 0;
    
    if ([[FZKTCPClient shareTCPClient] connectState]) {
        [[FZKTCPClient shareTCPClient]disconnect];
    }
    
    if ([[FZKTBluetoothManager shareBluetoothManager]canSendDataToTerminal]) {
        [[FZKTBluetoothManager shareBluetoothManager] disConnect];
    }
    
}


+ (FZKTBluetoothInfoModel *)getCurrentBleMac:(NSInteger)carId{
    
    for (FZKBTotalInfosModel *model in [FZKBLoginModel share].totalInfos) {
        if (model.vehicleBasicInfo.vehicleID == carId) {
            FZKTBluetoothInfoModel *bleInfo = model.vehicleBasicInfo.bluetooth;
            bleInfo.carId = model.vehicleBasicInfo.vehicleID;
            return bleInfo;
        }
    }
    return nil;
    
}



+ (void)parseResponse:(id)responses type:(SRCarStateParseType)type{
    
    
    
    FZKBVehicleStatusInfoModel *statusInfo = [FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel];
    
    if (SRCarStateParseTypeHTTP ==type) {
        
        FZKBVehicleStatusInfoModel *model = [FZKBVehicleStatusInfoModel mj_objectWithKeyValues:responses];
        
        statusInfo = model;
        
    }else if (SRCarStateParseTypeTCP ==type){
        BOOL isValidLocation = NO;
        double lat = 0;
        double lng = 0;
        FZKTCPResponse *tcp = (FZKTCPResponse *)responses;
        
        //        FZKBVehicleBasicInfoModel *basicInfo = [FZKBVehicleBasicInfoModel shareVehicleBasicInfoModel];
        //        FZKBVehicleStatusInfoModel *statusInfo = [FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel];
        
        for (FZKTLV *parameter in [FZKTLV mj_objectArrayWithKeyValuesArray:tcp.body.parameters ]) {
            switch (parameter.tag) {
                ////////////////////状态
                case TLVTag_Synchronous_Online:    //12289
                statusInfo.isOnline = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_GPS_Stars: //12291
                statusInfo.startNumber = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Engine:    //12292
                statusInfo.engineStatus = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Defence:   //12293
                statusInfo.defence = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_ACC:   //12294
                statusInfo.aCC = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_DoorLock:  //12295
                statusInfo.doorLock = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_ElectricityStatus: //12297
                statusInfo.electricityStatus = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Electricity:   //12298
                statusInfo.electricity = [parameter.value doubleValue];
                break;
                case TLVTag_Synchronous_Mileage:   //12299
                statusInfo.mileAge = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_CarRun:    //12301
                //                statusInfo.carRun = [parameter.value intValue];
                break;
                
                case TLVTag_Synchronous_GPS_Lat:   //12303
                lat = [parameter.value doubleValue];
                break;
                case TLVTag_Synchronous_GPS_Lng:   //12304
                lng = [parameter.value doubleValue];
                break;
                case TLVTag_Synchronous_GPS_Speed: //12305
                statusInfo.speed = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_TemperatureStatus: //12307
                statusInfo.tempStatus = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Temperature:   //12308
                statusInfo.temp = [parameter.value floatValue];
                break;
                case TLVTag_Synchronous_GPS:   //12309
                statusInfo.gpsStatus = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_GPRS:  //12310
                statusInfo.signalStrength = [parameter.value intValue];
                break;
                //                case TLVTag_Synchronous_OBD:   //12317
                //                basicInfo.hasOBDModule = [parameter.value boolValue];
                break;
                case TLVTag_Synchronous_Oil:   //12312
                statusInfo.oil = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_GPS_WEAK:  //12320
                statusInfo.sleepStatus = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Alarm: //16390
                //                [self parseAlarmString:parameter.value];
                break;
                
                
                case TLVTag_Event_Message: //17152
                
                break;
                ////////////////////高端车型
                case TLVTag_Synchronous_Door_LF:   //12342
                statusInfo.doorLF = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Door_LB:   //12343
                statusInfo.doorLB = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Door_RF:   //12344
                statusInfo.doorRF = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Door_RB:   //12345
                statusInfo.doorRB = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Door_Trunck:   //12345
                statusInfo.trunkDoor = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Window_LF: //12347
                statusInfo.windowLF = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Window_LB: //12348
                statusInfo.windowLB = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Window_RF: //12349
                statusInfo.windowRF = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Window_RB: //12350
                statusInfo.windowRB = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Window_Sky:    //12351
                statusInfo.windowSky = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Light_Big: //12352
                statusInfo.lightBig = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_Light_Little:  //12353
                statusInfo.lightSmall = [parameter.value intValue];
                break;
                case TLVTag_Synchronous_LeftOil_Litter:    //12354
                statusInfo.oilLeft = [parameter.value doubleValue];
                break;
                
                
                default:
                break;
            }
            
        }
        
        if (isValidLocation && lat > 0 && lng > 0) {
            statusInfo.lat = lat;
            statusInfo.lng = lng;
        }
        
        
        
        
        
        //        [basicInfo archive];
        [statusInfo archive];
        
        
        
    }else{
        
        SRBLEReceivedData *ble = (SRBLEReceivedData *)responses;
        
        statusInfo.engineStatus = ble.vehicleStatus.engine;
        statusInfo.doorLF    = ble.vehicleStatus.doorLF;
        statusInfo.doorRF    = ble.vehicleStatus.doorRF;
        statusInfo.doorLB    = ble.vehicleStatus.doorLB;
        statusInfo.doorRB    = ble.vehicleStatus.doorRB;
        //        model.trunkDoor = response.vehicleStatus.trunkDoor;
        //        model.windowLF  = response.vehicleStatus.windowLF;
        //        model.windowRF  = response.vehicleStatus.windowRF;
        //        model.windowLB  = response.vehicleStatus.windowLB;
        //        model.windowRB  = response.vehicleStatus.windowRB;
        //        model.windowSky = response.vehicleStatus.windowSky;
        //        model.lightBig  = response.vehicleStatus.lightBig;
        //        model.lightSmall= response.vehicleStatus.lightSmall;
        statusInfo.doorLock  = ble.vehicleStatus.doorLock;
        statusInfo.isOnline  = 1;
        
    }
    
    [statusInfo archive];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //添加刷新界面通知
        [[NSNotificationCenter defaultCenter]postNotificationName:kCarControlNotification object:nil];
    });
    
    
}

@end
