
//
//  FZKBPhoneControllHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBPhoneControllHttpAction.h"


@implementation FZKBPhoneControllHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/phone/control",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"result":{"resultCode":0,"resultMessage":"业务执行成功"}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 发送车控制指令给服务器
 
 传入参数:


input1:车id_命令号_用户名。
input2:用户密码。
input3:手机uuid。
app:app名称
 */
- (void)phoneControllActionWithInput1:(NSString *)input1 input2:(NSString *)input2 input3:(NSString *)input3 input4:(NSString *)input4 app:(NSString *)app{
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 
	[self addPara:@"input3" withValue:input3];
    [self addPara:@"input4" withValue:input4];
	[self addPara:@"app" withValue:app]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/phone/control";
    self.smk_host = @"42.120.61.246:2302";

    
}

@end
