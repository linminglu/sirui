
//
//  FZKBGetAuthCodeRegisterHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBGetAuthCodeRegisterHttpAction.h"
#import "FZKBDomainConfig.h"

@implementation FZKBGetAuthCodeRegisterHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/provider/testProvide/sendAuthCode",KBaseUrl];
//}



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
- (void)getAuthCodeRegisterActionWithPhone:(NSString *)phone fromRegist:(NSString *)fromRegist  type:(NSString *)type
{

	[self addPara:@"fromRegist" withValue:fromRegist];
	[self addPara:@"phone" withValue:phone]; 
//	[self addPara:@"type" withValue:type];


    
}

- (void)smk_requestConfigures{
      [super smk_requestConfigures];
    self.smk_path = @"/provider/testProvide/sendAuthCode";

    
}

@end
