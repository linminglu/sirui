
//
//  FZKBGetAuthCodeAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBGetAuthCodeAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBGetAuthCodeAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"option":{"authCode":"0653","phone":"13983179468"},"result":{"resultCode":0,"resultMessage":"发送成功"}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 获取验证码（备注一下：当发送短信失败但确实获取到验证码，时调用http://223.6.255.5/provider/testProvide/getAuthcodeIMGUrl?authCode=获取的验证码    得到web图片）
 
 传入参数：
userName：用户名
phone：接手短信的手机（用户绑定的手机）
type:业务类型：注册不写，updateUserName，
updatePassword，updatePhone，


返回参数：
authCode：验证码
phone：用户手机号
 */
+ (void)getAuthCodeActionWithUserName:(NSString *)userName phone:(NSString *)phone type:(NSString *)type success:(Action1)success fail:(Action1)fail
{
    FZKBGetAuthCodeAction *work =[[FZKBGetAuthCodeAction alloc] init];
    

    [work getAuthCodeActionWithUserName:userName phone:phone type:type];
    
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
