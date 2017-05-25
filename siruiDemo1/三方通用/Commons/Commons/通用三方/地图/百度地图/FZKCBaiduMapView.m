//
//  FZKCBaiduMapView.m
//  Commons
//
//  Created by czl on 2017/5/2.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCBaiduMapView.h"
#import "FZKPointAnnotation.h"
#import <FZKTools.h>

@interface  FZKCBaiduMapView()<BMKMapViewDelegate,BMKPoiSearchDelegate>

@property (nonatomic,strong) BMKMapView *mapView;

@property (nonatomic,strong) BMKPoiSearch *poiBaiduSearch;
@property (nonatomic,strong)  BMKLocationService* locService;



@end

@implementation FZKCBaiduMapView


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

-(BMKMapView *)mapView{
    
    if (!_mapView) {
        
        CGRect rect = FZKFlexibleFrame(self.bounds);
        _mapView = [[BMKMapView alloc]initWithFrame:rect];
        _mapView.delegate = self;
        _locService = [[BMKLocationService alloc]init];
        _locService.delegate =self;
    }
    return _mapView;
}

- (BMKPoiSearch *)poiBaiduSearch{
    
    if (!_poiBaiduSearch) {
        _poiBaiduSearch = [[BMKPoiSearch alloc]init];
        _poiBaiduSearch.delegate = self;
        
    }
    return _poiBaiduSearch;
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
    
    //    过滤标注
    NSArray *fifterArray = [self fifterAnims:anims];
    
    //    添加本地标注管理
    [self.anims addObjectsFromArray:fifterArray];
    
    //    添加过滤后标注
    [_mapView addAnnotations:fifterArray];
    [_mapView showAnnotations:fifterArray animated:YES];
    
}

- (void)removeAllAnimations{
    
    [_mapView removeAnnotations:_mapView.annotations];
    [self.anims removeAllObjects];
    
}





#pragma mark - 遮罩层
- (void)removeAllOverlys{
    
    [_mapView removeOverlays:_mapView.overlays];
    
    
}


- (void)addOverly:(NSArray<FZKSportNode *> *)locations{
    
    
    
    
    
    
    
    //删除之前标注和遮罩层
    [self removeAllOverlys];
    [self removeAllAnimations];
    
    [FZKCMapManager addBaiduTraceWithlocations:locations toMapView:_mapView];
    
    
    
    
}

#pragma mark - 关键字搜索
- (void)searchText:(NSString *)keyword{
    
    
    
    [self baiduPoiSearch:keyword];
    
    
    
    
    
}

#pragma mark - 设置可见区域
- (void)setBaiduVision:(BMKMapView *)view overlay:(BMKMapPoint *)points count:(NSInteger)count{
    //    设置轨迹显示范围
    CGFloat ltX, ltY, rbX, rbY;
    BMKMapPoint pt = points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < count; i++) {
        BMKMapPoint pt = points[i];
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
    
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [view setVisibleMapRect:rect];
    
    view.zoomLevel = view.zoomLevel - 0.3;
    
}

#pragma mark -  百度搜索
- (void)baiduPoiSearch:(NSString *)keyword{
    
    BMKNearbySearchOption  *option = [[BMKNearbySearchOption alloc]init];
    option.pageIndex = 0;
    option.pageCapacity = 50;
    option.location = _mapView.centerCoordinate;
    option.radius = 10000;
    //    NSLog(@"默认搜索半径1000");
    option.keyword = keyword;
    BOOL ok = [self.poiBaiduSearch poiSearchNearBy:option];
}

