//
//  SRWindowsImageView.h
//  SiRui
//
//  Created by czl on 2017/4/19.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRCarLocksImageView : UIImageView



/**
 初始化图片并设置不通状态下的突破样式

 @param frame frame description

 @return return value description
 */
- (instancetype)initWithFrame:(CGRect)frame onIm:( UIImage * _Nonnull )onIm offIm:( UIImage * _Nonnull )offIm;




/**
 是否可以拖动
 */
@property (nonatomic,assign) BOOL isCanTouch;

@end
