//
//  SRTCPConfig.h
//  TCP
//
//  Created by 宋搏 on 2017/4/26.
//  Copyright © 2017年 Fuizk. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSTimeInterval kTcpKeyAliveSeconds_sr;      //TCP保活时间
extern const NSTimeInterval kTcpConnectTimeOutSeconds_sr;//TCP连接超时
extern const NSTimeInterval kTcpResponseTimeOutSeconds_sr;//TCP相应超时
extern const NSInteger kTcpMaxConnectRetryTimes_sr;       //TCP重试最大次数

@interface FZKTCPConfig : NSObject

+ (NSString *)TcpHost;
+ (NSInteger) TcpPort;

@end
