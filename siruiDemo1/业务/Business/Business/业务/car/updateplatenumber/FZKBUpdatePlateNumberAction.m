
//
//  FZKBUpdatePlateNumberAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBUpdatePlateNumberAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBUpdatePlateNumberAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


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
+ (void)updatePlateNumberActionWithInput1:(NSString *)input1 input2:(NSString *)input2 plateNumber:(NSString *)plateNumber entityID:(NSString *)entityID vehicleModelID:(NSString *)vehicleModelID success:(Action1)success fail:(Action1)fail
{
    FZKBUpdatePlateNumberAction *work =[[FZKBUpdatePlateNumberAction alloc] init];
    

    [work updatePlateNumberActionWithInput1:input1 input2:input2 plateNumber:plateNumber entityID:entityID vehicleModelID:vehicleModelID];
    
    [work addInterceptor:[SRInterceptorUtil buildLoading:@"这里填写自己的........" With:nil]];
    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
    [work onSuncc:^(FZKActionResult *result) {

        success(result.paramters);
        
    }];
    
    [work onError:^(FZKActionResult *result) {

        fail(result.resultMessage);
        [SVProgressHUD showErrorWithStatus:result.resultMessage];
        
        
    }];
    
    [work run];
    
}



@end
