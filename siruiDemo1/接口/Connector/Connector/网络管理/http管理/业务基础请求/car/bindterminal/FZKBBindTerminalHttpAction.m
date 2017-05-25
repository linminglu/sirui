
//
//  FZKBBindTerminalHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBBindTerminalHttpAction.h"


@implementation FZKBBindTerminalHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/customer/bindTerminal",KBaseUrl];
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
 添加车辆
 
 传入参数
 vehicleModelID：车型
 imei：终端imei
 vin:车架号（可以为null）
 plateNumber：车牌号（可以为null）
 
 返回值：
 resultCode：结果码 0表示成功 其它表示失败
 */
- (void)bindTerminalActionWithVehicleModelID:(NSString *)vehicleModelID imei:(NSString *)imei vin:(NSString *)vin plateNumber:(NSString *)plateNumber input1:(NSString *)input1 input2:(NSString *)input2
{
    [self addPara:@"vehicleModelID" withValue:vehicleModelID];
    [self addPara:@"imei" withValue:imei];
    [self addPara:@"vin" withValue:vin];
    [self addPara:@"plateNumber" withValue:plateNumber];
    [self addPara:@"input1" withValue:input1];
    [self addPara:@"input2" withValue:input2];
    
    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/customer/bindTerminal";
    
    
}

@end
