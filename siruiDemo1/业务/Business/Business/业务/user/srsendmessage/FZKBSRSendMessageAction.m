
//
//  FZKBSRSendMessageAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBSRSendMessageAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBSRSendMessageAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


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
+ (void)sRSendMessageActionWithContent:(NSString *)content success:(Action1)success fail:(Action1)fail
{
    FZKBSRSendMessageAction *work =[[FZKBSRSendMessageAction alloc] init];
    

    [work sRSendMessageActionWithContent:content];
    
    [work addInterceptor:[SRInterceptorUtil buildLoading:@"这里填写自己的........" With:nil]];
    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
    [work onSuncc:^(FZKActionResult *result) {

        success(result.paramters);
        
    }];
    
    [work onError:^(FZKActionResult *result) {

        fail(result.resultMessage);
        [SVProgressHUD showErrorWithStatus:result.resultMessage];
        
        
    }];
    
    [work run];
    
}



@end
