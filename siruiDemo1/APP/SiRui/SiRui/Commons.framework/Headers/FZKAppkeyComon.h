//
//  FZKAppkeyComon.h
//  Commons  管理所有三方appkey
//
//  Created by czl on 2017/3/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#ifndef FZKAppkeyComon_h
#define FZKAppkeyComon_h

/*
-----------------注意------------------
 
 这个类需要复制到每个工程中，且不能修改类名，不过下面的key和其他的需要根据工程自己配置
 
 --------------------------------------
 
 */


#define AppkeysDic [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"appkeys" ofType:@"plist"]]


/**
 微信支付AppKey

 @return
 */
#define WXPayAppkey AppkeysDic[@"WXPayAppkey"]

/**
 阿里支付AppKey
 
 @return
 */
#define AliPayAppkey  AppkeysDic[@"AliPayAppkey"]


/**
 支付宝 AliPayAppScheme

 @return
 */
#define AliPayAppScheme  AppkeysDic[@"AliPayAppScheme"]


/**
 阿里推送appkey
 
 @return
 */
#define AliPushAppkey  AppkeysDic[@"AliPushAppkey"]





/**
 阿里推送Secret

 @return AliPushAppSecret
 */
#define AliPushAppSecret  AppkeysDic[@"AliPushAppSecret"]



/**
 需要解析的域名
 
 @return
 */
#define AliHTTPDNSCount [AppkeysDic[@"AliHTTPDNSCount"] integerValue]



#pragma mark - shareSDK 各种key
/**
 shareSDK key

 @return
 */
#define ShareSDKAppkey AppkeysDic[@"ShareSDKAppkey"]



/**
 分享qq key

 @return
 */
#define ShareSDKQQAppkey AppkeysDic[@"ShareSDKQQAppkey"]
#define ShareSDKQQAppId AppkeysDic[@"ShareSDKQQAppId"]


/**
 分享微信 key
 
 @return
 */
#define ShareSDKWebchatAppkey AppkeysDic[@"ShareSDKWebchatAppkey"]
#define ShareSDKWebchatAppSecret AppkeysDic[@"ShareSDKWebchatAppSecret"]

/**
 分享新浪 key
 
 @return
 */
#define ShareSDKSinaAppkey AppkeysDic[@"ShareSDKSinaAppkey"]
#define ShareSDKSinaAppSecret AppkeysDic[@"ShareSDKSinaAppSecret"]





#pragma mark - 地图 key


/**
 高德地图appkey http://lbs.amap.com/api/ios-sdk/guide/create-project/note

 @return
 */
#define GaodeMapAppkey AppkeysDic[@"GaodeMapAppkey"]


/**
 百度地图appkey

 @return
 */
#define BaiduMapAppkey AppkeysDic[@"BaiduMapAppkey"]




#endif /* FZKAppkeyComon_h */
