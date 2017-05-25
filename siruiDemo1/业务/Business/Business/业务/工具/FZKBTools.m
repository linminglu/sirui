//
//  FZKBTools.m
//  Business
//
//  Created by czl on 2017/4/20.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBTools.h"

@implementation FZKBTools

+ (NSString *)urlEnCode:(NSString *)url{
    
    CGFloat vision = [[[UIDevice currentDevice] systemVersion] floatValue];
    if(vision<9.0){
        return [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }else{
        
        return  [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    
}


@end
