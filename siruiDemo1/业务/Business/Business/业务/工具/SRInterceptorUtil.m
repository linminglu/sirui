//
//  SRInterceptorUtil.m
//  SiRui
//
//  Created by 宋搏 on 2017/4/13.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRInterceptorUtil.h"
#import <SVProgressHUD.h>

@implementation SRInterceptorUtil

+(FZKViewInterceptor*) buildLoading:(NSString*)msg With:(UIView*)view{
    
    [SVProgressHUD showWithStatus:msg];
    return [SRInterceptorUtil buildLog:@"Loading..."];
}

+(FZKViewInterceptor*) buildDisable:(UIView*) view{
    [SVProgressHUD dismiss];
    return [SRInterceptorUtil buildLog:@"DisableView..."];
}


+(FZKViewInterceptor*) buildLog:(NSString*) key{
    
    FZKViewInterceptor* result = [[FZKViewInterceptor alloc] init];
    result.key = key;
    return result;
}

@end
