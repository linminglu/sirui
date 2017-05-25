
//
//  FZKBQueryFenceAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryFenceAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBQueryFenceAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"entity":{"isInFence":0,"fenceCentralLng":-1,"fenceCentralLat":-1,"radius":0},"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 查询围栏
 
 传入参数：
input1:用户名
input2:密码
vehicleID:车辆ID


返回参数：
isInFence：是否在围栏内 2表示不在围栏内，其他表示在围栏内
fenceCentralLng：围栏中心点纬度
fenceCentralLat：围栏中心点经度
resultCode：返回结果code 0表示成功
resultMessage：返回结果信息
 */
+ (void)queryFenceActionWithInput1:(NSString *)input1 input2:(NSString *)input2 vehicleID:(NSString *)vehicleID success:(Action1)success fail:(Action1)fail
{
    FZKBQueryFenceAction *work =[[FZKBQueryFenceAction alloc] init];
    

    [work queryFenceActionWithInput1:input1 input2:input2 vehicleID:vehicleID];
    
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
