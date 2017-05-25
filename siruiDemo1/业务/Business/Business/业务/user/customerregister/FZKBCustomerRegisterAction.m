
//
//  FZKBCustomerRegisterAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBCustomerRegisterAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"
#import <Connector/FZKBKeychain.h>
#import <FZKTools.h>
//#import <Commons/NSString+RSA.h>
#import <Connector/FZKEnum.h>

@implementation FZKBCustomerRegisterAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
    NSString *username = [self.parameters objectForKey:@"customerPhone"];
    NSString *password = [self.parameters objectForKey:@"customerPassword"];
    [FZKBKeychain updateUserName:username.RSAEncode];
    [FZKBKeychain updatePassword:password.RSAEncode];
    
    kSaveCurrentCarModleId(0);
  
    
    
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
 用户注册
 
 传入参数：
vehicleMode：车辆实例ID
imei：终端号
customerUserName：用户名（注册时，就是手机号）
customerPhone：用户手机（注册手机）
customerPassword：用户密码（需要机密）
withEncrypt：1（表示加了密了）
返回参数：
resultCode：0表示成功
 */
+ (void)customerRegisterActionWithCustomerPhone:(NSString *)customerPhone authcode:(NSString *)authcode customerPassword:(NSString *)customerPassword success:(Action1)success fail:(Action1)fail
{
    FZKBCustomerRegisterAction *work =[[FZKBCustomerRegisterAction alloc] init];
    

    [work customerRegisterActionWithCustomerPhone:customerPhone authcode:authcode customerPassword:customerPassword];
    
    
    [SVProgressHUD showWithStatus:@"正在注册..."];
    
    [work onSuncc:^(FZKActionResult *result) {
        [SVProgressHUD dismiss];
        success(result.paramters);
        
    }];
    
    [work onError:^(FZKActionResult *result) {

        fail(result.resultMessage);
        [SVProgressHUD showErrorWithStatus:result.resultMessage];
        
        
    }];
    
    [work run];
    
}



@end
