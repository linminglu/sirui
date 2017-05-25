//
//  FZKCMapManager.m
//  Commons
//
//  Created by czl on 2017/3/29.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCMapManager.h"
#import "FZKAppkeyComon.h"
//#import <FZKTools.h>
//高德地图
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <MAMapKit/MATraceManager.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "FZKCSportPointAnnotation.h"
#import <MapKit/MapKit.h>






@implementation FZKSportNode

@synthesize coordinate = _coordinate;
@synthesize angle = _angle;
@synthesize distance = _distance;
@synthesize speed = _speed;

@end


@implementation SportAnnotationView

@synthesize imageView = _imageView;

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBounds:CGRectMake(0.f, 0.f, 22.f, 30.f)];
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.f, 0.f, 22.f, 30.f)];
        NSString *path = [[NSBundle mainBundle]pathForResource:@"Commons" ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:path];
//        NSLog(@"path:%@,bundle:%@",path,bundle);
        UIImage *im = [UIImage imageNamed:@"sportarrow" inBundle:bundle compatibleWithTraitCollection:nil];
//        NSLog(@"path:%@,bundle:%@,image:%@",path,bundle,im);
        _imageView.image = im;
        
        [self addSubview:_imageView];
    }
    return self;
}

@end









/*
 地图选择
 */
//static MapType selectMapType = MapTypeBaidu;

/*
 高德轨迹数组
 */
//static NSMutableArray<MAMultiPolyline *> *tranceGaodeArray;



/*
 当前高德绘制轨迹线程
 */

//static NSOperation *currentOP;


/*
 百度轨迹数组
 */
static NSMutableArray<FZKSportNode *> *tranceBaiduArray;

/*
 百度运动标注
 */
static FZKCSportPointAnnotation *sportAnnotation;

/*
 百度轨迹视图
 */
static SportAnnotationView *sportAnnotationView;

/*
 //百度轨迹点数
 */
//static NSInteger sportNodeNum;


/*
 //百度当前结点
 */
static NSInteger currentIndex=0;

/*
 判断百度地图轨迹移动是否停止
 */
static BOOL isStop=NO;




@interface FZKCMapManager ()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

/**
 定位服务
 */
@property (nonatomic,strong)BMKLocationService *locService;


/**
 是否定位开启服务
 */
@property (nonatomic,assign) BOOL locationServiceRun;


/**
 地理编码查询
 */
@property (nonatomic,strong)BMKGeoCodeSearch *geoSearch;

/**
 反编译
 */
@property (nonatomic,strong) CLGeocoder *geocoder;

@end

@implementation FZKCMapManager
{

    reverseGeoMapBlock currentCall;
    	BMKGeoCodeSearch* _geocodesearch;
    bool isGeoSearch;
    
}


#pragma mark -  根据类型选择注册的地图
+ (void)registerMapType:(MapType)maptype{
//    selectMapType = maptype;
    BMKMapManager *baiduManager = [BMKMapManager new];
//    switch (maptype) {
//        case MapTypeBaidu:
//            [baiduManager start:BaiduMapAppkey generalDelegate:nil];
//            break;
//        case MapTypeGaode:
//                        [AMapServices sharedServices].apiKey = GaodeMapAppkey;
//                        [[AMapServices sharedServices] setEnableHTTPS:YES];
//            break;
//            
//        default:
                        [AMapServices sharedServices].apiKey = GaodeMapAppkey;
                        [[AMapServices sharedServices] setEnableHTTPS:YES];
            
            [baiduManager start:BaiduMapAppkey generalDelegate:nil];
//            break;
//    }
    [FZKCMapManager shareMapManager].getCurrentCoordinate = ^ (CLLocationCoordinate2D coordinate){
        NSLog(@"%f,%f",coordinate.latitude,coordinate.longitude);
    };
}



#pragma mark -  高德地图处理方法


/**
 添加高德地图标注
 
 @param annotation
 @param mapView
 */
//+ (void)addGeodePointAnnotation:(id<MAAnnotation>)annotation toMapView:(MAMapView *)mapView{
//
//    [mapView addAnnotation:annotation];
//
//}


