
//
//  FZKBQueryFenceHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryFenceHttpAction.h"


@implementation FZKBQueryFenceHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/car/queryFenceRadius",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"entity":{"isInFence":0,"fenceCentralLng":-1,"fenceCentralLat":-1,"radius":0},"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 查询围栏
 
 传入参数：
input1:用户名
input2:密码
vehicleID:车辆ID


返回参数：
isInFence：是否在围栏内 2表示不在围栏内，其他表示在围栏内
fenceCentralLng：围栏中心点纬度
fenceCentralLat：围栏中心点经度
resultCode：返回结果code 0表示成功
resultMessage：返回结果信息
 */
- (void)queryFenceActionWithInput1:(NSString *)input1 input2:(NSString *)input2 vehicleID:(NSString *)vehicleID
{
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 
	[self addPara:@"vehicleID" withValue:vehicleID]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/car/queryFenceRadius";

    
}

@end
