
//
//  FZKBSRstewardListHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBSRstewardListHttpAction.h"


@implementation FZKBSRstewardListHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/im/im/getMsg",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"entity":[{"adddate":"2017-02-08 13:25:10.0","content":"呃呃","customerID":3260,"id":106876,"isImg":false,"isRead":true,"name":"侯宇","type":0},{"adddate":"2017-02-08 13:25:17.0","content":"哈哈","customerID":3260,"id":106877,"isImg":false,"isRead":true,"name":"侯宇","type":0}]}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 思锐管家列表（在线客服，聊天记录）
 
 传入参数：
rows:查找条数
adddate：加载时间（传入当前时间）
direction：0表示上拉加载最新，1表示下拉加载更多

返回参数：
adddate：加载时间
content：内容
customerID：用户ID
id：每条信息ID
isImg：信息是否是图片
isRead：false表示用户发的，true表示思锐发的
name：用户名字
type：类型（都是传0）



 */
- (void)sRstewardListActionWithRows:(NSString *)rows adddate:(NSString *)adddate direction:(NSString *)direction
{
	[self addPara:@"rows" withValue:rows]; 
	[self addPara:@"adddate" withValue:adddate]; 
	[self addPara:@"direction" withValue:direction]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/im/im/getMsg";

    
}

@end