/**
 高德地图
 
 @param mapView 地图
 @param annotation 标注
 @return 标注视图
 */
//+(MAAnnotationView *)GaodeMapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[MAPointAnnotation class]])
//    {
//        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//        if (annotationView == nil)
//        {
//            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//        }
////        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
//        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
////        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
////        annotationView.pinColor = MAPinAnnotationColorPurple;
////        annotationView.image = [UIImage imageNamed:@"restaurant"];
//        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
//        annotationView.centerOffset = CGPointMake(0, -18);
//
//        return annotationView;
//    }
//    return nil;
//}





/**
 添加运行轨迹 高德地图
 
 @param locations 1、必填信息的缺失会导致纠偏失败，非必填信息的缺失会在一定程度影响最终纠偏结果，因此尽可能的多提供以下信息是确保绘制一条平滑轨迹的最佳方案。建议使用iOS定位SDK中定位精度高，有速度和角度返回的位置点数据。
 2、传入的经纬度点，必须是国内的坐标，轨迹纠偏功能不支持国外的坐标点的纠偏。
 
 @param type
 */
//+ (void)addGeodeTraceWithlocations:(NSArray<MATraceLocation *> *)locations type:(AMapCoordinateType)type toMapView:(MAMapView *)mapView{
////    __weak typeof(self) wSelf = self;
//    MATraceManager *manager = [MATraceManager new];
//  NSOperation *op = [manager queryProcessedTraceWith:locations type:AMapCoordinateTypeBaidu processingCallback:^(int index, NSArray<MATracePoint *> *points) {
//        [self addGeodeSubTrace:points toMapView:mapView];
//    } finishCallback:^(NSArray<MATracePoint *> *points, double distance) {
//        currentOP = nil;
////        [currentOP cancel];
//        [self addGeodeFullTrace:points toMapView:mapView];
//
////        [weakSelf.resultLabel setHidden:NO];
////        weakSelf.resultLabel.text = [NSString stringWithFormat:@"距离:%.0f米", distance];
////        [weakSelf.resultLabel sizeToFit];
//
//
//    } failedCallback:^(int errorCode, NSString *errorDesc) {
//         NSLog(@"Error: %@", errorDesc);
//        currentOP = nil;
//    }];
//    currentOP = op;
//}



/**
 绘制所有运动轨迹
 
 @param tracePoints <#tracePoints description#>
 @param mapView <#mapView description#>
 */
//+ (void)addGeodeFullTrace:(NSArray<MATracePoint*> *)tracePoints toMapView:(MAMapView *)mapView{
//    MAMultiPolyline *polyline = [self makeGeodePolyLineWith:tracePoints];
//    if(!polyline) {
//        return;
//    }
//
////    if(mapView == self.mapView2) {
////        [mapView removeOverlays:self.processedOverlays];
////        [self.processedOverlays removeAllObjects];
////    } else {
////        [mapView removeOverlays:self.origOverlays];
////        [self.origOverlays removeAllObjects];
////    }
//
//    [mapView setVisibleMapRect:MAMapRectInset(polyline.boundingMapRect, -1000, -1000)];
//
////    if(mapView == self.mapView2) {
////        [self.processedOverlays addObject:polyline];
////        [mapView addOverlays:self.processedOverlays];
////    } else {
////        [self.origOverlays addObject:polyline];
////        [mapView addOverlays:self.origOverlays];
////    }
//    if (!tranceGaodeArray) {
//        tranceGaodeArray = [NSMutableArray new];
//    }
////    [mapView removeOverlays:tranceArray];
//
//    [tranceGaodeArray addObject:polyline];
//    [mapView addOverlays:tranceGaodeArray];
//
//    [tranceGaodeArray removeAllObjects];
//}


/**
 高德地图绘制一段轨迹
 
 @param tracePoints
 @param mapView
 */
