//
//  FZKCMapManager.h
//  Commons
//
//  Created by czl on 2017/3/29.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "FZKCSportPointAnnotation.h"
//百度地图
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

#import <MAMapKit/MAMapKit.h>

#import <CoreLocation/CoreLocation.h>

/**
 配置地图类型
 
 - MapTypeBaidu:
 */
typedef NS_ENUM(NSInteger,MapType){
    
    MapTypeBaidu,//采用百度地图
    MapTypeGaode,//高德地图
    MapTypeAll //所有地图都采用
    
};

// 自定义BMKAnnotationView，用于显示运动者
@interface SportAnnotationView : BMKAnnotationView

@property (nonatomic, strong) UIImageView *imageView;

@end


// 运动结点信息类
@interface FZKSportNode : NSObject

//经纬度
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
//方向（角度）
@property (nonatomic, assign) CGFloat angle;
//距离
@property (nonatomic, assign) CGFloat distance;
//速度
@property (nonatomic, assign) CGFloat speed;
//地址
@property (nonatomic,copy) NSString *address;

//时间
@property (nonatomic,copy) NSString *time;

@end


/**
 获取当前坐标的回调

 @param coordinate 坐标
 */
typedef void(^getCurrentCoordinateBlock)(CLLocationCoordinate2D coordinate);


/**
 获取反地理编码

 @param address 文字处理
 */
typedef void(^reverseGeoMapBlock)(NSString *address);

@interface FZKCMapManager : NSObject


+ (instancetype) shareMapManager;
/**
 获取当前坐标的回调
 */
@property (nonatomic,copy) getCurrentCoordinateBlock getCurrentCoordinate;



/*
 当前坐标
 */
@property (nonatomic,assign) CLLocationCoordinate2D currentCoordinate;


/**
 当前用户是否在国外
 */
@property (nonatomic,assign) BOOL isForeign;







//- (void)reverseGeoMap:(CLLocationCoordinate2D)coordinate callBack:(reverseGeoMapBlock)geoMap;

/**
 根据类型选择注册的地图
 
 @param maptype 注册地图类型
 */
+ (void)registerMapType:(MapType)maptype;


/**
 轨迹处理标注视图方法

 @param annotation 标注
 @return 标注视图
 */
+(BMKAnnotationView *)BaiduMapTraceViewForAnnotation:(FZKCSportPointAnnotation *)annotation  mapView:(BMKMapView *)mapView;





/**
 发起周边搜索

 @param keyWord 关键字
  @param radius 搜索半径
 @param coordinate 坐标
 @param poiSearch poi搜索类 包含高德和百度
 */
+(void)nearSearhKey:(NSString *)keyWord radius:(NSInteger)radius coordinate:(CLLocationCoordinate2D)coordinate  poiSearch:(id)poiSearch;




/**
 添加运动轨迹并显示
 
 @param locations
 @param mapView
 */
+ (void)addBaiduTraceWithlocations:(FZKSportNode *)locations toMapView:(BMKMapView *)mapView;

/**
 
 反地理编码
 
 @param coordinate 坐标
 @param geoMap 位置
 */
- (void)reverseGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate callBack:(reverseGeoMapBlock)callBack;


/**
 开始轨迹运动
 */
+ (void)startBaiduTrace;

/**
 暂停轨迹移动使用
 */
+(void)stopBaiduTrace;


/**
 设置轨迹当前位置

 @param index index description
 */
+(void)setCurrentIndex:(NSInteger)index;

/**
 返回当前轨迹位置

 @return 当前轨迹位置
 */
+(NSInteger)currentIndex;


/**
 调起三方地图应用导航


 @param endNode 终点
 */
+ (void)openThirdMapNode:(CLLocationCoordinate2D)endNode;



/**
 地理坐标转换为百度坐标

 @param coor 地理坐标
 @return 百度坐标
 */
#pragma mark - 坐标转换
+ (BMKMapPoint)convertBmkPoint:(CLLocationCoordinate2D)coor;


/**
  地理坐标转换为高德坐标

 @param coor 地理坐标
 @return 高德坐标
 */
+ (MAMapPoint)convertMaMapPoint:(CLLocationCoordinate2D)coor;


//百度地图反编译
- (void)reverseGeoMap:(CLLocationCoordinate2D)coordinate callBack:(reverseGeoMapBlock)geoMap;
@end
