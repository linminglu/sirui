//
//  FZKEMapTestViewController.m
//  Example
//
//  Created by czl on 2017/3/31.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKEMapTestViewController.h"
#import <Commons/FZKCMapManager.h>

#import <Commons/JSONKit.h>

#import <SVProgressHUD.h>
#import <Commons/FZKCSportPointAnnotation.h>

@interface FZKEMapTestViewController ()<BMKPoiSearchDelegate,BMKMapViewDelegate,BMKLocationServiceDelegate>
{
    SportAnnotationView *sportAnnotationView;
}
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;


/**
 搜索服务
 */
@property (nonatomic,strong)BMKPoiSearch *poisearch;


/**
 定位服务
 */
@property (nonatomic,strong)BMKLocationService *locService;

@property (weak, nonatomic) IBOutlet UITextField *searchText;

//@property (nonatomic,strong) FZKCMapManager *manger;

@end

@implementation FZKEMapTestViewController
{
    BOOL showTrance;//是否显示轨迹
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
        _mapView.showsUserLocation = YES;//显示定位图层
    [self.locService startUserLocationService];
    _mapView.userTrackingMode = BMKUserTrackingModeHeading;//设置定位的状态
//    CLLocationCoordinate2D coordinate = [FZKCMapManager getCurrentCoordinate2D];
//    self.manger = [FZKCMapManager new];
//    [FZKCMapManager shareMapManager].locationServiceRun =NO;
    [FZKCMapManager shareMapManager].getCurrentCoordinate = ^ (CLLocationCoordinate2D coor){
    
    };
    
    NSLog(@"FZKEMapTestViewController%@,\n当前VC:%@",self,[self topViewController]);
  
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    _mapView.delegate = self;
    self.poisearch.delegate = self;
    self.locService.delegate = self;
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    _mapView.delegate = nil;
    self.poisearch.delegate = nil;
    self.locService.delegate = nil;
}


- (IBAction)search:(id)sender {
    if(_searchText.text.length==0){
        [SVProgressHUD showErrorWithStatus:@"请输入搜索内容"];
        return;
    }
    [FZKCMapManager nearSearhKey:_searchText.text radius:1000 coordinate:_mapView.centerCoordinate poiSearch:self.poisearch];
}


- (IBAction)start:(id)sender {
    if (!showTrance) {
        [SVProgressHUD showErrorWithStatus:@"需要显示轨迹才能点击"];
        return;
    }
 
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [FZKCMapManager startBaiduTrace];
//        });
    
}
- (IBAction)show:(UIButton *)sender {
    
    [FZKCMapManager addBaiduTraceWithlocations:[self testTranceBaidu] toMapView:self.mapView];
    showTrance = YES;
    [self.locService stopUserLocationService];
    self.mapView.showsUserLocation = NO;
    [sender removeFromSuperview];
}

- (IBAction)stop:(id)sender {
    if (!showTrance) {
        [SVProgressHUD showErrorWithStatus:@"需要显示轨迹才能点击"];
        return;
    }
    [FZKCMapManager stopBaiduTrace];
}


#pragma mark - BMKMapViewDelegate
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
    
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
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
//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    if ([overlay isKindOfClass:[BMKPolygon class]])
    {
        BMKPolygonView* polygonView = [[BMKPolygonView alloc] initWithOverlay:overlay];
        polygonView.strokeColor = [[UIColor alloc] initWithRed:0.0 green:0.5 blue:0.0 alpha:0.6];
        polygonView.lineWidth = 3.0;
        return polygonView;
    }
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView *lineView = [[BMKPolylineView alloc]initWithPolyline:overlay];
        lineView.strokeColor = [[UIColor alloc] initWithRed:0.0 green:0.5 blue:1.0 alpha:0.6];
        lineView.lineWidth = 3.0;
        return lineView;
    }
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view{
    
    [FZKCMapManager openThirdMapNode:view.annotation.coordinate];
}
#pragma mark - POI搜索代理
/**
 *返回POI搜索结果
 *@param searcher 搜索对象
 *@param poiResult 搜索结果列表
 *@param errorCode 错误号，@see BMKSearchErrorCode
 */
- (void)onGetPoiResult:(BMKPoiSearch*)searcher result:(BMKPoiResult*)poiResult errorCode:(BMKSearchErrorCode)errorCode
{
    //    BMK_SEARCH_PERMISSION_UNFINISHED
    //    BMK_SEARCH_PERMISSION_UNFINISHED
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < poiResult.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [poiResult.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }
        [_mapView addAnnotations:annotations];
        [_mapView showAnnotations:annotations animated:YES];
    } else if (errorCode == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}


#pragma mark - 地图定位相关处理
//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
    [_mapView updateLocationData:userLocation];
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
//    [FZKCMapManager didUpdateBMKUserLocation:userLocation mapView:_mapView locService:self.locService];
    [_mapView updateLocationData:userLocation];
    _mapView.centerCoordinate = userLocation.location.coordinate;
    
    
}




#pragma mark - getter
- (BMKPoiSearch *)poisearch
{
    
    if (!_poisearch) {
        
        _poisearch = [BMKPoiSearch new];
    }
    return _poisearch;
}
- (BMKLocationService *)locService
{
    if (!_locService) {
        
        _locService = [BMKLocationService new];
    }
    return _locService;
    
}
//
-(NSMutableArray *)testTranceBaidu{
    
    static dispatch_once_t onceToken;
    static NSMutableArray *install =nil;
    dispatch_once(&onceToken, ^{
        install = [NSMutableArray new];
        //读取数据
        NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"sport_path" ofType:@"json"]];
        if (jsonData) {
            NSArray *array = [jsonData objectFromJSONData];
            for (NSDictionary *dic in array) {
                FZKSportNode *sportNode = [[FZKSportNode alloc] init];
                sportNode.coordinate = CLLocationCoordinate2DMake([dic[@"lat"] doubleValue], [dic[@"lon"] doubleValue]);
                sportNode.angle = [dic[@"angle"] doubleValue];
                sportNode.distance = [dic[@"distance"] doubleValue];
                sportNode.speed = [dic[@"speed"] doubleValue];
                [install addObject:sportNode];
            }
        }
    });
    return install;
}



#pragma mark - 获取当前活动的viewcontroller
- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        
        return rootViewController;
    }
}


- (IBAction)set:(id)sender {
    [FZKCMapManager setCurrentIndex:3];
}


@end
