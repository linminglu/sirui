//
//  FZKBGetCarInfoHttpAction.m
//  Connector
//
//  Created by czl on 2017/4/18.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBGetCarInfoHttpAction.h"

@implementation FZKBGetCarInfoHttpAction


- (void)getCarInfoActionWithInput1:(NSString *)input1 input2:(NSString *)input2 vehicleID:(NSString *)vehicleID
{
    [self addPara:@"input1" withValue:input1];
    [self addPara:@"input2" withValue:input2];
    [self addPara:@"vehicleID" withValue:vehicleID];
    
    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/car/infos";
    
    
}


@end
