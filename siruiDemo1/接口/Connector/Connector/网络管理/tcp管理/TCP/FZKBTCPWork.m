//
//  FZKBTCPWork.m
//  Connector
//
//  Created by czl on 2017/5/11.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBTCPWork.h"


@implementation FZKBTCPWork

- (void)runThenCallback:(ResultAction)callback{

    if (!self.request) {
        return;
    }
    FZKActionResult* result = [[FZKActionResult alloc] init];
    result.resultCode = 1;
    
    [[FZKTCPClient shareTCPClient] sendTCPRequest:self.request withCompleteBlock:^(NSError *error, id responseObject) {
        if (error) {
            result.resultCode = error.code;
            result.resultMessage = error.domain;
        }else{
            result.resultCode = 0;
            result.paramters = responseObject;
        }
        
        if(callback){
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(result);
            });
        
        }
        
    }];

}

@end
