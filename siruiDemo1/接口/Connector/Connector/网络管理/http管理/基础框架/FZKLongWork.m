//
//  LongWork.m
//  SRN
//
//  Created by 马宁 on 2017/3/1.
//  Copyright © 2017年 Fuizk. All rights reserved.
//

#import "FZKLongWork.h"

@implementation FZKLongWork

-(id)init{
    if(self=[super init]){
        _parameters = [[NSMutableDictionary alloc] init];
        _interceptorCollection = [[FZKViewInterceptorCollection alloc] init];
        _actionList = [[NSMutableArray alloc] init];

    }
    return self;
}

-(void) runThenCallback:(ResultAction) callback{
    
}

-(void) addPara:(NSString *)key withValue:(NSString *)value{
    if (value) {
        [_parameters setObject:value forKey:key];
    }
    
}


-(void) run{
    [_interceptorCollection runOnStart];
    [self runThenCallback:^(FZKActionResult *result) {
        [_interceptorCollection runOnComplet];
        for(FZKResultActionFilter* action in _actionList){
            [action doActionWith:result];
        }
    }];
}

-(FZKLongWork*) addInterceptor:(FZKViewInterceptor *)interceptor{
    [_interceptorCollection addInterceptor:interceptor];
    return self;
}

//添加结果处理Block
-(FZKLongWork*) onResult:(ResultAction) handler{
    return [self setOnResult:handler withFilter:^BOOL(NSInteger code) {
        return YES;
    }];
}


//业务成功处理函数 resultCode = 0
-(FZKLongWork*) onSuncc:(ResultAction) handler{
    return [self setOnResult:handler withFilter:^BOOL(NSInteger code) {
        return code == 0;
    }];
}

//业务失败处理函数 resultCode != 0
-(FZKLongWork*) onError:(ResultAction) handler{
    return [self setOnResult:handler withFilter:^BOOL(NSInteger code) {
        return code != 0;
    }];
}


//特定resultCode返回结果处理函数
-(FZKLongWork*) onError:(ResultAction) handler WithCode:(NSInteger) resultCode{
    return [self setOnResult:handler withFilter:^BOOL(NSInteger code) {
        return code == resultCode;
    }];
}

-(FZKLongWork*) setOnResult:(ResultAction)action withFilter:(ResultFilter)filter{
    [_actionList addObject:[FZKResultActionFilter build:action withFilter:filter]];
    return self;
}

@end
