
//
//  FZKBRegistCustomerHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBRegistCustomerHttpAction.h"


@implementation FZKBRegistCustomerHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/customer/registerCustomer",KBaseUrl];
//}



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
- (void)registCustomerActionWithCustomerPassword:(NSString *)customerPassword customerPhone:(NSString *)customerPhone authcode:(NSString *)authcode customerUserName:(NSString *)customerUserName
{
	[self addPara:@"customerPassword" withValue:customerPassword]; 
	[self addPara:@"customerPhone" withValue:customerPhone]; 
	[self addPara:@"authcode" withValue:authcode]; 
	[self addPara:@"customerUserName" withValue:customerUserName]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/customer/registerCustomer";

    
}

@end
