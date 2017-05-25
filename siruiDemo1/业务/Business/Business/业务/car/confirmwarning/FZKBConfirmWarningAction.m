
//
//  FZKBConfirmWarningAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBConfirmWarningAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBConfirmWarningAction


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
 告警消息
 
 输入参数
input1:用户名（需加密）
input2:用户密码（需加密）
返回值：
resultCode:结果码
resultMessage：结果信息
 */
+ (void)confirmWarningActionWithInput1:(NSString *)input1 input2:(NSString *)input2 success:(Action1)success fail:(Action1)fail
{
    FZKBConfirmWarningAction *work =[[FZKBConfirmWarningAction alloc] init];
    

    [work confirmWarningActionWithInput1:input1 input2:input2];
    
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
