
//
//  FZKBOBDdiacrisisAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBOBDdiacrisisAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBOBDdiacrisisAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"option":{},"pageResult":{"pageIndex":1,"pageSize":10,"totalCount":0,"totalPage":0},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 OBD诊断（只是给一个在发指令，和指令响应的效果）
 
 传入参数：
vehicleID：车辆ID

返回参数：

resultCode：0表示成功
其他参数在此接口中没有意义（用不到）

 */
+ (void)oBDdiacrisisActionWithVehicleID:(NSString *)vehicleID success:(Action1)success fail:(Action1)fail
{
    FZKBOBDdiacrisisAction *work =[[FZKBOBDdiacrisisAction alloc] init];
    

    [work oBDdiacrisisActionWithVehicleID:vehicleID];
    
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
