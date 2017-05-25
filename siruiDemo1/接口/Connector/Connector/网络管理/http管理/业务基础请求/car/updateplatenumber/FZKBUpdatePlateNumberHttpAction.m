
//
//  FZKBUpdatePlateNumberHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBUpdatePlateNumberHttpAction.h"


@implementation FZKBUpdatePlateNumberHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/car/updateByPhone",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"option":{},"result":{"resultCode":0,"resultMessage":"操作成功"}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 我的爱车（车牌号修改）
 
 传入参数：
input1:用户名（需加密）
input2:用户密码（需加密）
plateNumber:（车牌号）
entityID:品牌id
vehicleModelID:车型id

返回值：
resultCode：结果码 0表示成功 其它表示失败
resultMessage：返回结果信息
 */
- (void)updatePlateNumberActionWithInput1:(NSString *)input1 input2:(NSString *)input2 plateNumber:(NSString *)plateNumber entityID:(NSString *)entityID vehicleModelID:(NSString *)vehicleModelID
{
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 
	[self addPara:@"plateNumber" withValue:plateNumber]; 
	[self addPara:@"entityID" withValue:entityID]; 
	[self addPara:@"vehicleModelID" withValue:vehicleModelID]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/car/updateByPhone";

    
}

@end
