
//
//  FZKBBindTerminalAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBBindTerminalAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"
#import <Connector/FZKBKeychain.h>


@implementation FZKBBindTerminalAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
//    车辆测试数据 以后删除
//    [[NSUserDefaults standardUserDefaults]setObject:@"28943" forKey:@"kSelectCarId"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
    
}


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
+ (void)bindTerminalActionWithVehicleModelID:(NSString *)vehicleModelID imei:(NSString *)imei vin:(NSString *)vin plateNumber:(NSString *)plateNumber success:(Action1)success fail:(Action1)fail
{
    FZKBBindTerminalAction *work =[[FZKBBindTerminalAction alloc] init];
    
    
    [work bindTerminalActionWithVehicleModelID:vehicleModelID imei:imei vin:vin plateNumber:plateNumber input1:[FZKBKeychain UserName] input2:[FZKBKeychain Password]];
    
//    [work addInterceptor:[SRInterceptorUtil buildLoading:@"添加车辆........" With:nil]];
//    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
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
