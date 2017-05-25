//
//  FZKBQueryTripGpsPointsHttpAction.m
//  Connector
//
//  Created by 宋搏 on 2017/5/4.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryTripGpsPointsHttpAction.h"

@implementation FZKBQueryTripGpsPointsHttpAction


- (void)queryTripListActionWithTripID:(NSString *)tripID input1:(NSString *)input1 input2:(NSString *)input2 pageIndex:(NSString *)pageIndex pageSize:(NSString *)pageSize
{
    [self addPara:@"tripID" withValue:tripID];
    [self addPara:@"input1" withValue:input1];
    [self addPara:@"input2" withValue:input2];
    [self addPara:@"pageIndex" withValue:pageIndex];
    [self addPara:@"pageSize" withValue:pageSize];

    

    
    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/gateway/trip/gpsPoints";
    
    
}

@end
