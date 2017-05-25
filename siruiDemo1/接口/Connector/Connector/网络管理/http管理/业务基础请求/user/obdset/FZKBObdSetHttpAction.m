
//
//  FZKBObdSetHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBObdSetHttpAction.h"


@implementation FZKBObdSetHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/car/updateSyncObd",KBaseUrl];
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
 诊断设置
 
 传入参数：
vehicleID：车辆ID
openObd：1表示开启，2表示关闭


返回参数：
resultCode：0表示成功，其他表示失败
 */
- (void)obdSetActionWithVehicleID:(NSString *)vehicleID openObd:(NSString *)openObd
{
	[self addPara:@"vehicleID" withValue:vehicleID]; 
	[self addPara:@"openObd" withValue:openObd]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/car/updateSyncObd";

    
}

@end
