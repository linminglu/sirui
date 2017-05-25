
//
//  FZKEBaseMapView.m
//  Example
//
//  Created by czl on 2017/4/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKEBaseMapView.h"

@implementation FZKEBaseMapView



/**
 获取当前地图坐标
 
 @return 坐标
 */
- (CLLocationCoordinate2D)mapCenter{

    return CLLocationCoordinate2DMake(0, 0);
}


/**
 添加一个标注
 
 @param anim
 */
- (void)addAnimation:(id<FZKAnnotation>)anim{

}

- (void)setMapCenterCoordinate:(CLLocationCoordinate2D)coordinate{

}



/**
 添加一组标注
 
 @param anims
 */
- (void)addAnimations:(NSArray<id<FZKAnnotation>> *)anims{

}


/**
 删除所有标注
 */
- (void)removeAllAnimations{

}


/**
 添加运动轨迹
 
 @param locations 坐标数组
 @param count 坐标数组个数
 */
- (void)addOverly:(CLLocationCoordinate2D *)locations count:(NSInteger)count{

}

//- (void)addOverlys:(NSArray<id<FZKOverlay>> *)overlays;


/**
 删除轨迹
 */
- (void)removeAllOverlys{

}


/**
 搜索
 
 @param keyword 关键字
 */
- (void)searchText:(NSString *)keyword{

}

- (void)updateLocationBlock:(getCurrentCoordinateBlock)coor{

}

- (UIView *)dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier{

    return nil;
    
}


#pragma mark - getter
-(NSMutableArray *)anims{

    if (!_anims) {
        _anims = [NSMutableArray new];
    }
    return _anims;
}
@end
