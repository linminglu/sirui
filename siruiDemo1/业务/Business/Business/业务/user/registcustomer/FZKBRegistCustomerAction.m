
//
//  FZKBRegistCustomerAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBRegistCustomerAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBRegistCustomerAction


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
 新版app用户注册
 
 传入参数：
customerUserName：用户名
customerPassword：用户密码
customerPhone：用户手机号
authcode：验证码
返回参数：
resultCode：0表示成功，其他表示失败
 */
+ (void)registCustomerActionWithCustomerPassword:(NSString *)customerPassword customerPhone:(NSString *)customerPhone authcode:(NSString *)authcode customerUserName:(NSString *)customerUserName success:(Action1)success fail:(Action1)fail
{
    FZKBRegistCustomerAction *work =[[FZKBRegistCustomerAction alloc] init];
    

    [work registCustomerActionWithCustomerPassword:customerPassword customerPhone:customerPhone authcode:authcode customerUserName:customerUserName];
    
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