#pragma mark - 服用单元格
- (UIView *)dequeueReusableAnnotationViewWithIdentifier:(NSString *)identifier{
    
    return [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    
}

#pragma mark - BMKMapViewDelegate
/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    
    if ([self.mapDelegate respondsToSelector:@selector(fzk_mapView:regionDidChangeAnimated:)]) {
        [self.mapDelegate fzk_mapView:self regionDidChangeAnimated:animated];
    }
}

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    
    if ([annotation isKindOfClass:[FZKCSportPointAnnotation class]]) {
        
        return [FZKCMapManager BaiduMapTraceViewForAnnotation:annotation mapView:mapView];
    }
    
    if ([self.mapDelegate respondsToSelector:@selector(fzk_mapView:viewForAnnotation:)]) {
        
        if ([self.mapDelegate fzk_mapView:self viewForAnnotation:annotation]) {
            return [self.mapDelegate fzk_mapView:self viewForAnnotation:annotation];
        }
        
        if ([annotation isKindOfClass:[FZKPointAnnotation class]]) {
            NSString *AnnotationViewID = @"renameMark";
            BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
            if (annotationView == nil) {
                annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
                // 设置颜色
                annotationView.pinColor = BMKPinAnnotationColorPurple;
                // 从天上掉下效果
                annotationView.animatesDrop = YES;
                // 设置可拖拽
                annotationView.draggable = YES;
            }
            return annotationView;
        }
        return nil;
    }
    
    return nil;
}


/**
 *当选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param view 选中的annotation view
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    if ([self.mapDelegate respondsToSelector:@selector(fzk_mapView:didSelectAnnotationPoint:)]) {
        [self.mapDelegate fzk_mapView:self didSelectAnnotationPoint:view.annotation.coordinate];
    }
    
}



/**
 *点中底图空白处会回调此接口
 *@param mapview 地图View
 *@param coordinate 空白处坐标点的经纬度
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    
    if ([self.mapDelegate respondsToSelector:@selector(fzk_mapView:onClickedMapBlank:)]) {
        [self.mapDelegate fzk_mapView:self onClickedMapBlank:coordinate];
    }
}

/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay{
    
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *lineView = [[BMKPolylineView alloc]initWithPolyline:overlay];
        lineView.strokeColor = [[UIColor alloc] initWithRed:0.0 green:0.5 blue:1.0 alpha:0.6];
        lineView.lineWidth = 3.0;
        return lineView;
    }
    return nil;
}


#pragma mark - 搜索结果处理
/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode{
    
    if (errorCode==BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < poiResult.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            FZKPointAnnotation* item = [[FZKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            item.uid = poi.uid;
            [annotations addObject:item];
        }
        [self addAnimations:annotations];
    }
    
    
}


#pragma mark -  原生反地理编码
- (void)reverseGeoMap:(CLLocationCoordinate2D)coordinate callBack:(reverseGeoMapBlock)geoMap{
    
    [[FZKCMapManager shareMapManager]reverseGeocodeWithCoordinate:coordinate callBack:geoMap];
}

#pragma mark -  百度反地理编码
- (void)bmk_reverseGeoMap:(CLLocationCoordinate2D)coordinate callBack:(reverseGeoMapBlock)geoMap{
    
    [[FZKCMapManager shareMapManager]reverseGeoMap:coordinate callBack:geoMap];
}

-(void)dealloc{
    
    self.mapView.delegate = nil;
    self.poiBaiduSearch.delegate = nil;
}

- (NSArray *)fifterAnims:(NSArray *) anims{
    
    //获取地图上面所有坐标
    NSArray *abilityArray = self.anims;
    
    NSMutableArray *fifter = [NSMutableArray new];
    //添加过滤数组tags值
    for (FZKPointAnnotation *object in abilityArray) {
        [fifter addObject:object.uid];
        
    }
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"NOT (SELF.uid IN %@)",fifter];
    
    NSArray *array = [anims filteredArrayUsingPredicate:pre];
    
    return array;
    
}

/**
 开始轨迹运动
 */
- (void)startTrance{
    
    [FZKCMapManager startBaiduTrace];
}


/**
 暂停轨迹运动
 */
- (void)pauseTrance{
    
    [FZKCMapManager stopBaiduTrace];
}


/**
 开始定位
 */
-(void)startLocation{
    
    
    
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;
    _mapView.showsUserLocation = YES;
    
    
    
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [_mapView updateLocationData:userLocation];
}

@end
