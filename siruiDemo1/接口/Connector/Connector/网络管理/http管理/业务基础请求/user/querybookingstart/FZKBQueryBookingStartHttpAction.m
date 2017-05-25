
//
//  FZKBQueryBookingStartHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryBookingStartHttpAction.h"


@implementation FZKBQueryBookingStartHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/startClock/query",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"option":{},"pageResult":{"entityList":[{"customerID":18293,"isOpen":true,"isRepeat":false,"repeatType":"0000000","startClockID":2443,"startTime":"2016-09-30 10:20:00","startTimeLength":5,"type":0,"vehicleID":17482},{"customerID":18293,"isOpen":true,"isRepeat":false,"repeatType":"0000000","startClockID":3739,"startTime":"2017-03-24 09:08:00","startTimeLength":5,"type":0,"vehicleID":17670}],"pageIndex":1,"pageSize":2147483647,"totalCount":2,"totalPage":1},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 查询预约启动车辆信息
 
 返回值：
customerID：用户ID
isOpen：是否开启启动功能（true false）
isRepeat：是否重复（就像闹钟一样，ture false）
repeatType：重复类型(0000000，7位，分别表示周一到周日，0为关闭，1为开启)
startClockID：闹钟ID
startTime：开启时间
startTimeLength：启动时长（多久之后启动）
type：0.自定义 1.上班 2.回家
vehicleID：车辆ID
pageIndex：页面索引(1) 
pageSize：没用到
totalCount：item数目
totalPage：没用到
resultCode：0表示成功
 */
- (void)queryBookingStartAction
{

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/startClock/query";

    
}

@end