//+ (void)addGeodeSubTrace:(NSArray<MATracePoint*> *)tracePoints toMapView:(MAMapView *)mapView {
//    MAMultiPolyline *polyline = [self makeGeodePolyLineWith:tracePoints];
//    if(!polyline) {
//        return;
//    }
//
//    MAMapRect visibleRect = [mapView visibleMapRect];
//    if(!MAMapRectContainsRect(visibleRect, polyline.boundingMapRect)) {
//        MAMapRect newRect = MAMapRectUnion(visibleRect, polyline.boundingMapRect);
//        [mapView setVisibleMapRect:newRect];
//    }
//
////    if(mapView == self.mapView2) {
////        [self.processedOverlays addObject:polyline];
////    } else {
////        [self.origOverlays addObject:polyline];
////    }
//    if (!tranceGaodeArray) {
//        tranceGaodeArray = [NSMutableArray new];
//    }
//    [tranceGaodeArray addObject:polyline];
//    [mapView addOverlay:polyline];
//}


//+ (MAMultiPolyline *)makeGeodePolyLineWith:(NSArray<MATracePoint*> *)tracePoints {
//    if(tracePoints.count == 0) {
//        return nil;
//    }
//
//    CLLocationCoordinate2D *pCoords = malloc(sizeof(CLLocationCoordinate2D) * tracePoints.count);
//    if(!pCoords) {
//        return nil;
//    }
//
//    for(int i = 0; i < tracePoints.count; ++i) {
//        MATracePoint *p = [tracePoints objectAtIndex:i];
//        CLLocationCoordinate2D *pCur = pCoords + i;
//        pCur->latitude = p.latitude;
//        pCur->longitude = p.longitude;
//    }
//
//    MAMultiPolyline *polyline = [MAMultiPolyline polylineWithCoordinates:pCoords count:tracePoints.count drawStyleIndexes:@[@10, @60]];
//
//    if(pCoords) {
//        free(pCoords);
//    }
//
//    return polyline;
//}


/**
 取消高德地图绘制线程
 */
//- (void)cancelGeodeAction {
//    if(currentOP) {
//        [currentOP cancel];
//
//        currentOP = nil;
//    }
//}


#pragma mark - 百度地图


/**
 百度地图处理标注视图方法
 
 @param mapView 地图
 @param annotation 标注
 @return 标注视图
 */
