
//
//  FZKBSubmitScoreHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBSubmitScoreHttpAction.h"


@implementation FZKBSubmitScoreHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/market/feedback/update",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"entity":{"accuracy":0,"attitude":5,"customerID":3260,"entityID":2362,"intelligent":0,"online":0,"phoneType":2,"phoneVersion":"3.165","quality":5,"security":0,"stability":0,"timely":0},"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 提交评分
 
 传入参数
input1：用户名（需加密）
input2：用户密码（需加密）
quality：产品质量
attitude：服务态度
phoneVersion:手机版本号
返回值

resultCode：返回结果码 0表示成功 其它表示失败
resultMessage：结果码对应信息
 */
- (void)submitScoreActionWithInput1:(NSString *)input1 input2:(NSString *)input2 attitude:(NSString *)attitude quality:(NSString *)quality phoneVersion:(NSString *)phoneVersion
{
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 
	[self addPara:@"attitude" withValue:attitude]; 
	[self addPara:@"quality" withValue:quality]; 
	[self addPara:@"phoneVersion" withValue:phoneVersion]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/market/feedback/update";

    
}

@end
