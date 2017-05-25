//
//  FZKCMapNaviTool.m
//  Commons
//
//  Created by 宋搏 on 2017/4/25.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCMapNaviTool.h"

#import <objc/runtime.h>
@import CoreLocation;


@interface FZKCMapNaviTool ()
// view
@property (nonatomic, strong) UIControl *overlayView;
@property (nonatomic, strong) UIView *hudView;
@property (nonatomic,strong) UIView *itemView;

//导航参数
@property (nonatomic, strong) NSString *urlScheme;
@property (nonatomic, strong) NSString *appName;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSString * toLocationName;

@end

@implementation FZKCMapNaviTool

static CGFloat maskTopEdge = 0;
static CGFloat maskBottomEdge = 0;

static CGRect WSProgressHUDNewBounds;

static UIColor *WSProgressHUDForeGroundColor;
static UIColor *WSProgressHUDBackGroundColor;

static UIImage *WSProgressHUDSuccessImage;
static UIImage *WSProgressHUDErrorImage;

static CGFloat WSProgressHUDShowDuration = 0.3;
static CGFloat WSProgressHUDDismissDuration = 0.0;

static CGFloat const itemBtnHeight = 40;
static CGFloat const itemMargin = 7;
static CGFloat const cannelBtnHeight = 40;



+ (FZKCMapNaviTool *)shareInstance {
    static dispatch_once_t once;
    static FZKCMapNaviTool *shareView;
    dispatch_once(&once, ^{
        shareView = [[self alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        
    });
    return shareView;
}

+ (void)showNaviView
{
    [[self shareInstance] addOverlayViewToWindow];
    [[self shareInstance] ll_show];
}

- (UIControl *)overlayView {
    if(!_overlayView) {
        CGRect windowBounds = [UIApplication sharedApplication].keyWindow.bounds;
        _overlayView = [[UIControl alloc] initWithFrame:windowBounds];
        _overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayView.backgroundColor = [UIColor clearColor];
    }
    return _overlayView;
}



- (void)addOverlayViewToWindow
{
    if(!self.overlayView.superview){
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows){
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
                [window addSubview:self.overlayView];
                break;
            }
        }
    } else {
        [self.overlayView.superview bringSubviewToFront:self.overlayView];
    }
    
    if (!self.superview) {
        [self.overlayView addSubview:self];
    }
    
    
    
    objc_setAssociatedObject(self, @selector(showOnTheWindow), @(1), OBJC_ASSOCIATION_ASSIGN);
}

- (void)ll_show
{
    NSAssert([NSThread isMainThread], @"WSProgressHUD show Must on main thread");
    
    
    //1. 当前view上的
    maskBottomEdge = 0;
    maskTopEdge = 0;
    self.overlayView.frame = CGRectMake(0, maskTopEdge, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - maskTopEdge - maskBottomEdge);
    if (self.showOnTheWindow) {
        CGRect rect = self.bounds;
        rect.size = self.overlayView.frame.size;
        self.bounds = rect;
    }
    
    
    //2. 底部选择块
    NSArray *itemTitleArray = [NSArray arrayWithArray:[self getShowItemTitleArray]];
    CGSize hudSize = CGSizeMake(self.bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    
    //选项模块的frame
    CGFloat actionViewHeight = itemTitleArray.count*itemBtnHeight + cannelBtnHeight + itemMargin;
    CGFloat topCoverBtnHeight = hudSize.height-actionViewHeight;
    
    
    
    
    //上部分
    UIButton *topCoverBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0,hudSize.width, topCoverBtnHeight)];
    [topCoverBtn setBackgroundColor:[UIColor clearColor]];
    [topCoverBtn addTarget:self action:@selector(topCoverBtnOnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.hudView addSubview:topCoverBtn];
    
    
    
    //3. 下部分
    //----------- 添加选项
    self.itemView.frame = CGRectMake(0, CGRectGetMaxY(topCoverBtn.frame),hudSize.width, actionViewHeight);
    
    CGFloat itemViewX = 0;
    for (NSInteger i = 0; i < itemTitleArray.count; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(itemViewX,(itemBtnHeight+0.5)*i,hudSize.width, itemBtnHeight)];
        [button  setTitle:itemTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonItemOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemView addSubview:button];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame),hudSize.width,0.5)];
        [lineView setBackgroundColor:[UIColor colorWithRed:213/255.0 green:216/255.0 blue:213/255.0 alpha:1.0]];
        [self.itemView addSubview:lineView];
        
    }
    
    
    UIView *marignView = [[UIView alloc] initWithFrame:CGRectMake(0, actionViewHeight-cannelBtnHeight-itemMargin,hudSize.width,itemMargin)];
    [marignView setBackgroundColor:[UIColor colorWithRed:228/255.0 green:232/255.0 blue:227/255.0 alpha:1.0]];
    [self.itemView addSubview:marignView];
    
    UIButton *cannelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(marignView.frame),hudSize.width, cannelBtnHeight)];
    [cannelBtn setBackgroundColor:[UIColor whiteColor]];
    [cannelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cannelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cannelBtn addTarget:self action:@selector(buttonItemOnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.itemView addSubview:cannelBtn];
    
    self.hudView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.hudView addSubview:self.itemView];
    
    //-----------
    
    
    //4.显示当前控件
    if (self.hudView.alpha == 0) {
        
        self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1.2, 1.2);
        
        [UIView animateWithDuration:WSProgressHUDShowDuration
                              delay:0
                            options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut | UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             
                             
                             self.hudView.transform = CGAffineTransformScale(self.hudView.transform, 1/1.2, 1/1.2);
                             self.hudView.alpha = 1;
                             
                         }
                         completion:nil];
    }
    
    
    [self setNeedsDisplay];
    
}



