//
//  FZKTBleWork.m
//  Connector
//
//  Created by czl on 2017/5/17.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKTBleWork.h"
#import "FZKTBluetoothManager.h"

@implementation FZKTBleWork

- (void)runThenCallback:(ResultAction)callback{
    
    FZKActionResult* result = [[FZKActionResult alloc] init];
    result.resultCode = 1;

    [[FZKTBluetoothManager shareBluetoothManager]sendCommand:self.command withCompleteBlock:^(NSError *error, id responseObject) {
        if (error) {
            result.resultCode = error.code;
            result.resultMessage = error.domain;
        }else{
            result.resultCode = 0;
            result.paramters = responseObject;
            result.resultMessage = responseObject;
        }
        if(callback){
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(result);
            });
            
        }
    }];
    
}


@end
