
//
//  FZKBQueryTripListAction.h
//
//
//  Created by mac on date.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Connector/FZKBQueryTripListHttpAction.h>

@interface FZKBQueryTripListAction : FZKBQueryTripListHttpAction
    
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
+ (void)queryTripListActionWithSelectTime:(NSString *)time success:(Action1)success fail:(Action1)fail;

@end
