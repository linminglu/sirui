
//
//  FZKBSRstewardHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBSRstewardHttpAction.h"


@implementation FZKBSRstewardHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/im/im/getFirstMsg",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"entity":{"firstMsg":"您好，请问有什么可以帮助您？工作时间：8:30-21:00  客服热线：023-63063486"},"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 思锐管家（在线客服）提示语
 
 传入参数：
input1:用户名
input2：密码

返回参数：

firstMsg：提示语
resultCode 0表示成功，其他表示失败

resultMessage：主要是在失败的时候返回失败原因
 */
- (void)sRstewardActionWithInput1:(NSString *)input1 input2:(NSString *)input2
{
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/im/im/getFirstMsg";

    
}

@end
