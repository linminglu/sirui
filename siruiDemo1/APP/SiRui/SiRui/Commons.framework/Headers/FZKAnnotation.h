//
//  FZKAnnotation.h
//  Example
//
//  Created by czl on 2017/4/26.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol FZKAnnotation <NSObject>

///标注view中心坐标
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

@optional

///annotation标题
@property (nonatomic, copy) NSString *title;

///annotation副标题
@property (nonatomic, copy) NSString *subtitle;

/**
 * @brief 设置标注的坐标，在拖拽时会被调用.
 * @param newCoordinate 新的坐标值
 */
- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
