//
//  UITextField+SRUntils.m
//  SiRui
//
//  Created by czl on 2017/4/17.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "UITextField+SRUntils.h"
//#import <objc/runtime.h>

//static void *placeholderColorStrkey = &placeholderColorStrkey;



@implementation UITextField (SRUntils)

@dynamic placeColorStr;

-(void)setPlaceColorStr:(NSString *)placeColorStr
{
//    objc_setAssociatedObject(self, &placeholderColorStrkey, placeholderColorStr, OBJC_ASSOCIATION_COPY);
    NSString *str = nil;
    if ([placeColorStr hasPrefix:@"#"]) {
        str = placeColorStr;
    }else{
    
        str = [NSString stringWithFormat:@"#%@",placeColorStr];
    }
    [self setValue:[UIColor colorWithHexString:str] forKeyPath:@"_placeholderLabel.textColor"];
    
}

//-(void)setPlaceColor:(UIColor *)placeColor
//{
//    //    objc_setAssociatedObject(self, &placeholderColorStrkey, placeholderColorStr, OBJC_ASSOCIATION_COPY);
//
//    [self setValue:placeColor forKeyPath:@"_placeholderLabel.textColor"];
//    
//}



@end
