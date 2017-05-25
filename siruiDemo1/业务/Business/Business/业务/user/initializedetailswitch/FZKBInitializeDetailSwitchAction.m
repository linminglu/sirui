
//
//  FZKBInitializeDetailSwitchAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBInitializeDetailSwitchAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBInitializeDetailSwitchAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"entity":[{"createTime":"2017-03-16 02:05:37","customerID":18293,"isAllOpen":false,"isOpen":false,"switchID":5527,"type":2,"vehicleID":17482},{"createTime":"2017-03-16 02:05:37","customerID":18293,"isAllOpen":false,"isOpen":false,"switchID":7435,"type":1,"vehicleID":17482},{"createTime":"2017-03-16 02:05:38","customerID":18293,"isAllOpen":false,"isOpen":false,"switchID":7436,"type":2,"vehicleID":17670},{"createTime":"2017-03-16 02:05:38","customerID":18293,"isAllOpen":false,"isOpen":false,"switchID":7438,"type":1,"vehicleID":17670}],"option":{},"result":{"resultCode":0,"resultMessage":"操作成功"}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 消息中心控制器初始化
 
 传入参数
input1：用户名（需加密）
input2：用户密码（需加密）
返回值
createTime：时间
customerID：用户id
isAllOpen：是否全部打开
isOpen：是否打开
switchID：开关id
type：状态
vehicleID：车辆id
 */
+ (void)initializeDetailSwitchActionWithInput1:(NSString *)input1 input2:(NSString *)input2 success:(Action1)success fail:(Action1)fail
{
    FZKBInitializeDetailSwitchAction *work =[[FZKBInitializeDetailSwitchAction alloc] init];
    

    [work initializeDetailSwitchActionWithInput1:input1 input2:input2];
    
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
