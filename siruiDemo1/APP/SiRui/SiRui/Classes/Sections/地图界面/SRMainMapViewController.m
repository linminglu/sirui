//
//  SRMainMapViewController.m
//  SiRui
//
//  Created by 宋搏 on 2017/4/28.
//  Copyright © 2017年 chinapke. All rights reserved.
//


#import "SRMainMapViewController.h"
#import <Commons/FZKCBaiduMapView.h>
#import <Commons/FZKCMapManager.h>
#import <Commons/FZKCShareManager.h>
#import <Commons/FZKPointAnnotation.h>
#import <Connector/FZKBVehicleBasicInfoModel.h>
#import <Connector/FZKBVehicleStatusInfoModel.h>
#import <Connector/FZKBVehicleStatusModel.h>
#import <Connector/FZKCUserDefaults.h>
#import <Connector/FZKLocationManager.h>
#import <Connector/FZKTCPClient.h>
#import <Connector/FZKTCPRequest.h>
#import <Connector/NSDate+Utilities.h>



@interface SRMainMapViewController ()<BMKMapViewDelegate,BMKLocationServiceDelegate,FZKMapDelegate>

@property (nonatomic , assign) CGFloat    carLat;
@property (nonatomic , assign) CGFloat    carLng;
@property (weak, nonatomic) IBOutlet UILabel *licensePlateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet FZKCBaiduMapView *mapView;
@property (nonatomic,strong)BMKLocationService *locService;

@end

@implementation SRMainMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"定位";
    _mapView.mapDelegate = self;
    [_mapView startLocation];
    
    
    
    
}



-(void)refreshCarLatAndLng{
    
    //车的经纬度
    _carLat =   [FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel].lat;
    _carLng =   [FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel].lng;
    _licensePlateLabel.text = [FZKBVehicleBasicInfoModel shareVehicleBasicInfoModel].plateNumber;
    _timeLabel.text =     [NSDate timeConversion:  [FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel].gpsTime DateFormat:@"MM-dd HH:mm"];
    
    
    
    
    
    
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = _carLat;
    coordinate.longitude = _carLng;
    
    [_mapView setMapCenterCoordinate:coordinate];
    
    //反地理编码
    
    
    [_mapView reverseGeoMap:coordinate callBack:^(NSString *address) {
        _addressLabel.text = [NSString stringWithFormat:@"%@",address];
    }];
    
    
    
    
    FZKPointAnnotation *annotation = [FZKPointAnnotation new];
    annotation.coordinate = coordinate;
    annotation.title = @"车";
    [_mapView removeAllAnimations];
    [_mapView addAnimation:annotation];
    
    
    
    
    
}

- (UIView *)fzk_mapView:(FZKEBaseMapView *)mapView viewForAnnotation:(id <FZKAnnotation>)annotation{
    
    
    //普通annotation
    if ([annotation isKindOfClass:[FZKPointAnnotation class]]) {
        NSString *AnnotationViewID = @"renameMark";
        
        if ([annotation.title isEqualToString:@"车"]) {
            BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
            if (annotationView == nil) {
                annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
                
                
                UIImage *image = [UIImage imageNamed:@"qichedingwei"];
                annotationView.canShowCallout = NO;
                annotationView.centerOffset = CGPointMake(0, -image.size.height/2);
                annotationView.image = image;
                
            }
            return annotationView;
        }
        
    }
    
    
    return nil;
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self refreshCarLatAndLng];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCarLatAndLng) name:kCarCoorDinateChangelNotification object:nil];
    
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (IBAction)share:(id)sender {
    
    
    
    NSString *titleString   = @"思锐";
    NSString *urlString     = @"http://www.mysirui.com/app.html";
    NSString *contentString = [NSString stringWithFormat:@"我的位置：%@", _addressLabel.text?_addressLabel.text:@"无法获取位置信息"];
    
    
    [FZKCShareManager shareSetupShareParamsByText:contentString images:nil url:urlString title: @"思锐"];
    
}
- (IBAction)mapNav:(id)sender {
    
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = _carLat;
    coordinate.longitude = _carLng;
    
    [FZKCMapManager openThirdMapNode:coordinate];
}

- (IBAction)trajectory:(UIButton *)sender {
}



@end
