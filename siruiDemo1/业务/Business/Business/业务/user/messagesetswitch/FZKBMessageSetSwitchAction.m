
//
//  FZKBMessageSetSwitchAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBMessageSetSwitchAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBMessageSetSwitchAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


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
+ (void)messageSetSwitchActionWithType:(NSString *)type isOpen:(NSString *)isOpen input1:(NSString *)input1 input2:(NSString *)input2 success:(Action1)success fail:(Action1)fail
{
    FZKBMessageSetSwitchAction *work =[[FZKBMessageSetSwitchAction alloc] init];
    

    [work messageSetSwitchActionWithType:type isOpen:isOpen input1:input1 input2:input2];
    
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
