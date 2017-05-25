//
//  ViewInterceptor.m
//  SRN
//
//  Created by 马宁 on 2017/3/1.
//  Copyright © 2017年 Fuizk. All rights reserved.
//

#import "FZKViewInterceptor.h"

@implementation FZKViewInterceptor
//长时间任务开始执行前执行方法
-(void) runOnStart{
    NSLog(@"%@开始执行",self.key);
}

//长时间任务方法执行后执行方法
-(void) runOnComplet{
    NSLog(@"%@执行结束",self.key);
}
@end
