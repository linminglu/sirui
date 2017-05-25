//
//  FZKCHTTPDNSManager.h
//  Commons
//
//  Created by czl on 2017/3/25.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlicloudHttpDNS/AlicloudHttpDNS.h>
#import "FZKAppkeyComon.h"




@interface FZKCHTTPDNSManager : NSObject




/**
 注册httpdns 服务器 设置预解析域名数组，设置解析域名地址

 @param count 账户
 @param resolveHosts 预解析域名数组 //@[ @"www.chinapke.com", @"www.taobao.com", @"gw.alicdn.com", @"www.tmall.com", @"dou.bz"]
 @param back 获取解析后ip的处理
 */
+(void)registerAliHTTPDNSCount:(int)count preResolveHosts:(NSArray *)resolveHosts getIp:(void(^)(NSString * ip)) back;


/**
 根据域名获取IP
 
 @param host 预解析域名"http://www.taobao.com" 或者 @"https://www.tmall.com"
 @param host 域名 "http://www.taobao.com"
 @return 相关域名IP
 */

+ (NSString *)getIPWithHost:(NSString *)host;


@end
