//
//  SRTCPLoginBody.m
//  SiRuiV4.0
//
//  Created by zhangjunbo on 15/6/16.
//  Copyright (c) 2015年 SiRui. All rights reserved.
//

#import "FZKTCPReqLoginBody.h"
#import "FZKBKeychain.h"
#import <UIKit/UIKit.h>

@implementation FZKTCPReqLoginBody

- (instancetype)init {
    self = [super init];
    if (self) {
        _clientType = 4;
        _protocolVersion = @"3.0.1";
        _hardWareversion = [[UIDevice currentDevice] systemVersion];
        _softwareVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        _token = [FZKBKeychain UUID];
   
    
    }
    
    return self;
}

@end
