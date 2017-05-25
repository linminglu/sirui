
//
//  FZKBSRstewardAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBSRstewardAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBSRstewardAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


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
+ (void)sRstewardActionWithInput1:(NSString *)input1 input2:(NSString *)input2 success:(Action1)success fail:(Action1)fail
{
    FZKBSRstewardAction *work =[[FZKBSRstewardAction alloc] init];
    

    [work sRstewardActionWithInput1:input1 input2:input2];
    
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
