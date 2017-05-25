
//
//  FZKBQueryTripListHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryTripListHttpAction.h"


@implementation FZKBQueryTripListHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/gateway/trip/query",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"option":{},"pageResult":{"entityList":[{"avgFuelCons":7.4043297685573295,"endLat":0.0,"endLng":0.0,"endTime":"2017-04-27 23:57:34","fee":12.609395891938686,"fuelCons":1.942896131269443,"isEffective":false,"mileage":26.240000000000002,"startLat":0.0,"startLng":0.0,"startTime":"2017-04-27 23:15:32","tripID":"56969933","vehicleID":0}],"pageIndex":1,"pageSize":30,"totalCount":1,"totalPage":1},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 查询轨迹列表
 
 传入参数
 vehicleID：车辆ID
 pageIndex：第几页
 pageSize：一页多少条数据
 startTime：开始时间
 endTime：结束时间
 */
- (void)queryTripListActionWithVehicleID:(NSString *)vehicleID input1:(NSString *)input1 input2:(NSString *)input2 pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize startTime:(NSString *)startTime endTime:(NSString *)endTime
{
    [self addPara:@"vehicleID" withValue:vehicleID];
    [self addPara:@"input1" withValue:input1];
    [self addPara:@"input2" withValue:input2];
    [self addPara:@"pageIndex" withValue:pageIndex];
    [self addPara:@"pageSize" withValue:pageSize];
    [self addPara:@"startTime" withValue:startTime];
    [self addPara:@"endTime" withValue:endTime];
    
    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/gateway/trip/query";
    
    
}

@end
