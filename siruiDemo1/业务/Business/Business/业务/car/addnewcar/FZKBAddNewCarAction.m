
//
//  FZKBAddNewCarAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBAddNewCarAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBAddNewCarAction


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
 添加车辆（按操作流程获取参数）
 
 传入参数：
vehicleModelID：车辆实例ID
imei：终端编号
返回参数：
resultCode：0表示成功
 */
+ (void)addNewCarActionWithVehicleModelID:(NSString *)vehicleModelID imei:(NSString *)imei success:(Action1)success fail:(Action1)fail
{
    FZKBAddNewCarAction *work =[[FZKBAddNewCarAction alloc] init];
    

    [work addNewCarActionWithVehicleModelID:vehicleModelID imei:imei];
    
    [work addInterceptor:[SRInterceptorUtil buildLoading:@"正在添加车辆........" With:nil]];
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