+(BMKAnnotationView *)BaiduMapTraceViewForAnnotation:(FZKCSportPointAnnotation *)annotation mapView:(BMKMapView *)mapView{
    
    
    if (annotation.sportType==MapSportTypeSport) {
        sportAnnotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"sportsAnnotation"];
        
        if (sportAnnotationView==nil) {
           sportAnnotationView = [[SportAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"sportsAnnotation"];
        }
        
        
//        sportAnnotationView.draggable = NO;
//        FZKSportNode *node = [tranceBaiduArray firstObject];
//        sportAnnotationView.imageView.transform = CGAffineTransformMakeRotation(node.angle);
        return sportAnnotationView;
        
    }else{
        
        SportAnnotationView *animView = ( SportAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"tranceSport"];
        if (animView==nil) {
            animView = [[SportAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"tranceSport"];
            animView.imageView.image = (annotation.sportType == MapSportTypeStart)?[self imageName:@"qidian"]:[self imageName:@"zhondian"];
        }
        
        return animView;
    }
    
    
    
}



/**
 添加运动轨迹标记
 
 @param locations
 @param mapView
 */
+ (void)addBaiduTraceWithlocations:(NSArray<FZKSportNode *> *)locations toMapView:(BMKMapView *)mapView{
    
    CLLocationCoordinate2D paths[locations.count];
    for (NSInteger i = 0; i < locations.count; i++) {
        FZKSportNode *node = locations[i];
        paths[i] = node.coordinate;
    }
    currentIndex = 0;
    isStop = NO;
    //    添加运动轨迹
    BMKPolyline *linePloygon = [BMKPolyline polylineWithCoordinates:paths count:locations.count];
    [mapView addOverlay:linePloygon];
    
     sportAnnotationView = nil;
    
    //    保存运动轨迹数组
    if (!tranceBaiduArray) {
        tranceBaiduArray = [NSMutableArray new];
    }else{
        
        [tranceBaiduArray removeAllObjects];
    }
    [tranceBaiduArray addObjectsFromArray:locations];
    
    //    添加轨迹标识
    if(locations.count>0){
        
        //添加开始标注
       [mapView addAnnotation:[self animWithtype:MapSportTypeStart coordinate:paths[0]]];
        //添加结束标注
       [mapView addAnnotation:[self animWithtype:MapSportTypeEnd coordinate:paths[locations.count-1]]];
        
        //添加运动标注
        sportAnnotation = [[FZKCSportPointAnnotation alloc]init];
        sportAnnotation.coordinate = paths[currentIndex];

        sportAnnotation.sportType = MapSportTypeSport;

        [mapView addAnnotation:sportAnnotation];
        
        
        //    设置轨迹显示范围
        CGFloat ltX, ltY, rbX, rbY;
        BMKMapPoint pt = linePloygon.points[0];
        ltX = pt.x, ltY = pt.y;
        rbX = pt.x, rbY = pt.y;
        for (int i = 1; i < linePloygon.pointCount; i++) {
            BMKMapPoint pt = linePloygon.points[i];
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
        [mapView setVisibleMapRect:rect];
        
        mapView.zoomLevel = mapView.zoomLevel - 0.3;
        
    }
    
    
}



+ (FZKCSportPointAnnotation *)animWithtype:(MapSportType)type coordinate:(CLLocationCoordinate2D)coordinate{
    FZKCSportPointAnnotation *sport = [[FZKCSportPointAnnotation alloc]init];
    sport.sportType = type;
    sport.coordinate = coordinate;
    return sport;
    
}

//runing
+ (void)running:(BOOL)isCanSport{
    isStop = !isCanSport;
    
    if (isStop) {
        
        return;
        
    }else{
        if (currentIndex==tranceBaiduArray.count-1) {
            currentIndex=0;
        }
        
    }
    
    
    FZKSportNode *node = [tranceBaiduArray objectAtIndex:currentIndex % tranceBaiduArray.count];
    sportAnnotation.angle = node.angle;
    sportAnnotation.coordinate = node.coordinate;
//    sportAnnotationView.imageView.transform = CGAffineTransformMakeRotation(node.angle);
    [UIView animateWithDuration:node.distance/node.speed animations:^{
        currentIndex++;
        FZKSportNode *node = [tranceBaiduArray objectAtIndex:currentIndex % tranceBaiduArray.count];
        sportAnnotation.coordinate = node.coordinate;
        //        sportAnnotation.angle = node.angle;
//        sportAnnotationView.imageView.transform = CGAffineTransformMakeRotation(node.angle);
    } completion:^(BOOL finished) {
        
        //        [self running];
        if (currentIndex == tranceBaiduArray.count-1) {
            //             [_mapView removeAnnotations:_mapView.annotations];
            currentIndex = 0;
            [sportAnnotationView.superview sendSubviewToBack:sportAnnotationView];
            sportAnnotationView.hidden = YES;
            isStop = YES;
        }
        
        if (!isStop) {
            [self running:YES];
        }
        
        
        
    }];
}

+(void)setCurrentIndex:(NSInteger)index{
    
    currentIndex = index;
    [self startBaiduTrace];
}
+ (NSInteger)currentIndex{
    
    return currentIndex;
}
+ (void)startBaiduTrace{
    
    isStop = NO;
    [sportAnnotationView.superview bringSubviewToFront:sportAnnotationView];
    sportAnnotationView.hidden = NO;
    [self running:YES];
}


/**
 暂停轨迹移动使用
 */
+(void)stopBaiduTrace{
    
    isStop = YES;
    
}




#pragma mark - 百度地图周边检索功能

+(void)nearSearhKey:(NSString *)keyWord radius:(NSInteger)radius coordinate:(CLLocationCoordinate2D)coordinate poiSearch:(id)poiSearch{
    
    if([poiSearch isKindOfClass:[BMKBasePoiSearchOption class]]){
        //发起百度检索
        BMKNearbySearchOption *option = [[BMKNearbySearchOption alloc]init];
        option.pageIndex = 0;
        option.pageCapacity = 50;
        option.location = coordinate;
        option.radius = radius;
        //    NSLog(@"默认搜索半径1000");
        option.keyword = keyWord;
        BOOL flag = [poiSearch poiSearchNearBy:option];
        
        
        if(flag)
        {
            NSLog(@"周边检索发送成功");
        }
        else
        {
            NSLog(@"周边检索发送失败");
        }
        
    }
    else if ([poiSearch isKindOfClass:[AMapSearchAPI class]]){
        //    高德地图搜索
        AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
        
        request.location            = [AMapGeoPoint locationWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        request.keywords            = keyWord;
        request.radius              = radius;
        /* 按照距离排序. */
        request.sortrule            = 0;
        request.requireExtension    = YES;
        AMapSearchAPI *api = [AMapSearchAPI new];
        [poiSearch AMapPOIAroundSearch:request];
    }
}


#pragma mark - 初始化操作

+ (instancetype) shareMapManager{
    static FZKCMapManager *mamger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mamger = [[FZKCMapManager alloc]init];
    });
    return mamger;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self locService];
    }
    return self;
}


