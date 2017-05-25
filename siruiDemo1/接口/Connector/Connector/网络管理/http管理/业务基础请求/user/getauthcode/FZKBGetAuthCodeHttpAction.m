
//
//  FZKBGetAuthCodeHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBGetAuthCodeHttpAction.h"


@implementation FZKBGetAuthCodeHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/provider/testProvide/sendBingdingAuthCode",KBaseUrl];
//}



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
- (void)getAuthCodeActionWithUserName:(NSString *)userName phone:(NSString *)phone type:(NSString *)type
{
	[self addPara:@"userName" withValue:userName]; 
	[self addPara:@"phone" withValue:phone]; 
	[self addPara:@"type" withValue:type]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/provider/testProvide/sendBingdingAuthCode";

    
}

@end
