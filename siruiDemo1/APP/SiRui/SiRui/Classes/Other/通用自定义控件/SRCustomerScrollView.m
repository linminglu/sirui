//
//  SRCustomerScrollView.m
//  SiRui
//
//  Created by czl on 2017/5/5.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRCustomerScrollView.h"

@implementation SRCustomerScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/**
左侧边缘手势

@param gestureRecognizer 手势
@return yes
*/

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self];
    CGPoint location = [gestureRecognizer locationInView:self];
    
//    if(location.x>[UIScreen mainScreen].bounds.size.width+60){
//        self.scrollEnabled = NO;
//    }else{
//        self.scrollEnabled = YES;
//    }
//    NSLog(@"velocity.x:%f----location.x:%d",velocity.x,(int)location.x%(int)[UIScreen mainScreen].bounds.size.width);
//    if (velocity.x > 0.0f&&(int)location.x%(int)[UIScreen mainScreen].bounds.size.width<20) {
    if(velocity.x>0 && location.x<60){
        return NO;
    }
    
    return YES;
}


@end