#pragma mark - getter
- (BMKLocationService *)locService
{
    if (!_locService) {
        
        _locService = [BMKLocationService new];
        _locService.delegate = self;
        [_locService startUserLocationService];
    }
    return _locService;
    
}
-(BMKGeoCodeSearch *)geoSearch{

    if (!_geoSearch) {
        _geoSearch = [BMKGeoCodeSearch new];
        _geoSearch.delegate = self;
    }
    
    return _geoSearch;
    
}

- (CLGeocoder *)geocoder{

    if (!_geocoder) {
        _geocoder = [CLGeocoder new];
    }
    return _geocoder;
}

#pragma mark - setter
- (void)setGetCurrentCoordinate:(getCurrentCoordinateBlock)getCurrentCoordinate{
    self.locationServiceRun = YES;
    _getCurrentCoordinate = getCurrentCoordinate;
    
}

- (void)setLocationServiceRun:(BOOL)locationServiceRun{
    _locationServiceRun = locationServiceRun;
    if (_locationServiceRun) {
        _locService.delegate = self;
        [_locService startUserLocationService];
        
    }else{
        [_locService stopUserLocationService];
        
        _locService.delegate = nil;
        
    }
}
#pragma mark - 定位代理

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    self.currentCoordinate = userLocation.location.coordinate;
    if(self.getCurrentCoordinate){
    self.getCurrentCoordinate(self.currentCoordinate);
    }
    
    self.locationServiceRun = NO;
    
//    [self reverseGeoMap:self.currentCoordinate callBack:nil];

}

#pragma mark - 反地理编码
- (void)reverseGeoMap:(CLLocationCoordinate2D)coordinate callBack:(reverseGeoMapBlock)geoMap{

    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = coordinate;
    
    BOOL flag = [self.geoSearch reverseGeoCode:reverseGeoCodeSearchOption];
    if (geoMap) {
        currentCall = geoMap;
    }else{
    
        currentCall = nil;
    }
    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}


