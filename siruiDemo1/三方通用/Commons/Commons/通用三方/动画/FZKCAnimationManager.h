//
//  FZKCAnimationManager.h
//  Commons
//
//  Created by czl on 2017/4/5.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <POP.h>
@interface FZKCAnimationManager : NSObject


/**
 平移动画
 
 @param x y轴默认为0
 @param y Y轴默认为0
 @param view 需要平移的视图
 */
+ (void) springPopTranslationWithX:(CGFloat)x y:(CGFloat)y view:(UIView *)view;

/**
 旋转动画
 
 @param angle 旋转角度 默认为0 书写如1*M_PI,M_PI/2等
 @param view 需要旋转的视图
 */
+ (void) springPopRotatingWithAngle:(CGFloat)angle view:(UIView *)view;


/**
 缩放动画
 
 @param x y轴缩放倍数 默认为1
 @param y Y轴缩放倍数  默认为1
 @param view 需要缩放的视图
 */
+ (void) springPopZoomWithX:(CGFloat)x y:(CGFloat)y view:(UIView *)view;






@end
