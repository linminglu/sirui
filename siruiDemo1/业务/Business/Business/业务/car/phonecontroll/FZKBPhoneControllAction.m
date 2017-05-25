
//
//  FZKBPhoneControllAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBPhoneControllAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"
#import "FZKBTools.h"
#import <Connector/FZKBLoginModel.h>
#import "UUID.h"
#import <FZKTools.h>
#import <Connector/FZKBKeychain.h>
#import <Connector/FZKTPhoneControllBleAction.h>
#import <Connector/FZKTBluetoothManager.h>

@implementation FZKBPhoneControllAction
{
    //是否已经返回
 BOOL  isBack;
    
}

/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}




/**
 方法描述：
 发送车控制指令给服务器
 
 传入参数:
 
 @param carId 车id
 @param tag 命令行
 @param pwd 用户密码
 @param success
 @param fail
 */

- (void)phoneControllActionWithCarId:(NSInteger)carId tag:(NSInteger)tag controlSeries:(NSInteger)controlSeries success:(Action1)success fail:(Action1)fail
{
    isBack = NO;
    
    
//    NSLog(@"suness:%@,fail:%@",success,fail);
    
    if ([[FZKTBluetoothManager shareBluetoothManager] canSendDataToTerminal] && [FZKTBluetoothManager shareBluetoothManager].carId==carId) {
     //首先判断蓝牙是否可以连接
        FZKTPhoneControllBleAction *blework = [FZKTPhoneControllBleAction new];
        [blework phoneControllActionWithtag:tag];
        [blework onSuncc:^(FZKActionResult *result) {
            
            [self actionCallBack:result successOrFail:success];
            NSLog(@"成功指令地址：%@",success);
        }];
        [blework onError:^(FZKActionResult *result) {
            
            [self actionCallBack:result successOrFail:fail];
            NSLog(@"失败指令地址：%@",fail);
        }];
        
        [blework run];
        return;
        
    }
    
    FZKBPhoneControllHttpAction *httpwork =[[FZKBPhoneControllHttpAction alloc] init];
    
    NSString *input1 = [NSString stringWithFormat:@"%zd_%zd_%@",carId,tag,[FZKBLoginModel share].customer.name].RSAEncode;
    NSString *input2 = [FZKBKeychain Password];
    NSString *input3 = [FZKBKeychain UUID].RSAEncode;
    NSString *input4 = @(controlSeries).stringValue.RSAEncode;
    
    [httpwork phoneControllActionWithInput1:input1 input2:input2 input3:input3 input4:input4 app:@"SR_iOS"];
    
//    [work addInterceptor:[SRInterceptorUtil buildLoading:@"......." With:nil]];
//    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
    [httpwork onSuncc:^(FZKActionResult *result) {
        
        [self actionCallBack:result successOrFail:success];
        
    }];
    
    [httpwork onError:^(FZKActionResult *result) {

       [self actionCallBack:result successOrFail:fail];

        
    }];
    
    [httpwork run];
    
    
    FZKTPhoneControllTCPAction *tcpwork = [FZKTPhoneControllTCPAction new];
    
    [tcpwork phoneControllActionWithCarId:carId tag:tag controlSeries:controlSeries];
    
    [tcpwork onSuncc:^(FZKActionResult *result) {
        [self actionCallBack:result successOrFail:success];
    }];
    
    [tcpwork onError:^(FZKActionResult *result) {
        [self actionCallBack:result successOrFail:fail];
    }];
    
    [tcpwork run];
}


- (void)actionCallBack:(FZKActionResult *)result successOrFail:(Action1)action{
    
    if (action && !isBack) {
       
        action(result);
    }
    isBack = YES;
}

@end
