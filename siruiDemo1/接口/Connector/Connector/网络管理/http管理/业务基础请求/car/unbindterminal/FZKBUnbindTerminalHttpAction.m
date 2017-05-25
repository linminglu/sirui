
//
//  FZKBUnbindTerminalHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBUnbindTerminalHttpAction.h"


@implementation FZKBUnbindTerminalHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/car/unbindByVehicleID",KBaseUrl];
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
 我的爱车（解绑终端//主机编码）
 
 传入参数
input1：用户名（需加密）
input2：用户密码（需加密）
vehicleID：车辆id
type：类型 1表示解绑终端 2表示解绑蓝牙
返回值
resultCode：返回结果码 0表示成功 其它表示失败 
 */
- (void)unbindTerminalActionWithInput1:(NSString *)input1 input2:(NSString *)input2 vehicleID:(NSString *)vehicleID type:(NSString *)type
{
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 
	[self addPara:@"vehicleID" withValue:vehicleID]; 
	[self addPara:@"type" withValue:type]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/car/unbindByVehicleID";

    
}

@end
