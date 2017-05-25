
//
//  FZKBDeleteBookingStartAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBDeleteBookingStartAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBDeleteBookingStartAction


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
 删除预约启动
 
 传入参数：
startClockID：需要删除的闹钟的ID

返回参数：
resultCode：0表示成功
 */
+ (void)deleteBookingStartActionWithStartClockID:(NSString *)startClockID success:(Action1)success fail:(Action1)fail
{
    FZKBDeleteBookingStartAction *work =[[FZKBDeleteBookingStartAction alloc] init];
    

    [work deleteBookingStartActionWithStartClockID:startClockID];
    
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
