
//
//  FZKBVerifyIMEIAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBVerifyIMEIAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBVerifyIMEIAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"entity":{"bname":"奇瑞","vmname":"2014款 2.0L 手动家尊版","sid":601,"vmid":4654,"vin":"LVTDB24B8EC092840","sname":"瑞虎5","bid":89,"platenumber":"C136GQE0670"},"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 验证IMEI（符合服务端规则才能通过）
 
 传入参数：
imei：终端IMEI号（服务端给予）

返回参数：
resultCode：0表示成功
platenumber：车牌号
vin：车架号
bname：品牌名
bid：品牌编号
vmname：系列名
vmid：系列编号
sname：车型名
sid：车型id

 */
+ (void)verifyIMEIActionWithImei:(NSString *)imei success:(Action1)success fail:(Action1)fail
{
    FZKBVerifyIMEIAction *work =[[FZKBVerifyIMEIAction alloc] init];
    

    [work verifyIMEIActionWithImei:imei];
    
//    [work addInterceptor:[SRInterceptorUtil buildLoading:@"正在验证IMEI........" With:nil]];
//    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
    [work onSuncc:^(FZKActionResult *result) {
        if(result.paramters[@"entity"]){
            success(result.paramters[@"entity"]);
        }else {
            success(nil);
        }
        
        
    }];
    
    [work onError:^(FZKActionResult *result) {

        fail(result.resultMessage);
        [SVProgressHUD showErrorWithStatus:result.resultMessage];
        
        
    }];
    
    [work run];
    
}



@end
