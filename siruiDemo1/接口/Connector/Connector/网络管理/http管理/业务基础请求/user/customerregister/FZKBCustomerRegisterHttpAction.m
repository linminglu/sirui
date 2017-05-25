
//
//  FZKBCustomerRegisterHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBCustomerRegisterHttpAction.h"


@implementation FZKBCustomerRegisterHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/customer/register",KBaseUrl];
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





- (void)customerRegisterActionWithCustomerPhone:(NSString *)customerPhone authcode:(NSString *)authcode customerPassword:(NSString *)customerPassword
{

	[self addPara:@"customerUserName" withValue:customerPhone];
	[self addPara:@"customerPhone" withValue:customerPhone]; 
	[self addPara:@"customerPassword" withValue:customerPassword];
    [self addPara:@"authcode" withValue:authcode];
    

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/customer/registerCustomer";

    
}

@end
