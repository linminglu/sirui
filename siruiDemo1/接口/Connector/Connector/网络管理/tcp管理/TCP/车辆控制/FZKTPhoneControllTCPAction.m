//
//  FZKTPhoneControllTCPAction.m
//  Connector
//
//  Created by czl on 2017/5/11.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKTPhoneControllTCPAction.h"

@implementation FZKTPhoneControllTCPAction

- (void)phoneControllActionWithCarId:(NSInteger)carId tag:(NSInteger)tag controlSeries:(NSInteger)controlSeries{
    
    self.request = [FZKTCPRequest InstructionRequestWithCmdID:tag controlSeries:controlSeries andVehicleID:carId];
 
}

@end
