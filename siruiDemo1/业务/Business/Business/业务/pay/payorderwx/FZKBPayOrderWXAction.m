
//
//  FZKBPayOrderWXAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBPayOrderWXAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBPayOrderWXAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"entity":{"sign":"608F8EAB19A3440FC21889CD8093F6EE","timestamp":456321983,"noncestr":"h5gm0jasgd23a77a60ejaeckt0rbrcu2","partnerid":"1274767201","prepayid":"wx20170320154631dd80617cfa0113555607","package":"Sign=WXPay","appid":"wx2e00708758d1f9cf"},"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 续费（支付中心） 微信支付
 
 传入参数：
yearCount：年数（默认写1年）
vehicleIDs：车辆ID
isReducePrice：是否减少支付费用（默认写false）
payType：支付方式 1表示微信支付，2表示支付宝
返回参数：
调用三方SDK
 */
+ (void)payOrderWXActionWithYearCount:(NSString *)yearCount vehicleIDs:(NSString *)vehicleIDs isReducePrice:(NSString *)isReducePrice payType:(NSString *)payType success:(Action1)success fail:(Action1)fail
{
    FZKBPayOrderWXAction *work =[[FZKBPayOrderWXAction alloc] init];
    

    [work payOrderWXActionWithYearCount:yearCount vehicleIDs:vehicleIDs isReducePrice:isReducePrice payType:payType];
    
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
