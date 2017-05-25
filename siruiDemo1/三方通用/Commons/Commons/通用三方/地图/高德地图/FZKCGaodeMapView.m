//
//  FZKCGaodeMapView.m
//  Commons
//
//  Created by czl on 2017/5/2.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCGaodeMapView.h"
#import <AMap3DMap/MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

@interface FZKCGaodeMapView ()<MAMapViewDelegate,AMapSearchDelegate>

@property (nonatomic,strong) AMapSearchAPI *poiGaodeSearch;

@property (nonatomic,strong) MAMapView *mapView;

@end
@implementation FZKCGaodeMapView



- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.mapView];
        
    }
    
    return self;
    
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self addSubview:self.mapView];
}



#pragma mark - getter
-(AMapSearchAPI *)poiGaodeSearch{
    
    if (!_poiGaodeSearch) {
        _poiGaodeSearch = [AMapSearchAPI new];
        _poiGaodeSearch.delegate = self;
        
    }
    
    return _poiGaodeSearch;
}

- (MAMapView *)mapView{
    
    if (!_mapView) {
        _mapView = [[MAMapView alloc]initWithFrame:self.bounds];
        _mapView.delegate = self;
    }
    return _mapView;
}

#pragma mark - 获取当前地图的中心地理坐标
- (CLLocationCoordinate2D)mapCenter{
    
    return self.mapView.centerCoordinate;
    
}

#pragma mark - 定位
- (void)updateLocationBlock:(getCurrentCoordinateBlock)coor{
    
    [FZKCMapManager shareMapManager].getCurrentCoordinate = ^ (CLLocationCoordinate2D coordinate){
        
        if (coor) {
            coor(coordinate);
        }
        
        
    };
    
    
    
}

#pragma mark - 设置地图中心点
- (void)setMapCenterCoordinate:(CLLocationCoordinate2D)coordinate{
    
    
    [_mapView setCenterCoordinate:coordinate animated:YES];
    
    
}

#pragma mark - 添加标注
- (void)addAnimation:(id<FZKAnnotation>)anim{
    
    
    [_mapView addAnnotation:anim];
    
}


- (void)addAnimations:(NSArray<id<FZKAnnotation>> *)anims{
    
    
    [_mapView addAnnotations:anims];
    
    
}

- (void)removeAllAnimations{
    
    [_mapView removeAnnotations:_mapView.annotations];
    
}




#pragma mark - 遮罩层
- (void)removeAllOverlys{
    
    [_mapView removeOverlays:_mapView.overlays];
    
    
}


- (void)addOverly:(CLLocationCoordinate2D *)locations count:(NSInteger)count{
    
    
    
    
    
    
     MAPolyline *linePloygon = [MAPolyline polylineWithCoordinates:locations count:count];
    
    //在地图上添加折线对象
    [_mapView addOverlay:linePloygon];
    
    //          设置显示范围
    [self setMaVision:_mapView overlay:linePloygon.points count:count];
    
    
    
    
    
}

#pragma mark - 关键字搜索
- (void)searchText:(NSString *)keyword{
    
    
    
    [self gaodePoiSearch:keyword];
    
    
    
    
    
}

#pragma mark - 设置遮罩层显示区域
- (void)setMaVision:(MAMapView *)view overlay:(MAMapPoint *)points count:(NSInteger)count{
    //    设置轨迹显示范围
    CGFloat ltX, ltY, rbX, rbY;
    MAMapPoint pt = points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < count; i++) {
        MAMapPoint pt = points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    
    MAMapRect rect;
    rect.origin = MAMapPointMake(ltX , ltY);
    rect.size = MAMapSizeMake(rbX - ltX, rbY - ltY);
    [view setVisibleMapRect:rect];
    
    view.zoomLevel = view.zoomLevel - 0.3;
    
}


#pragma mark - 高德搜索
- (void)gaodePoiSearch:(NSString *)keyword{
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    request.location            = [AMapGeoPoint locationWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];
    request.keywords            = keyword;
    request.radius              = 3000;
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    
    [self.poiGaodeSearch AMapPOIAroundSearch:request];
    
}


- (UIView *)dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier{
    
    return [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
}

#pragma mark - MAMapViewDelegate
/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    if ([self.mapDelegate respondsToSelector:@selector(fzk_mapView:regionDidChangeAnimated:)]) {
        [self.mapDelegate fzk_mapView:self regionDidChangeAnimated:animated];
    }
}

/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation{
    
    if ([self.mapDelegate respondsToSelector:@selector(fzk_mapView:viewForAnnotation:)]) {
        return  [self.mapDelegate fzk_mapView:self viewForAnnotation:annotation];
    }
    return nil;
}

/**
 * @brief 当选中一个annotation views时，调用此接口
 * @param mapView 地图View
 * @param view 选中的annotation views
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    if ([self.mapDelegate respondsToSelector:@selector(fzk_mapView:didSelectAnnotationPoint:)]) {
        [self.mapDelegate fzk_mapView:self didSelectAnnotationPoint:view.annotation.coordinate];
    }
    
}

/**
 * @brief 根据overlay生成对应的Renderer
 * @param mapView 地图View
 * @param overlay 指定的overlay
 * @return 生成的覆盖物Renderer
 */
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay{
    
//    if ([self.mapDelegate respondsToSelector:@selector(fzk_mapView:rendererForOverlay:)]) {
//        [self.mapDelegate fzk_mapView:self rendererForOverlay:overlay];
//    }
    return nil;
}

/**
 * @brief 单击地图回调，返回经纬度
 * @param mapView 地图View
 * @param coordinate 经纬度
 */
- (void)mapView:(MAMapView *)mapView didSingleTappedAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    if ([self.mapDelegate respondsToSelector:@selector(fzk_mapView:onClickedMapBlank:)]) {
        [self.mapDelegate fzk_mapView:self onClickedMapBlank:coordinate];
    }
}

#pragma mark - 搜索结果处理
/**
 * @brief POI查询回调函数
 * @param request  发起的请求，具体字段参考 AMapPOISearchBaseRequest 及其子类。
 * @param response 响应结果，具体字段参考 AMapPOISearchResponse 。
 */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    
//    if ([self.mapDelegate respondsToSelector:@selector(fzk_mapView:onGetPoiResults:)]) {
//        [self.mapDelegate fzk_mapView:self onGetPoiResults:response.pois];
//    }
}

-(void)dealloc{
    
    self.mapView.delegate = nil;
    self.poiGaodeSearch.delegate = nil;
}
@end
