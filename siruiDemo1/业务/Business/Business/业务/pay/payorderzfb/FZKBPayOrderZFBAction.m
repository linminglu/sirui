
//
//  FZKBPayOrderZFBAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBPayOrderZFBAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBPayOrderZFBAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"entity":{"sign":"HJXdndLGjkEh7ocmBeIqUL6Da0Oc7480U2Sor41jqZ9WpWoMd2/JI822ddXXLH8lfwhaU7VzlfaUDpIZ6C4zQlRyvXFddLNfqbN+POZWl53tJnj5lDTYsdxRqBwoQ8Wjmpl3AT6x8+Div/oOhd2KPyYmlnsqdAkBEcaYj5fIv1Y=","content":"_input_charset=\"utf-8\"&body=\"产品缴费\"&notify_url=\"http://4s.mysirui.com/basic/account/aliWebPayFinishPayCallback\"&out_trade_no=\"1170320566850879B\"&partner=\"2088022604575632\"&payment_type=\"1\"&seller_id=\"2088022604575632\"&service=\"mobile.securitypay.pay\"&subject=\"产品缴费\"&total_fee=\"99.0\"","sign_type":"RSA"},"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 续费（支付中心）支付宝
 
 传入参数：
yearCount：年数（几年）默认写1年
vehicleIDs：车辆ID
isReducePrice：是否减少支付费用（默认写false）
payType：支付方式 2表示支付宝，1表示微信支付


返回参数：
 */
+ (void)payOrderZFBActionWithYearCount:(NSString *)yearCount vehicleIDs:(NSString *)vehicleIDs isReducePrice:(NSString *)isReducePrice payType:(NSString *)payType success:(Action1)success fail:(Action1)fail
{
    FZKBPayOrderZFBAction *work =[[FZKBPayOrderZFBAction alloc] init];
    

    [work payOrderZFBActionWithYearCount:yearCount vehicleIDs:vehicleIDs isReducePrice:isReducePrice payType:payType];
    
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
