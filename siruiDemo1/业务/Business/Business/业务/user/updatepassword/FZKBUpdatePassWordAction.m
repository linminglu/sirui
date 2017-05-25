
//
//  FZKBUpdatePassWordAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBUpdatePassWordAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBUpdatePassWordAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
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
 设置密码
 
 传入参数：
userName：用户名
authCode：验证码
password：密码
withEncrypt： 目前暂定是加密的意思，1表示加密（晚点和server确认）

返回参数：

resultCode:0表示成功

 */
+ (void)updatePassWordActionWithUserName:(NSString *)userName authCode:(NSString *)authCode password:(NSString *)password withEncrypt:(NSString *)withEncrypt success:(Action1)success fail:(Action1)fail
{
    FZKBUpdatePassWordAction *work =[[FZKBUpdatePassWordAction alloc] init];
    

    [work updatePassWordActionWithUserName:userName authCode:authCode password:password withEncrypt:withEncrypt];
    
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
