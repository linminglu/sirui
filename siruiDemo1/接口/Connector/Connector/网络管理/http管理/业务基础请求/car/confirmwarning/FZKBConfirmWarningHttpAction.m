
//
//  FZKBConfirmWarningHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBConfirmWarningHttpAction.h"


@implementation FZKBConfirmWarningHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/gateway/alarm/confirm",KBaseUrl];
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
 告警消息
 
 输入参数
input1:用户名（需加密）
input2:用户密码（需加密）
返回值：
resultCode:结果码
resultMessage：结果信息
 */
- (void)confirmWarningActionWithInput1:(NSString *)input1 input2:(NSString *)input2
{
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/gateway/alarm/confirm";

    
}

@end
