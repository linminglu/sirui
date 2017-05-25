//
//  FZKCRegisterCommonsAppkey.m
//  Commons
//
//  Created by czl on 2017/3/31.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCRegisterCommonsAppkey.h"
#import "FZKAppkeyComon.h"

//#import <AlipaySDK/AlipaySDK.h>



@implementation FZKCRegisterCommonsAppkey

+ (void)registerCommonsAppkeyAppDelegateAndMessageReceive:(id<UNUserNotificationCenterDelegate>)object sendNotificationAck:(NSDictionary *)launchOptions getIpBlock:(void (^)(NSString *ip))back{

    {
        // Override point for customization after application launch.

        
        if (!AppkeysDic) {
            NSLog(@"缺失appkeys.plist文件,在Commons.bundle中有模板，可以直接拷贝到项目中");
            return;
        }
        
        
//        支付注册
        [FZKCPayManager registerWXAppkey:WXPayAppkey aliAppkey:nil];
        
//        分享注册
        [FZKCShareManager registerShareSDKAppkey:ShareSDKAppkey];

        
        
        //    注册推送
        [FZKCAliPushManager registerAliPushAppKey:AliPushAppkey appSecret:AliPushAppSecret callback:^(CloudPushCallbackResult *res) {
            if (res.success) {
                NSLog(@"Push SDK init success, deviceId: %@.", [CloudPushSDK getDeviceId]);
                NSLog(@"\n推送状态%d\n",[CloudPushSDK isChannelOpened]);
            } else {
                NSLog(@"Push SDK init failed, error: %@", res.error);
            }
            
        } appDelegateAndMessageReceive:object sendNotificationAck:launchOptions];
        
//        地图注册
        [FZKCMapManager registerMapType:MapTypeBaidu];
       
        
//        HTTPDNS注册
        [FZKCHTTPDNSManager registerAliHTTPDNSCount:AliHTTPDNSCount preResolveHosts:@[@"http://4s.mysirui.com/"] getIp:back];

        
    }
}

@end
