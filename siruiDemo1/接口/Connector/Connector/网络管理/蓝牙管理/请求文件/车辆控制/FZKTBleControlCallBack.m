//
//  FZKTBleControlCallBack.m
//  Connector
//
//  Created by czl on 2017/5/19.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKTBleControlCallBack.h"
#import "SRBLEEnum.h"

@implementation FZKTBleControlCallBack

-(void)setTimeOutFail:(CompleteBlock)timeOutFail{

    __weak typeof(self) weakSelf = self;
    if (timeOutFail) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kBLEScanTimeout * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (!self.isRun402) {
                timeOutFail([NSError errorWithDomain:@"发送指令超时" code:-1 userInfo:nil],weakSelf);
            }
        });
    }
}

@end
