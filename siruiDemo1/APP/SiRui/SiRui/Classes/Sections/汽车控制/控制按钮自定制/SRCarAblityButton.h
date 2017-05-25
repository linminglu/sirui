//
//  SRCarAblityButton.h
//  SiRui
//
//  Created by czl on 2017/4/20.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRCarAblityButton : UIButton




/**
 设置按钮不同状态下图片

 @param activeImageName 车功能on状态下图片名
 @param shutImageName   车功能off状态下图片名
 @param unknownImageName 车功能未知状态下图片名 未知状态按钮不能点击
 */
- (void)setCarAblityWithActiveImageName:(NSString *)activeImageName shutImageName:(NSString *)shutImageName unknownImageName:(NSString *)unknownImageName;


/**
 按钮功能状态
 */
@property (nonatomic,assign) NSInteger carState;



@end
