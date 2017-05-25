
//
//  FZKBMessageSetSwitchHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBMessageSetSwitchHttpAction.h"


@implementation FZKBMessageSetSwitchHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/provider/messageSwitch/setSwitch",KBaseUrl];
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
 信息中心控制器
 
 传入参数：
type：状态
isOpen：是否打开
input1：用户名（需加密）
input2：用户密码（需加密）
返回值：
resultCode：结果码
resultMessage：返回结果信息
 */
- (void)messageSetSwitchActionWithType:(NSString *)type isOpen:(NSString *)isOpen input1:(NSString *)input1 input2:(NSString *)input2
{
	[self addPara:@"type" withValue:type]; 
	[self addPara:@"isOpen" withValue:isOpen]; 
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/provider/messageSwitch/setSwitch";

    
}

@end
