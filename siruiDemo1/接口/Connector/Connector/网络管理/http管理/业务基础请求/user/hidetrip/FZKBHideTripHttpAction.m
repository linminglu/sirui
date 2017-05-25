
//
//  FZKBHideTripHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBHideTripHttpAction.h"


@implementation FZKBHideTripHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/car/hideTrip",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"option":{},"result":{"resultCode":0，“resultMessage”：“请求成功”}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 隐藏行踪
 
 传入参数：
vehicleID：车辆ID
isHidden：0表示显示，1表示隐藏
返回参数
resultMessage：返回结果信息
resultCode：0表示成功，其他表示失败
 */
- (void)hideTripActionWithVehicleID:(NSString *)vehicleID isHidden:(NSString *)isHidden
{
	[self addPara:@"vehicleID" withValue:vehicleID]; 
	[self addPara:@"isHidden" withValue:isHidden]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/car/hideTrip";

    
}

@end
