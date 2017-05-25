
//
//  FZKBUpdateSubmissionAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBUpdateSubmissionAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBUpdateSubmissionAction


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
 修改手机号，修改用户名，修改密码提交接口
 
 传入参数：
authCode：验证码
customerUserName：修改的用户名或者用户名
customerPassword：用户密码，或者修改的用户密码
withEncrypt：标志服务端解密密码传1
customerPhone：用户手机号或者修改手机号
返回参数：
resultCode：0表示成功


 */
+ (void)updateSubmissionActionWithAuthCode:(NSString *)authCode customerUserName:(NSString *)customerUserName customerPassword:(NSString *)customerPassword withEncrypt:(NSString *)withEncrypt customerPhone:(NSString *)customerPhone success:(Action1)success fail:(Action1)fail
{
    FZKBUpdateSubmissionAction *work =[[FZKBUpdateSubmissionAction alloc] init];
    

    [work updateSubmissionActionWithAuthCode:authCode customerUserName:customerUserName customerPassword:customerPassword withEncrypt:withEncrypt customerPhone:customerPhone];
    
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
