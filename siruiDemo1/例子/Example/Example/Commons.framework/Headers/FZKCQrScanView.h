//
//  FZKCQrScanView.h
//  bussiceTest
//
//  Created by czl on 2017/4/11.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FZKCQrScanView;
@protocol QrScanDelegate <NSObject>


/**
 扫描代理

 @param QrScanView 扫描视图
 @param value 扫描后返回的数据
 */
- (void)QrScanView:(FZKCQrScanView *)QrScanView value:(NSString *)value;

@end

@interface FZKCQrScanView : UIView


@property (nonatomic,weak) id<QrScanDelegate> delegate;


/**
 开始扫描
 */
- (void)start;


/**
 停止扫描
 */
- (void)stop;


@end
