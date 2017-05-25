
//
//  FZKBSRSendMessageAction.h
//
//
//  Created by mac on date.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Connector/FZKBSRSendMessageHttpAction.h>

@interface FZKBSRSendMessageAction : FZKBSRSendMessageHttpAction
    
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
+ (void)sRSendMessageActionWithContent:(NSString *)content success:(Action1)success fail:(Action1)fail;

@end