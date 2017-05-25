
//
//  FZKBEntityModel.m
//  Connector
//
//  Created by mac on date.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBEntityModel.h"

@implementation FZKBEntityModel
+ (instancetype)shareModel
{
    static id instance = nil;
    // 使用GCD
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 保证代码执行一次
        if (!instance) {
            instance = [[[self class] alloc]init];
        }
    });
    return instance;
}
@end
