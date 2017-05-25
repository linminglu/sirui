
//
//  FZKBHideTripAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBHideTripAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBHideTripAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"option":{},"result":{"resultCode":0，“resultMessage”：“请求成功”}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 隐藏行踪
 
 传入参数：
vehicleID：车辆ID
isHidden：0表示显示，1表示隐藏
返回参数
resultMessage：返回结果信息
resultCode：0表示成功，其他表示失败
 */
+ (void)hideTripActionWithVehicleID:(NSString *)vehicleID isHidden:(NSString *)isHidden success:(Action1)success fail:(Action1)fail
{
    FZKBHideTripAction *work =[[FZKBHideTripAction alloc] init];
    

    [work hideTripActionWithVehicleID:vehicleID isHidden:isHidden];
    
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
