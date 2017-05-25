//
//  SRInterceptorUtil.h
//  SiRui
//
//  Created by 宋搏 on 2017/4/13.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Connector/FZKViewInterceptor.h>
#import <UIKit/UIKit.h>

@interface SRInterceptorUtil : NSObject

+(FZKViewInterceptor*) buildLoading:(NSString*)msg With:(UIView*)view;
+(FZKViewInterceptor*) buildDisable:(UIView*) view;

@end
