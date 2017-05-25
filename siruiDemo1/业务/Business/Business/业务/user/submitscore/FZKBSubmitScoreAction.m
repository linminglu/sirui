
//
//  FZKBSubmitScoreAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBSubmitScoreAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBSubmitScoreAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


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
+ (void)submitScoreActionWithInput1:(NSString *)input1 input2:(NSString *)input2 attitude:(NSString *)attitude quality:(NSString *)quality phoneVersion:(NSString *)phoneVersion success:(Action1)success fail:(Action1)fail
{
    FZKBSubmitScoreAction *work =[[FZKBSubmitScoreAction alloc] init];
    

    [work submitScoreActionWithInput1:input1 input2:input2 attitude:attitude quality:quality phoneVersion:phoneVersion];
    
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
