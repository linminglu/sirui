//
//  SRTCPRequestHead.m
//  SiRuiV4.0
//
//  Created by zhangjunbo on 15/6/16.
//  Copyright (c) 2015年 SiRui. All rights reserved.
//

#import "FZKTCPRequestHead.h"

@implementation FZKTCPRequestHead

- (instancetype)initWithDirect:(NSInteger)direction
                        funcID:(NSInteger)functionID
               andSerialNumber:(NSInteger)serialNumber
{
    if (self = [super init]) {
        _direction = direction;
        _functionID = functionID;
        _serialNumber = serialNumber;
    }
    
    return self;
}

@end
