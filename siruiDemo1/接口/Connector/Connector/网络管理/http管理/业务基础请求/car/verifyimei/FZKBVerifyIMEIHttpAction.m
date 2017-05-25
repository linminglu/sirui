
//
//  FZKBVerifyIMEIHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBVerifyIMEIHttpAction.h"


@implementation FZKBVerifyIMEIHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/terminal/validateIMEI",KBaseUrl];
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
 验证IMEI（符合服务端规则才能通过）
 
 传入参数：
imei：终端IMEI号（服务端给予）

返回参数：
resultCode：0表示成功
 */
- (void)verifyIMEIActionWithImei:(NSString *)imei
{
	[self addPara:@"imei" withValue:imei]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/terminal/validateIMEI";

    
}

@end
