//
//  FZKEBaiduMapViewController.m
//  Example
//
//  Created by czl on 2017/5/2.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKEBaiduMapViewController.h"
#import <Commons/FZKCBaiduMapView.h>
#import <Commons/FZKPointAnnotation.h>

@interface FZKEBaiduMapViewController ()<FZKMapDelegate>
@property (weak, nonatomic) IBOutlet FZKCBaiduMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;

@end

@implementation FZKEBaiduMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView.mapDelegate = self;
    // Do any additional setup after loading the view.
}

- (void)fzk_mapView:(FZKEBaseMapView *)mapView didSelectAnnotationPoint:(CLLocationCoordinate2D)coordinate2D{

    [_mapView setMapCenterCoordinate:coordinate2D];
    
    [FZKCMapManager openThirdMapNode:coordinate2D];
}


/**
 * @brief 地图区域改变完成后会调用此接口
 * @param mapView 地图View
 * @param animated 是否动画
 */
- (void)fzk_mapView:(FZKEBaseMapView *)mapView regionDidChangeAnimated:(BOOL)animated{

    
}

/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (UIView *)fzk_mapView:(FZKEBaseMapView *)mapView viewForAnnotation:(id <FZKAnnotation>)annotation{
    

    return nil;
    
}






/**
 点击地图空白处
 
 @param mapView 地图

 */

- (void)fzk_mapView:(FZKEBaseMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate2D{

    [self.view endEditing:YES];
    
}



#pragma mark - 搜索
- (IBAction)searchText:(id)sender {
    [_mapView searchText:_searchTextField.text];
}

#pragma mark - 定位
- (IBAction)location:(id)sender {
    [_mapView updateLocationBlock:^(CLLocationCoordinate2D coordinate) {
        [_mapView setMapCenterCoordinate:coordinate];
        
        [_mapView reverseGeoMap:coordinate callBack:^(NSString *address) {
            NSLog(@"address:%@",address);
        }];
        
    }];
}

#pragma mark - 添加覆盖层
- (IBAction)ovly:(id)sender {
    
    CLLocationCoordinate2D commonPolylineCoords[4];
    commonPolylineCoords[0].latitude = 39.832136;
    commonPolylineCoords[0].longitude = 116.34095;
    
    commonPolylineCoords[1].latitude = 39.832136;
    commonPolylineCoords[1].longitude = 116.42095;
    
    commonPolylineCoords[2].latitude = 39.902136;
    commonPolylineCoords[2].longitude = 116.42095;
    
    commonPolylineCoords[3].latitude = 39.902136;
    commonPolylineCoords[3].longitude = 116.44095;
    
    //构造折线对象
    //    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:4];
    NSMutableArray *tranceArray = [NSMutableArray new];
    for (int i=0; i<4; i++) {
        FZKSportNode *node = [FZKSportNode new];
        node.coordinate = commonPolylineCoords[i];
        
        [tranceArray addObject:node];
    }
    [_mapView addOverly:tranceArray];
}

@end
