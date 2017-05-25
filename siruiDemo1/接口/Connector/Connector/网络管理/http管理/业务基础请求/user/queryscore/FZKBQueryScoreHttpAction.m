
//
//  FZKBQueryScoreHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryScoreHttpAction.h"


@implementation FZKBQueryScoreHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/market/feedback/detail",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"entity":{"accuracy":0,"attitude":4,"createTime":"2017-03-25 13:29:47","customerID":3260,"entityID":2384,"intelligent":0,"online":0,"phoneType":2,"phoneVersion":"3.51","quality":4,"security":0,"stability":0,"timely":0},"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 评分查询
 
 传入参数
input1:用户名（需加密）
input2:用户密码（需加密）
attitude:服务态度
quality：产品质量
createTime：时间

返回值
attitude：服务态度
quality：产品质量
createTime：时间
customerID：用户id
resultCode:结果码 0表示成功 其它表示不成功
resultMessage：结果码对应消息
 */
- (void)queryScoreActionWithInput1:(NSString *)input1 input2:(NSString *)input2 attitude:(NSString *)attitude quality:(NSString *)quality createTime:(NSString *)createTime
{
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 
	[self addPara:@"attitude" withValue:attitude]; 
	[self addPara:@"quality" withValue:quality]; 
	[self addPara:@"createTime" withValue:createTime]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/market/feedback/detail";

    
}

@end
