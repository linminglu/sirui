
//
//  FZKBAddBookingStartAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBAddBookingStartAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBAddBookingStartAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"entity":3767,"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 添加预约启动
 
 传入参数：
type：0.自定义 1.上班 2.回家
vehicleID：车辆ID
startTime：开启时间
isRepeat：是否需要重复（true false）
startTimeLength：启动时长
repeatType：重复类型(0000000，7位，分别表示周一到周日，0为关闭，1为开启


返回参数：
resultCode：0表示成功
entity:等价于startClockID ：闹钟ID
 */
+ (void)addBookingStartActionWithType:(NSString *)type vehicleID:(NSString *)vehicleID startTime:(NSString *)startTime isRepeat:(NSString *)isRepeat startTimeLength:(NSString *)startTimeLength repeatType:(NSString *)repeatType isOpen:(NSString *)isOpen success:(Action1)success fail:(Action1)fail
{
    FZKBAddBookingStartAction *work =[[FZKBAddBookingStartAction alloc] init];
    

    [work addBookingStartActionWithType:type vehicleID:vehicleID startTime:startTime isRepeat:isRepeat startTimeLength:startTimeLength repeatType:repeatType isOpen:isOpen];
    
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
