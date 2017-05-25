//
//  FZKERoutableConfig.m
//  Example
//
//  Created by czl on 2017/5/2.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKERoutableConfig.h"
#import <Routable.h>
#import "FZKERoutableMainViewController.h"
#import "FZKERoutableNext1ViewController.h"
#import "FZKERoutableLasterViewController.h"

@implementation FZKERoutableConfig

+ (instancetype)share{
    
   static FZKERoutableConfig *install = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        install = [[self alloc] init];
        [install congif];
    });
    return install;
    
}

- (void)congif{
    Routable *route=[Routable sharedRouter];
    [route map:@"main" toController:[FZKERoutableMainViewController class]];
    [route map:@"next1" toController:[FZKERoutableNext1ViewController class]];
    [route map:@"last" toController:[FZKERoutableLasterViewController class]];
    
   
    
}


@end
