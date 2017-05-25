//
//  FZKEBaseMapView.h
//  Example
//
//  Created by czl on 2017/4/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MAMapKit/MAMapKit.h>
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapComponent.h>
#import "FZKAnnotation.h"
#import "FZKCMapManager.h"

@class FZKEBaseMapView;

//地图类型
typedef NS_ENUM(NSUInteger, FZKCMapType) {
    FZKCMapTypeBaidu,
    FZKCMapTypeGaode,
    FZKCMapTypeGoogle
};


@protocol FZKMapDelegate <NSObject>




@optional

/**
 * @brief 当选中一个annotation views时，调用此接口
 * @param mapView 地图View
 * @param view 选中的annotation views
 */
- (void)fzk_mapView:(FZKEBaseMapView *)mapView didSelectAnnotationPoint:(CLLocationCoordinate2D)coordinate2D;


/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)fzk_mapView:(FZKEBaseMapView *)mapView regionDidChangeAnimated:(BOOL)animated;

/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (UIView *)fzk_mapView:(FZKEBaseMapView *)mapView viewForAnnotation:(id <FZKAnnotation>)annotation;


/**
 * @brief 根据overlay生成对应的Renderer
 * @param mapView 地图View
 * @param overlay 指定的overlay
 * @return 生成的覆盖物Renderer
 */
//- (id)fzk_mapView:(FZKEBaseMapView *)mapView rendererForOverlay:(id)overlay;




/**
 点击地图空白处
 
 @param mapView 地图
 @return 坐标
 */

- (void)fzk_mapView:(FZKEBaseMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate2D;

/**
 *返回POI搜索结果
 
 *@param poiResult 搜索结果列表
 
 */
//- (void)fzk_mapView:(FZKEBaseMapView *)mapView onGetPoiResults:(NSArray *)poiResult;


@end

@interface FZKEBaseMapView : UIView


@property (nonatomic,weak) id<FZKMapDelegate> mapDelegate;


/**
 标注数组
 */
@property (nonatomic,strong) NSMutableArray *anims;


/**
 获取当前地图坐标 子类实现
 
 @return 坐标
 */
- (CLLocationCoordinate2D)mapCenter;



/**
 设置地图中心点  子类实现
 
 @param coordinate 坐标
 */
- (void)setMapCenterCoordinate:(CLLocationCoordinate2D)coordinate;


/**
 添加一个标注 子类实现
 
 @param anim
 */
- (void)addAnimation:(id<FZKAnnotation>)anim;


/**
 添加一组标注 子类实现
 
 @param anims
 */
- (void)addAnimations:(NSArray<id<FZKAnnotation>> *)anims;


/**
 删除所有标注 子类实现
 */
- (void)removeAllAnimations;


/**
 添加运动轨迹 子类实现
 
 @param locations 坐标数组
 @param count 坐标数组个数
 */
- (void)addOverly:(NSArray<FZKSportNode *> *)locations;


/**
 开始轨迹运动
 */
- (void)startTrance;


/**
 暂停轨迹运动
 */
- (void)pauseTrance;
//- (void)addOverlys:(NSArray<id<FZKOverlay>> *)overlays;

/**
 删除轨迹 子类实现
 */
- (void)removeAllOverlys;


/**
 搜索 子类实现
 
 @param keyword 关键字
 */
- (void)searchText:(NSString *)keyword;




/**
 定位 子类实现 定位后的回调
 */
- (void)updateLocationBlock:(getCurrentCoordinateBlock)coor;



- (void)reverseGeoMap:(CLLocationCoordinate2D)coordinate callBack:(reverseGeoMapBlock)geoMap;


#pragma mark -  百度反地理编码
- (void)bmk_reverseGeoMap:(CLLocationCoordinate2D)coordinate callBack:(reverseGeoMapBlock)geoMap;


/**
 获取标注视图 子类实现

 @param identifier 标记
 @return 标注视图
 */
- (UIView *)dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier;

/**
 开始定位
 */
-(void)startLocation;

@end
