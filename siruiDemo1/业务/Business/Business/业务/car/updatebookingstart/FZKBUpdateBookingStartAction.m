
//
//  FZKBUpdateBookingStartAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBUpdateBookingStartAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBUpdateBookingStartAction


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
 修改预约启动
 
 传入参数：
startClockID：闹钟ID
type：0.自定义 1.上班 2.回家
vehicleID：车辆ID
startTime：开启时间
isRepeat：是否重复
startTimeLength：启动时长
repeatType：/重复类型(0000000，7位，分别表示周一到周日，0为关闭，1为开启)
isOpen：是否开启

返回参数：
resultCode：0表示成功



 */
+ (void)updateBookingStartActionWithStartClockID:(NSString *)startClockID type:(NSString *)type vehicleID:(NSString *)vehicleID startTime:(NSString *)startTime isRepeat:(NSString *)isRepeat startTimeLength:(NSString *)startTimeLength repeatType:(NSString *)repeatType isOpen:(NSString *)isOpen success:(Action1)success fail:(Action1)fail
{
    FZKBUpdateBookingStartAction *work =[[FZKBUpdateBookingStartAction alloc] init];
    

    [work updateBookingStartActionWithStartClockID:startClockID type:type vehicleID:vehicleID startTime:startTime isRepeat:isRepeat startTimeLength:startTimeLength repeatType:repeatType isOpen:isOpen];
    
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
