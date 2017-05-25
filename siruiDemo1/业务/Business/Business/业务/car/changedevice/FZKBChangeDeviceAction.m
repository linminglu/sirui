
//
//  FZKBChangeDeviceAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBChangeDeviceAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBChangeDeviceAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"option":{},"result":{"resultCode":0}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 我的爱车（绑定或更换蓝牙）(绑定或更换终端)
 
 传入参数：
input1：用户名（需加密）
input2：用户密码（需加密）
vehicleID：车辆id
imei：蓝牙或者终端有各自的对应的imei号
返回值：
resultCode：结果码 0表示成功 其它表示失败
 */
+ (void)changeDeviceActionWithInput1:(NSString *)input1 input2:(NSString *)input2 vehicleID:(NSString *)vehicleID imei:(NSString *)imei success:(Action1)success fail:(Action1)fail
{
    FZKBChangeDeviceAction *work =[[FZKBChangeDeviceAction alloc] init];
    

    [work changeDeviceActionWithInput1:input1 input2:input2 vehicleID:vehicleID imei:imei];
    
    [work addInterceptor:[SRInterceptorUtil buildLoading:@"这里填写自己的........" With:nil]];
    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
    [work onSuncc:^(FZKActionResult *result) {

        success(result.paramters);
        
    }];
    
    [work onError:^(FZKActionResult *result) {

        fail(result.resultMessage);
        [SVProgressHUD showErrorWithStatus:result.resultMessage];
        
        
    }];
    
    [work run];
    
}



@end
