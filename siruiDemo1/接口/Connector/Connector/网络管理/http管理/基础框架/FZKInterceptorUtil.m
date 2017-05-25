//
//  InterceptorUtil.m
//  SRN
//
//  Created by 马宁 on 2017/3/2.
//  Copyright © 2017年 Fuizk. All rights reserved.
//

#import "FZKInterceptorUtil.h"
#import <UIKit/UIKit.h>

@implementation FZKInterceptorUtil

+(FZKViewInterceptor*) buildLoading:(NSString*)msg With:(UIView*)view{
    return [FZKInterceptorUtil buildLog:@"Loading..."];
}

+(FZKViewInterceptor*) buildDisable:(UIView*) view{
    return [FZKInterceptorUtil buildLog:@"DisableView..."];
}


+(FZKViewInterceptor*) buildLog:(NSString*) key{

    FZKViewInterceptor* result = [[FZKViewInterceptor alloc] init];
    result.key = key;
    return result;
}

@end