/**
 *定位失败后，会调用此函数
 *@param error 错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error{

    self.locationServiceRun = NO;
    
    //默认位置
    self.currentCoordinate = CLLocationCoordinate2DMake(39.915, 116.404);
    
    if (self.getCurrentCoordinate) {
        self.getCurrentCoordinate(self.currentCoordinate);
    
    }
//    [self reverseGeoMap:self.currentCoordinate callBack:nil];
}


- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (currentCall) {
        NSString *address = result.address.length>0?result.address:@"未知位置";
        currentCall(address);
        currentCall  = nil;
    }
    
//    if (error == BMK_SEARCH_NO_ERROR) {
        if ([result.addressDetail.country isEqualToString:@"中国"]) {
            self.isForeign = NO;
        }else{
        
            self.isForeign = YES;
        }
//    }
    
    _geoSearch.delegate = nil;
    _geoSearch =nil;
    
}



#pragma mark - 调起三方导航功能
+ (void)openThirdMapNode:(CLLocationCoordinate2D)endNode{
    
    [self addActive:[self getInstalledMapAppWithEndNode:endNode] endNode:endNode];
}


+(void)addActive:(NSArray *)array endNode:(CLLocationCoordinate2D)endNode{
    
    UIAlertController * alertVC = [UIAlertController alertControllerWithTitle:@"导航" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (NSDictionary *dic in array) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:dic[@"title"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([dic[@"title"] isEqualToString:@"苹果地图"]) {
                MKMapItem *currentLocation =[MKMapItem mapItemForCurrentLocation];
                
                MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:endNode addressDictionary:nil]];
                
                [MKMapItem openMapsWithItems:@[currentLocation,toLocation] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                                                                           MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
            }else{
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:dic[@"url"]]];
            }
        }];
        [alertVC addAction:action];
    }
    
    [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}


+ (NSArray *)getInstalledMapAppWithEndNode:(CLLocationCoordinate2D)endNode
{
    NSMutableArray *maps = [NSMutableArray array];
    
    //苹果地图
    NSMutableDictionary *iosMapDic = [NSMutableDictionary dictionary];
    iosMapDic[@"title"] = @"苹果地图";
    [maps addObject:iosMapDic];
    
    //百度地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        NSMutableDictionary *baiduMapDic = [NSMutableDictionary dictionary];
        baiduMapDic[@"title"] = @"百度地图";
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=%@&mode=driving&coord_type=gcj02",endNode.latitude,endNode.longitude,@"目的地"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        baiduMapDic[@"url"] = urlString;
        [maps addObject:baiduMapDic];
    }
    
    //高德地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSMutableDictionary *gaodeMapDic = [NSMutableDictionary dictionary];
        gaodeMapDic[@"title"] = @"高德地图";
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"],@"commons12346001",endNode.latitude,endNode.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        gaodeMapDic[@"url"] = urlString;
        [maps addObject:gaodeMapDic];
    }
    
    //谷歌地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSMutableDictionary *googleMapDic = [NSMutableDictionary dictionary];
        googleMapDic[@"title"] = @"谷歌地图";
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",@"导航测试",@"nav123456",endNode.latitude, endNode.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        googleMapDic[@"url"] = urlString;
        [maps addObject:googleMapDic];
    }
    
    //腾讯地图
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"qqmap://"]]) {
        NSMutableDictionary *qqMapDic = [NSMutableDictionary dictionary];
        qqMapDic[@"title"] = @"腾讯地图";
        NSString *urlString = [[NSString stringWithFormat:@"qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=终点&coord_type=1&policy=0",endNode.latitude, endNode.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        qqMapDic[@"url"] = urlString;
        [maps addObject:qqMapDic];
    }
    
    return maps;
}



#pragma mark - 坐标转换
- (BMKMapPoint)convertBmkPoint:(CLLocationCoordinate2D)coor{
    
    return BMKMapPointForCoordinate(coor);
}

- (MAMapPoint)convertMaMapPoint:(CLLocationCoordinate2D)coor{
    
    return MAMapPointForCoordinate(coor);
}

#pragma mark - 反地理编码
- (void)reverseGeocodeWithCoordinate:(CLLocationCoordinate2D)coordinate callBack:(reverseGeoMapBlock)callBack
{
    
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [self.geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error) {
            NSLog(@"%@",error.description);
//            if (callBack) {
//                callBack(@"未知地址");
//            }
        } else {
            CLPlacemark *pm = [placemarks firstObject];
            if (callBack) {
                //                success(pm.name);
                callBack([NSString stringWithFormat:@"%@%@%@",pm.administrativeArea?pm.administrativeArea:@"",pm.subLocality?pm.subLocality:@"", pm.name?pm.name:@""]);
            }
        }
    }];
    
    
    
    
    
    
    

    
    
    
}

/**
 获取图片

 @param name <#name description#>
 @return <#return value description#>
 */
+(UIImage *)imageName:(NSString *)name{

    NSString *path = [[NSBundle mainBundle]pathForResource:@"Commons" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    //        NSLog(@"path:%@,bundle:%@",path,bundle);
    UIImage *im = [UIImage imageNamed:name inBundle:bundle compatibleWithTraitCollection:nil];
    if (!im) {
        im = [UIImage imageNamed:name];
    }
    //        NSLog(@"path:%@,bundle:%@,image:%@",path,bundle,im);
    return  im;

}




@end
