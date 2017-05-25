//
//  FZKCRegisterCommonsAppkey.h
//  Commons
//
//  Created by czl on 2017/3/31.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#import "WXApi.h"
#import "FZKCPayManager.h"
#import "FZKCAliPushManager.h"
#import "FZKAppkeyComon.h"
#import "FZKCMapManager.h"
#import "FZKCShareManager.h"
#import "FZKCHTTPDNSManager.h"

@interface FZKCRegisterCommonsAppkey : NSObject


/**
 一键注册所有第三方库
 */

/**
 注册第三方库

 @param object 这里是iOS10以后推送的处理
 @param launchOptions 点击通知将App从关闭状态启动时，将通知打开回执上报
 */
+ (void)registerCommonsAppkeyAppDelegateAndMessageReceive:(id<UNUserNotificationCenterDelegate>)object sendNotificationAck:(NSDictionary *)launchOptions getIpBlock:(void(^)(NSString * ip))back;

@end
