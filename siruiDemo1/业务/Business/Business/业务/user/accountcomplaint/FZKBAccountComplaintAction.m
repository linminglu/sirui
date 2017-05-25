
//
//  FZKBAccountComplaintAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBAccountComplaintAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBAccountComplaintAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"option":{},"result":{"resultCode":0}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 账号申诉
 
 传入参数：
name：用户姓名
phone：用户手机号
email：用户邮箱
idNumber：身份证号
plateNumber：车牌号
vin：车架号
picUrl：（传入一张图片）

返回参数：
resultCode：0表示成功
 */
+ (void)accountComplaintActionWithName:(NSString *)name phone:(NSString *)phone email:(NSString *)email idNumber:(NSString *)idNumber plateNumber:(NSString *)plateNumber vin:(NSString *)vin success:(Action1)success fail:(Action1)fail
{
    FZKBAccountComplaintAction *work =[[FZKBAccountComplaintAction alloc] init];
    

    [work accountComplaintActionWithName:name phone:phone email:email idNumber:idNumber plateNumber:plateNumber vin:vin];
    
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
