
//
//  FZKBSRSendMessageHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBSRSendMessageHttpAction.h"


@implementation FZKBSRSendMessageHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/im/im/sendMsg_client",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"entity":{"adddate":"2017-03-25 13:23:13","customerID":18293,"id":124438,"isImg":false,"isRead":false,"name":"13983179468","type":0},"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 思锐管家（在线客服）用户发送消息
 
 传入参数：
content：内容（消息）

返回参数：
adddate:发送时间
customerID：用户ID
id：消息ID
isImg：是否是图片
isRead：false表示用户，true表示思锐管家（消息来源）
name：用户名
type：类型，这里就是0
 */
- (void)sRSendMessageActionWithContent:(NSString *)content
{
	[self addPara:@"content" withValue:content]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/im/im/sendMsg_client";

    
}

@end
