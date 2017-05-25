
//
//  FZKBDeleteVehicleHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBDeleteVehicleHttpAction.h"


@implementation FZKBDeleteVehicleHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/car/deleteByVehicleID",KBaseUrl];
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
 删除车辆
 
 传入参数
input1：用户名（需加密）
input2：用户密码（需加密）
vehicleID：车id
返回值
resultCode:返回结果码 0表示成功 其他表示失败
 */
- (void)deleteVehicleActionWithInput1:(NSString *)input1 input2:(NSString *)input2 vehicleID:(NSString *)vehicleID
{
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 
	[self addPara:@"vehicleID" withValue:vehicleID]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/car/deleteByVehicleID";

    
}

@end
