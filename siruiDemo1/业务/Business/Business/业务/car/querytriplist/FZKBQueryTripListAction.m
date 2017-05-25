
//
//  FZKBQueryTripListAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryTripListAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"
#import <Connector/FZKCUserDefaults.h>
#import <Connector/FZKBKeychain.h>
#import <Connector/NSDate+Utilities.h>


@implementation FZKBQueryTripListAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


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
+ (void)queryTripListActionWithSelectTime:(NSString *)time success:(Action1)success fail:(Action1)fail
{
    FZKBQueryTripListAction *work =[[FZKBQueryTripListAction alloc] init];
    
    NSString *start = [NSDate getUTCTimeFromLocalTimeString:[NSString stringWithFormat: @"%@ 00:00:00",@"2017-4-1" ]];
    NSString *end   = [NSDate getUTCTimeFromLocalTimeString:[NSString stringWithFormat:@"%@ 23:59:59",@"2017-5-15"]];
        
        
    [work queryTripListActionWithVehicleID:[NSString stringWithFormat:@"%ld", [FZKCUserDefaults currentVehicleID] ] input1:[FZKBKeychain UserName] input2:[FZKBKeychain Password] pageIndex:@"1" pageSize:@"20" startTime:start endTime:end];
    
//    [work addInterceptor:[SRInterceptorUtil buildLoading:@"这里填写自己的........" With:nil]];
//    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
    [work onSuncc:^(FZKActionResult *result) {

        success( [[result.paramters objectForKey:@"pageResult"] objectForKey:@"entityList"]);
        
    }];
    
    [work onError:^(FZKActionResult *result) {

        fail(result.resultMessage);
        [SVProgressHUD showErrorWithStatus:result.resultMessage];
        
        
    }];
    
    [work run];
    
}



@end
