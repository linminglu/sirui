
//
//  FZKBUpdateBookingStartHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBUpdateBookingStartHttpAction.h"


@implementation FZKBUpdateBookingStartHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/startClock/update",KBaseUrl];
//}



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
- (void)updateBookingStartActionWithStartClockID:(NSString *)startClockID type:(NSString *)type vehicleID:(NSString *)vehicleID startTime:(NSString *)startTime isRepeat:(NSString *)isRepeat startTimeLength:(NSString *)startTimeLength repeatType:(NSString *)repeatType isOpen:(NSString *)isOpen
{
	[self addPara:@"startClockID" withValue:startClockID]; 
	[self addPara:@"type" withValue:type]; 
	[self addPara:@"vehicleID" withValue:vehicleID]; 
	[self addPara:@"startTime" withValue:startTime]; 
	[self addPara:@"isRepeat" withValue:isRepeat]; 
	[self addPara:@"startTimeLength" withValue:startTimeLength]; 
	[self addPara:@"repeatType" withValue:repeatType]; 
	[self addPara:@"isOpen" withValue:isOpen]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/startClock/update";

    
}

@end
