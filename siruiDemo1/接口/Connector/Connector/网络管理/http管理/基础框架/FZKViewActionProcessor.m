//
//  FZKViewActionProcessor.m
//  SRN
//
//  Created by 马宁 on 2017/3/1.
//  Copyright © 2017年 Fuizk. All rights reserved.
//

#import "FZKViewActionProcessor.h"

@implementation FZKViewActionProcessor

-(id)init{
    if(self = [super init]){
        _interceptorCollection = [[FZKViewInterceptorCollection alloc] init];
        _actionList = [[NSMutableArray alloc] init];
    }
    return  self;
}

-(FZKViewActionProcessor*) setWork:(FZKLongWork *)work{
    _longWork = work;
    return self;
}

-(void) run{
    [_interceptorCollection runOnStart];
    [_longWork runThenCallback:^(FZKActionResult *result) {
        [_interceptorCollection runOnComplet];
        for(FZKResultActionFilter* action in _actionList){
            [action doActionWith:result];
        }
    }];
}

-(FZKViewActionProcessor*) addInterceptor:(FZKViewInterceptor *)interceptor{
    [_interceptorCollection addInterceptor:interceptor];
    return self;
}

//添加结果处理Block
-(FZKViewActionProcessor*) onResult:(ResultAction) handler{
    return [self setOnResult:handler withFilter:^BOOL(NSInteger code) {
        return YES;
    }];
}


//业务成功处理函数 resultCode = 0
-(FZKViewActionProcessor*) onSuncc:(ResultAction) handler{
    return [self setOnResult:handler withFilter:^BOOL(NSInteger code) {
        return code == 0;
    }];
}

//业务失败处理函数 resultCode != 0
-(FZKViewActionProcessor*) onError:(ResultAction) handler{
    return [self setOnResult:handler withFilter:^BOOL(NSInteger code) {
        return code != 0;
    }];
}


//特定resultCode返回结果处理函数
-(FZKViewActionProcessor*) onError:(ResultAction) handler WithCode:(NSInteger) resultCode{
    return [self setOnResult:handler withFilter:^BOOL(NSInteger code) {
        return code == resultCode;
    }];
}

-(FZKViewActionProcessor*) setOnResult:(ResultAction)action withFilter:(ResultFilter)filter{
    [_actionList addObject:[FZKResultActionFilter build:action withFilter:filter]];
    return self;
}


@end
