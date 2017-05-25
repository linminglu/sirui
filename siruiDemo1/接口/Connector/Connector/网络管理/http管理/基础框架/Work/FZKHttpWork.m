//
//  HttpWork.m
//  SRN
//
//  Created by 马宁 on 2017/3/1.
//  Copyright © 2017年 Fuizk. All rights reserved.
//

#import "FZKHttpWork.h"
#import "SMKAction.h"
#import "FZKActionResult.h"
#import "FZKBDomainConfig.h"

@implementation FZKHttpWork

-(void) runThenCallback:(ResultAction)callback{
    FZKActionResult* result = [[FZKActionResult alloc] init];
    result.resultCode = 1;
    
    [[SMKAction sharedAction] sendRequest:self progress:nil success:^(id responseObject) {
        if (responseObject) {
//            NSLog(@"FZKHttpWork responseObject %@",responseObject);
            result.resultCode = [[[responseObject objectForKey:@"result"] objectForKey:@"resultCode"] integerValue];
            result.resultMessage = [[responseObject objectForKey:@"result"] objectForKey:@"resultMessage"];
            result.paramters = responseObject;
            callback(result);
        }else{
            callback(result);
        }
    } failure:^(NSError *error) {
//        NSLog(@"FZKHttpWork error %@",error);
        
        result.resultMessage = error.localizedDescription;
        callback(result);
    }];
}


- (void)smk_requestConfigures {
    self.smk_scheme = @"http";
//    self.smk_host = GATE_RELEASE;
    self.smk_path = _urlPath;
    self.smk_method = SMKRequestMethodPOST;
}

- (id)smk_requestParameters {
    
    
    
    return self.parameters;

}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self onSuncc:^(FZKActionResult *result) {
//            业务代码在子线程处理
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                 [self progress:result];
//            });
           
        }];
    }
    return self;
}

#pragma mark - override
- (void)progress:(FZKActionResult *)result{

    
    
}


@end
