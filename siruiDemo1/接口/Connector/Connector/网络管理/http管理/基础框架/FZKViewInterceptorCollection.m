//
//  FZKViewInterceptorCollection.m
//  SRN
//
//  Created by 马宁 on 2017/3/1.
//  Copyright © 2017年 Fuizk. All rights reserved.
//

#import "FZKViewInterceptorCollection.h"

@implementation FZKViewInterceptorCollection

- (id) init
{
    if(self = [super init]){
        self.list = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) runOnStart{
    for(FZKViewInterceptor * interceptor in _list){
        [interceptor runOnStart];
    }
}

- (void) runOnComplet{
    for(FZKViewInterceptor * interceptor in _list){
        [interceptor runOnComplet];
    }
}

-(void) addInterceptor:(FZKViewInterceptor *)interceptor{
    [_list addObject:interceptor];
}

@end
