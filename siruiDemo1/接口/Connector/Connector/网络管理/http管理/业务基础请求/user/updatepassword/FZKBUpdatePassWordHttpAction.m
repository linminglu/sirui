
//
//  FZKBUpdatePassWordHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBUpdatePassWordHttpAction.h"


@implementation FZKBUpdatePassWordHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/customer/changePasswordAfterRetrieve",KBaseUrl];
//}



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
- (void)updatePassWordActionWithUserName:(NSString *)userName authCode:(NSString *)authCode password:(NSString *)password withEncrypt:(NSString *)withEncrypt
{
	[self addPara:@"userName" withValue:userName]; 
	[self addPara:@"authCode" withValue:authCode]; 
	[self addPara:@"password" withValue:password]; 
	[self addPara:@"withEncrypt" withValue:withEncrypt]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/customer/changePasswordAfterRetrieve";

    
}

@end
