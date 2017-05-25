
//
//  FZKBGetAuthCodeRegisterAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBGetAuthCodeRegisterAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBGetAuthCodeRegisterAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"option":{"authCode":"4593"},"result":{"resultCode":0,"resultMessage":"发送成功"}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 注册获取验证码
 
 传入参数
phone：手机号
返回值
authCode：验证码
resultCode：返回结果码，0：成功，其它：失败
resultMessage：返回结果信息
 */
+  (void)getAuthCodeRegisterActionWithPhone:(NSString *)phone fromRegist:(NSString *)fromRegist  type:(NSString *)type success:(Action1)success fail:(Action1)fail
{
    FZKBGetAuthCodeRegisterAction *work =[[FZKBGetAuthCodeRegisterAction alloc] init];
    

    [work getAuthCodeRegisterActionWithPhone:phone fromRegist:@"1" type:@"1"];
    
    [SVProgressHUD showWithStatus:nil];
    
    [work onSuncc:^(FZKActionResult *result) {
        

        success(result.paramters);
        
    }];
    
    [work onError:^(FZKActionResult *result) {

        
             [SVProgressHUD showErrorWithStatus:result.resultMessage];
        fail(result.resultMessage);
   
        
        
    }];
    
    [work run];
    
}



@end
