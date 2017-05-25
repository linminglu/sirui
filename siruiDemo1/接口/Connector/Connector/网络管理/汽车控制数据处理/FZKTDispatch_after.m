//
//  FZKTDispatch_after.m
//  Connector
//
//  Created by czl on 2017/5/20.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKTDispatch_after.h"

@interface FZKTDispatch_after ()

@property (nonatomic,assign) CFTimeInterval time;

@end

@implementation FZKTDispatch_after



- (void)runDispatch_after:(NSTimeInterval)timer block:(dispatch_block_t)block{
    

    self.time = CFAbsoluteTimeGetCurrent();

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timer * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ((CFAbsoluteTimeGetCurrent()-self.time)<timer) {
            return;
        }
        block();
    });
}


@end
