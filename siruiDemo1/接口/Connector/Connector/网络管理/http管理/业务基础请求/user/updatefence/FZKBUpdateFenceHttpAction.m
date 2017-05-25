
//
//  FZKBUpdateFenceHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBUpdateFenceHttpAction.h"


@implementation FZKBUpdateFenceHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/car/updateFenceRadius",KBaseUrl];
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
 更新围栏半径
 
 传入参数：
input1：用户名
input2：密码
vehicleID：车辆ID
radius：围栏半径
返回参数
resultCode： 0表示成功，其他表示失败
 */
- (void)updateFenceActionWithInput1:(NSString *)input1 input2:(NSString *)input2 vehicleID:(NSString *)vehicleID radius:(NSString *)radius
{
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 
	[self addPara:@"vehicleID" withValue:vehicleID]; 
	[self addPara:@"radius" withValue:radius]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/car/updateFenceRadius";

    
}

@end
