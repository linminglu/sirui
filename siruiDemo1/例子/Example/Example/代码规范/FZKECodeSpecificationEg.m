//
//  FZKECodeSpecificationEg.m
//  Example
//
//  Created by czl on 2017/4/10.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKECodeSpecificationEg.h"

@implementation FZKECodeSpecificationEg


/*
 对于类的method: 左括号‘{’另起一行写
 */
- (void)sendUser:(NSString *)uer
{
    /*
     对于其他使用场景: 左括号‘{’跟在后边
     如以下三种方式等
     */
    /*
     方式1
     */
    if(uer){
    
    }
    /*
     方式2
     */
    switch (uer.length) {
        case 0:
            
            break;
            
        default:
            break;
    }
    /*
     方式3
     */
    do {
        
    } while (uer.length);
    
}

/*
任何需要写大括号的部分，不得省略
　　错误示例:

*/
- (void)wrongExamples
{
    BOOL someCondition = YES;
    if (someCondition)
        NSLog(@"this is wrong!!!");
    while(someCondition)
        NSLog(@"this is wrong!!!");
}
/*
 任何需要写大括号的部分，不得省略
 　　正确示例:
 
 */
- (void)rightExamples
{
    BOOL someCondition = YES;
    if (someCondition){
        NSLog(@"this is wrong!!!");
    }
    while(someCondition){
        NSLog(@"this is wrong!!!");
    }
}
@end
