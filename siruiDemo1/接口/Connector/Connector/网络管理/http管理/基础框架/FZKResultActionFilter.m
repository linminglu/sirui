//
//  ResultActionFilter.m
//  SRN
//
//  Created by 马宁 on 2017/3/1.
//  Copyright © 2017年 Fuizk. All rights reserved.
//

#import "FZKResultActionFilter.h"

@implementation FZKResultActionFilter

+(FZKResultActionFilter*) build:(ResultAction) action withFilter:(ResultFilter)filter{
    FZKResultActionFilter * result = [[FZKResultActionFilter alloc] init];
    result.action = action;
    result.filter = filter;
    return result;
}

-(void) doActionWith:(FZKActionResult *)result{

    if(_filter(result.resultCode)){
        _action(result);
    }
}


@end
