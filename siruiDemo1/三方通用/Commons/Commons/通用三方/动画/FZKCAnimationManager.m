//
//  FZKCAnimationManager.m
//  Commons
//
//  Created by czl on 2017/4/5.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCAnimationManager.h"

@implementation FZKCAnimationManager


/**
 平移动画
 
 @param x y轴
 @param y Y轴
 @param view 需要平移的视图
 */
+(void) springPopTranslationWithX:(CGFloat)x y:(CGFloat)y view:(UIView *)view{

    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    
    CGPoint point = view.center;    

    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(point.x+x, point.y+y)];
    
    [view pop_addAnimation:anim forKey:kPOPLayerPosition];
    
}

/**
 旋转动画
 
 @param angle 旋转角度
 @param view 需要平移的视图
 */
+(void) springPopRotatingWithAngle:(CGFloat)angle view:(UIView *)view{

    POPSpringAnimation *basic = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerRotation];
    //    basic.fromValue=@(_sourceView.layer);

    basic.toValue = @(angle);
    //    basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer pop_addAnimation:basic forKey:kPOPLayerRotation];
}


/**
 缩放动画
 
 @param x x轴缩放倍数
 @param y Y轴缩放倍数
 @param view 需要平移的视图
 */
+(void) springPopZoomWithX:(CGFloat)x y:(CGFloat)y view:(UIView *)view{
    
    POPSpringAnimation *basic = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    //    basic.fromValue=@(_sourceView.layer);
    
    basic.toValue = [NSValue valueWithCGSize:CGSizeMake(x==0.0?1.0:x, y==0.0?1.0:y)];
    
    [view.layer pop_addAnimation:basic forKey:kPOPLayerScaleXY];
    
    
}



@end
