//
//  FZKCMapNaviTool.h
//  Commons
//
//  Created by 宋搏 on 2017/4/25.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;

@interface FZKCMapNaviTool : UIView

+ (void)showNaviView;

+ (void)dismiss;

+ (void)setDestinationCoordinate:(CLLocationCoordinate2D)coordinate ToLocationName:(NSString *)name;

@end
