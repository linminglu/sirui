
//
//  FZKBGetWarningMessageAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBGetWarningMessageAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBGetWarningMessageAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"option":{},"pageResult":{"entityList":[{"message":"您的爱车 渝2222 于 2017-02-28 14:22:06 设防检测门开","vehicleid":17482,"time":"2017-02-28 14:22:06","msgid":9491566,"customerid":18293,"msgtype":0,"enmessage":"Your vehicle 渝2222 at 2017-02-28 14:22:06 was detected Unlock","type":1},{"message":"您的爱车 渝2222 于 2017-02-28 14:21:38 设防检测引擎启动","vehicleid":17482,"time":"2017-02-28 14:21:38","msgid":9491543,"customerid":18293,"msgtype":0,"enmessage":"Your vehicle 渝2222 at 2017-02-28 14:21:38 was detected started","type":1},{"message":"您的爱车 渝2222 于 2017-02-28 14:20:25 设防检测门开","vehicleid":17482,"time":"2017-02-28 14:20:25","msgid":9491502,"customerid":18293,"msgtype":0,"enmessage":"Your vehicle 渝2222 at 2017-02-28 14:20:25 was detected Unlock","type":1},{"message":"您的爱车 渝2222 于 2017-02-25 15:28:32 设防检测门开","vehicleid":17482,"time":"2017-02-25 15:28:33","msgid":9411714,"customerid":18293,"msgtype":0,"enmessage":"Your vehicle 渝2222 at 2017-02-25 15:28:32 was detected Unlock","type":1},{"message":"您的爱车 渝2222 于 2017-02-25 15:28:08 设防检测非法入侵","vehicleid":17482,"time":"2017-02-25 15:28:08","msgid":9411700,"customerid":18293,"msgtype":25,"enmessage":"Your vehicle 渝2222 at 2017-02-25 15:28:08 was detected ilegally entry","type":1},{"message":"您的爱车 渝2222 于 2017-02-24 15:05:31 产生出围栏告警","vehicleid":17482,"time":"2017-02-24 15:05:31","msgid":9383595,"customerid":18293,"msgtype":31,"enmessage":"Your vehicle 渝2222 at 2017-02-24 15:05:31 got unkown alarmed E-Borderline","type":1},{"message":"您的爱车 渝2222 于 2017-02-24 14:53:07 产生出围栏告警","vehicleid":17482,"time":"2017-02-24 14:53:07","msgid":9383237,"customerid":18293,"msgtype":31,"enmessage":"Your vehicle 渝2222 at 2017-02-24 14:53:07 got unkown alarmed E-Borderline","type":1},{"message":"您的爱车 渝2222 于 2017-02-24 14:06:11 设防检测门开","vehicleid":17482,"time":"2017-02-24 14:06:11","msgid":9381785,"customerid":18293,"msgtype":0,"enmessage":"Your vehicle 渝2222 at 2017-02-24 14:06:11 was detected Unlock","type":1},{"message":"您的爱车 渝2222 于 2017-02-24 14:03:12 设防检测非法入侵","vehicleid":17482,"time":"2017-02-24 14:03:12","msgid":9381697,"customerid":18293,"msgtype":25,"enmessage":"Your vehicle 渝2222 at 2017-02-24 14:03:12 was detected ilegally entry","type":1},{"message":"您的爱车 渝2222 于 2017-02-24 11:17:52 设防检测非法入侵","vehicleid":17482,"time":"2017-02-24 11:17:52","msgid":9376540,"customerid":18293,"msgtype":25,"enmessage":"Your vehicle 渝2222 at 2017-02-24 11:17:52 was detected ilegally entry","type":1},{"message":"您的爱车 渝2222 于 2017-02-24 11:16:49 设防检测非法入侵","vehicleid":17482,"time":"2017-02-24 11:16:49","msgid":9376511,"customerid":18293,"msgtype":25,"enmessage":"Your vehicle 渝2222 at 2017-02-24 11:16:49 was detected ilegally entry","type":1},{"message":"您的爱车 渝2222 于 2017-02-16 14:26:00 设防检测非法入侵","vehicleid":17482,"time":"2017-02-16 14:26:01","msgid":9177064,"customerid":18293,"msgtype":25,"enmessage":"Your vehicle 渝2222 at 2017-02-16 14:26:00 was detected ilegally entry","type":1}],"pageIndex":1,"pageSize":20,"totalCount":12,"totalPage":1},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 获取告警、提醒消息
 
 传入参数
input1：用户名（需加密）
input2：用户密码（需加密）
type：类型 1：告警类消息 2：提醒类消息
pageSize：每一页多少条消息数据
返回值
message：消息
vehicleid：车id
time:时间
msgid：消息id
customerid：用户id
msgtype:消息类型（具体看代码 meeagetypecode）
enmessage：英语消息
type：类型




 */
+ (void)getWarningMessageActionWithInput1:(NSString *)input1 input2:(NSString *)input2 type:(NSString *)type pageSize:(NSString *)pageSize success:(Action1)success fail:(Action1)fail
{
    FZKBGetWarningMessageAction *work =[[FZKBGetWarningMessageAction alloc] init];
    

    [work getWarningMessageActionWithInput1:input1 input2:input2 type:type pageSize:pageSize];
    
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
