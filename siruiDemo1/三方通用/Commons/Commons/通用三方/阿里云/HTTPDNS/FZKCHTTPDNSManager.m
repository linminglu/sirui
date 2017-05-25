//
//  FZKCHTTPDNSManager.m
//  Commons
//
//  Created by czl on 2017/3/25.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCHTTPDNSManager.h"



@implementation FZKCHTTPDNSManager






/**
 注册httpdns 服务器 设置预解析域名数组，设置解析域名地址
 
 @param count 账户
 @param resolveHosts 预解析域名数组 //@[ @"www.chinapke.com", @"www.taobao.com", @"gw.alicdn.com", @"www.tmall.com", @"dou.bz"]

 */
+(void)registerAliHTTPDNSCount:(int)count preResolveHosts:(NSArray *)resolveHosts getIp:(void(^)(NSString * ip))back{
    
    // 初始化HTTPDNS
    HttpDnsService *httpdns = [HttpDnsService sharedInstance];
    
    // 设置AccoutID
    [httpdns setAccountID:count];
    
    // 为HTTPDNS服务设置降级机制
    //    [httpdns setDelegateForDegradationFilter:(id < HttpDNSDegradationDelegate >)self];
    // 允许返回过期的IP
    [httpdns setExpiredIPEnabled:YES];
    // 打开HTTPDNS Log，线上建议关闭
        [httpdns setLogEnabled:YES];    

    // 设置预解析域名列表
    [httpdns setPreResolveHosts:resolveHosts];
     NSString *sourceHost = resolveHosts[0];
    NSString *host;
    if ([sourceHost hasPrefix:@"http://"]||[sourceHost hasPrefix:@"https://"]) {
        host = sourceHost;
    }else{
        host = [NSString stringWithFormat:@"http://%@",sourceHost];
    }
    
    
//    获取解析域名 延迟2秒
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
     __block NSString *str;
        NSInteger count=0;
        do {
            
          count++;
          str = [self getIPWithHost:host];
          NSLog(@"解析次数:%ld,%@",count,str);
            if (str) {
                back(str);
            }
         
          
            
            
        } while (str==nil&&count<5);
        if (!str) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                str = [self getIPWithHost:host];
                NSLog(@"解析次数:%ld,%@",count,str);
                if (str) {
                    back(str);
                }
            });
        }
    
    });
    
    
    /**
     * 异步接口获取IP
     * 为了适配IPv6的使用场景，我们使用 `-[HttpDnsService getIpByHostAsyncInURLFormat:]` 接口
     * 注意：当您使用IP形式的URL进行网络请求时，IPv4与IPv6的IP地址使用方式略有不同：
     *         IPv4: http://1.1.1.1/path
     *         IPv6: http://[2001:db8:c000:221::]/path
     * 因此我们专门提供了适配URL格式的IP获取接口 `-[HttpDnsService getIpByHostAsyncInURLFormat:]`
     * 如果您只是为了获取IP信息而已，可以直接使用 `-[HttpDnsService getIpByHostAsync:]`接口
     */
    
    //        NSString *ip = [httpdns getIpByHostAsyncInURLFormat:url.host];
    //        NSString *ips = [httpdns getIpByHostAsync:url.host];
    //     NSLog(@"-----------------------------------------------------------------------------------\n%@,%@\n",[httpdns getIpByHostAsyncInURLFormat:url.host],[httpdns getIpByHostAsync:url.host]);
    //        if (ip) {
    //            // 通过HTTPDNS获取IP成功，进行URL替换和HOST头设置
    //            NSLog(@"Get IP(%@) for host(%@) from HTTPDNS Successfully!", ip, url.host);
    //            NSRange hostFirstRange = [originalUrl rangeOfString:url.host];
    //            if (NSNotFound != hostFirstRange.location) {
    //                NSString *newUrl = [originalUrl stringByReplacingCharactersInRange:hostFirstRange withString:ip];
    //                NSLog(@"New URL: %@", newUrl);
    //                request.URL = [NSURL URLWithString:newUrl];
    //                [request setValue:url.host forHTTPHeaderField:@"host"];
    //            }
    //        }
    
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //
    //        NSLog(@"=========================================================\n%@,%@\n",[httpdns getIpByHostAsyncInURLFormat:url.host],[httpdns getIpByHostAsync:url.host]);
    //    });
    
    
    
}


/**
 根据域名获取IP
 
 根据域名获取IP 此方法需要在registerAliHTTPDNSCount:(int)count preResolveHosts:(NSArray *)resolveHosts 执行之后使用，且不能同时使用
 
 @param host 预解析域名"http://www.taobao.com" 或者 @"https://www.tmall.com"
 @return 相关域名IP
 @param host 域名 "http://www.taobao.com"
 @return 相关域名IP
 */
+ (NSString *)getIPWithHost:(NSString *)host{
    NSString *sourceHost;
    if ([host hasPrefix:@"http://"]||[host hasPrefix:@"https://"]) {
        sourceHost = host;
    }else{
        sourceHost = [NSString stringWithFormat:@"http://%@",host];
    }
    NSString *originalUrl = sourceHost;
    NSURL *url = [NSURL URLWithString:originalUrl];

    return [[HttpDnsService sharedInstance] getIpByHostAsyncInURLFormat:url.host]?[[HttpDnsService sharedInstance] getIpByHostAsyncInURLFormat:url.host]:sourceHost;

    
}


@end
