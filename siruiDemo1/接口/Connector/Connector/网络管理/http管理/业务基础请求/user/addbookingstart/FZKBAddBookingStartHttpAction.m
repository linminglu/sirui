
//
//  FZKBAddBookingStartHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBAddBookingStartHttpAction.h"


@implementation FZKBAddBookingStartHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/startClock/add",KBaseUrl];
//}



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
- (void)addBookingStartActionWithType:(NSString *)type vehicleID:(NSString *)vehicleID startTime:(NSString *)startTime isRepeat:(NSString *)isRepeat startTimeLength:(NSString *)startTimeLength repeatType:(NSString *)repeatType isOpen:(NSString *)isOpen
{
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
    self.smk_path = @"/basic/startClock/add";

    
}

@end
