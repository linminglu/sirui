
//
//  FZKBPhoneUnbindAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBPhoneUnbindAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBPhoneUnbindAction


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
 手机解绑
 
 传入参数：
conditionCode：相当于phoneID

返回参数：
resultCode：0表示成功
 */
+ (void)phoneUnbindActionWithConditionCode:(NSString *)conditionCode success:(Action1)success fail:(Action1)fail
{
    FZKBPhoneUnbindAction *work =[[FZKBPhoneUnbindAction alloc] init];
    

    [work phoneUnbindActionWithConditionCode:conditionCode];
    
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
