
//
//  FZKBAddNewCarHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBAddNewCarHttpAction.h"


@implementation FZKBAddNewCarHttpAction


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
 添加车辆（按操作流程获取参数）
 
 传入参数：
vehicleModelID：车辆实例ID
imei：终端编号
返回参数：
resultCode：0表示成功
 */
- (void)addNewCarActionWithVehicleModelID:(NSString *)vehicleModelID imei:(NSString *)imei
{
	[self addPara:@"vehicleModelID" withValue:vehicleModelID]; 
	[self addPara:@"imei" withValue:imei]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/customer/bindTerminal";

    
}

@end
