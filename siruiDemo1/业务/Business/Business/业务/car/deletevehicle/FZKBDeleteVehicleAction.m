
//
//  FZKBDeleteVehicleAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBDeleteVehicleAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBDeleteVehicleAction


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
 删除车辆
 
 传入参数
input1：用户名（需加密）
input2：用户密码（需加密）
vehicleID：车id
返回值
resultCode:返回结果码 0表示成功 其他表示失败
 */
+ (void)deleteVehicleActionWithInput1:(NSString *)input1 input2:(NSString *)input2 vehicleID:(NSString *)vehicleID success:(Action1)success fail:(Action1)fail
{
    FZKBDeleteVehicleAction *work =[[FZKBDeleteVehicleAction alloc] init];
    

    [work deleteVehicleActionWithInput1:input1 input2:input2 vehicleID:vehicleID];
    
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
