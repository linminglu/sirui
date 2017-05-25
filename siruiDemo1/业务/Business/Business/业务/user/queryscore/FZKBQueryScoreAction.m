
//
//  FZKBQueryScoreAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryScoreAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBQueryScoreAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


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
+ (void)queryScoreActionWithInput1:(NSString *)input1 input2:(NSString *)input2 attitude:(NSString *)attitude quality:(NSString *)quality createTime:(NSString *)createTime success:(Action1)success fail:(Action1)fail
{
    FZKBQueryScoreAction *work =[[FZKBQueryScoreAction alloc] init];
    

    [work queryScoreActionWithInput1:input1 input2:input2 attitude:attitude quality:quality createTime:createTime];
    
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
