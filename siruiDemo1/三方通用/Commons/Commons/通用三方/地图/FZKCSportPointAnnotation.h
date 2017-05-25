//
//  FZKCSportPointAnnotation.h
//  Commons
//
//  Created by czl on 2017/3/30.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>

typedef NS_ENUM(NSUInteger, MapSportType) {
    MapSportTypeStart,//开始节点
    MapSportTypeSport,//运动节点
    MapSportTypeEnd//结束节点
};
@interface FZKCSportPointAnnotation : BMKPointAnnotation



/**
 运行角度
 */
@property (nonatomic,assign)CGFloat angle;


/**
 地图运动类型节点
 */
@property (nonatomic,assign) MapSportType sportType;

@end
