
//
//  FZKBUpdateFenceAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBUpdateFenceAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBUpdateFenceAction


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
 更新围栏半径
 
 传入参数：
input1：用户名
input2：密码
vehicleID：车辆ID
radius：围栏半径
返回参数
resultCode： 0表示成功，其他表示失败
 */
+ (void)updateFenceActionWithInput1:(NSString *)input1 input2:(NSString *)input2 vehicleID:(NSString *)vehicleID radius:(NSString *)radius success:(Action1)success fail:(Action1)fail
{
    FZKBUpdateFenceAction *work =[[FZKBUpdateFenceAction alloc] init];
    

    [work updateFenceActionWithInput1:input1 input2:input2 vehicleID:vehicleID radius:radius];
    
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
