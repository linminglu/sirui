
//
//  FZKBValidateImeiAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBValidateImeiAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBValidateImeiAction


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
 用户注册验证imei号
 
 传入参数
imei：设备唯一识别码
version：APP版本号
返回值
resultCode：结果码,0表示验证成功，其它表示获取失败

 */
+ (void)validateImeiActionWithImei:(NSString *)imei version:(NSString *)version success:(Action1)success fail:(Action1)fail
{
    FZKBValidateImeiAction *work =[[FZKBValidateImeiAction alloc] init];
    

    [work validateImeiActionWithImei:imei version:version];
    
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
