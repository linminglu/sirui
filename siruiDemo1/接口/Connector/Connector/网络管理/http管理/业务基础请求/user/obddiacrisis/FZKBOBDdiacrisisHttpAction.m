
//
//  FZKBOBDdiacrisisHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBOBDdiacrisisHttpAction.h"


@implementation FZKBOBDdiacrisisHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/car/dtcInfo",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"option":{},"pageResult":{"pageIndex":1,"pageSize":10,"totalCount":0,"totalPage":0},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 OBD诊断（只是给一个在发指令，和指令响应的效果）
 
 传入参数：
vehicleID：车辆ID

返回参数：

resultCode：0表示成功
其他参数在此接口中没有意义（用不到）

 */
- (void)oBDdiacrisisActionWithVehicleID:(NSString *)vehicleID
{
	[self addPara:@"vehicleID" withValue:vehicleID]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/car/dtcInfo";

    
}

@end
