//
//  SRTCPConfig.m
//  TCP
//
//  Created by 宋搏 on 2017/4/26.
//  Copyright © 2017年 Fuizk. All rights reserved.
//

#import "FZKTCPConfig.h"

const NSTimeInterval kTcpKeyAliveSeconds_sr = 2*60*NSEC_PER_SEC; //TCP保活时间2分钟
const NSTimeInterval kTcpConnectTimeOutSeconds_sr = 5*NSEC_PER_SEC; //TCP连接超时15S
const NSTimeInterval kTcpResponseTimeOutSeconds_sr = 30*NSEC_PER_SEC; //TCP相应超时30S
const NSInteger      kTcpMaxConnectRetryTimes_sr = 3; //TCP重试最大次数3次

@implementation FZKTCPConfig


+ (NSString *)TcpHost{

   return @"42.120.61.246";

}
+ (NSInteger) TcpPort{
    
    return 3004;



}
@end