- (BOOL)showOnTheWindow
{
    NSLog(@"%s",__FUNCTION__);
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}



+ (void)dismiss {
    [[self shareInstance] dismiss];
}




- (void)dismiss
{
    WSProgressHUDNewBounds = CGRectZero;
    
    self.hudView.transform = CGAffineTransformIdentity;
    [UIView animateWithDuration:WSProgressHUDDismissDuration
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut
                     animations:^{
                         
                         self.hudView.transform = CGAffineTransformScale(self.hudView.transform, .8, .8);
                         self.hudView.alpha = 0;
                         
                         
                         
                     }
                     completion:^(BOOL finished){
                         
                         
                         self.hudView.transform = CGAffineTransformIdentity;
                         
                         [self.overlayView removeFromSuperview];
                         
                         [self.itemView removeFromSuperview];
                         self.itemView  = nil;
                         
                         //Call drawInRact
                         [self setNeedsDisplay];
                     }];
}




- (UIView *)hudView
{
    if (!_hudView) {
        _hudView = [[UIView alloc] init];
        _hudView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
        _hudView.alpha = 0;
        _hudView.contentScaleFactor = [UIScreen mainScreen].scale;
    }
    return _hudView;
}


- (UIView *)itemView
{
    if (!_itemView) {
        _itemView = [[UIView alloc] init];
        [_itemView setBackgroundColor:[UIColor whiteColor]];
        [self.hudView addSubview:_itemView];
    }
    return _itemView;
}




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.hudView];
        
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin        | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
        
    }
    return self;
}


#pragma mark - Draw rect
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithWhite:0 alpha:0.1] set];
    //    [[UIColor clearColor] set];
    
    CGRect bounds = self.bounds;
    CGContextFillRect(context, bounds);
}





#pragma mark ================ 和导航相关的方法 ================
//设置导航目的地经纬度
+ (void)setDestinationCoordinate:(CLLocationCoordinate2D)coordinate ToLocationName:(NSString *)name{
    [self shareInstance].urlScheme = @"ZYHTBusinessAreaURI://";
    [self shareInstance].appName = @"ZYHTBusinessAreaURI";
    [self shareInstance].coordinate = coordinate;
    [self shareInstance].toLocationName = name;
}

//获取可用的导航选项
- (NSArray *)getShowItemTitleArray {
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:4];
    
    //这个判断其实是不需要的
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://maps.apple.com/"]])
    {
        [tempArray addObject:@"苹果地图"];
    }
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]])
    {
        [tempArray addObject:@"百度地图"];
        
    }
    
    
    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]])
    {
        [tempArray addObject:@"高德地图"];
    }
    
    //    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]])
    //    {
    //        [tempArray addObject:@"谷歌地图"];
    //
    //    }
    //    if ( [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"http://apis.map.qq.com/"]])
    //    {
    //        [tempArray addObject:@"腾讯地图"];
    //
    //    }
    
    //    return @[@"腾讯地图",@"百度地图",@"苹果地图",@"高德地图",@"谷歌地图"];
    
    
    return tempArray;
    
}



- (void)topCoverBtnOnClick {
    [self dismiss];
}

//导航
- (void)buttonItemOnClick: (UIButton *)btn {
    NSLog(@"%s",__FUNCTION__);
    
    
    NSString *urlScheme = self.urlScheme;
    NSString *appName = self.appName;
    CLLocationCoordinate2D coordinate = self.coordinate;
    
    
    if ([[btn currentTitle] isEqualToString:@"腾讯地图"]) {
        /*
         http://apis.map.qq.com/uri/v1/routeplan?type=bus&from=我的家&fromcoord=39.980683,116.302&to=中关村&tocoord=39.9836,116.3164&policy=1&referer=myapp
         */
        //        NSString *urlString = [[NSString stringWithFormat:@"apis.map.qq.com/uri/v1/routeplan?type=bus&to=中关村&tocoord=%f,%f&policy=1&referer=myapp",coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        //        NSLog(@"%@",urlString);
        //        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        
    }
    else if ([[btn currentTitle] isEqualToString:@"百度地图"]){
        
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",urlString);
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        
    }
    else if ([[btn currentTitle] isEqualToString:@"苹果地图"]){
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil]];
        toLocation.name = [FZKCMapNaviTool shareInstance].toLocationName;
        [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                       launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
    }
    else if ([[btn currentTitle] isEqualToString:@"高德地图"]){
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",urlString);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    else if ([[btn currentTitle] isEqualToString:@"谷歌地图"]){
        NSString *urlString = [[NSString stringWithFormat:@"comgooglemaps://?x-source=%@&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving",appName,urlScheme,coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSLog(@"%@",urlString);
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    }
    
    //退下提示框
    [self dismiss];
}


@end
