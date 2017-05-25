//
//  SRIMEIScanViewController.m
//  SiRui
//
//  Created by czl on 2017/4/17.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRIMEIScanViewController.h"
#import <LBXAlertAction.h>
#import <Business/FZKBVerifyIMEIAction.h>
#import <Connector/FZKBCarEntityModel.h>

@interface SRIMEIScanViewController ()

/**
 @brief  扫码区域上方提示文字
 */
@property (nonatomic, strong) UILabel *topTitle;

@end

@implementation SRIMEIScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setStyles];
    // Do any additional setup after loading the view.
}

#pragma mark - 设置扫描样式
- (void)setStyles{
    LBXScanViewStyle *style = [LBXScanViewStyle new];
    style.colorAngle = [UIColor greenColor];
    style.photoframeAngleW = 20;
    style.photoframeAngleH = 20;
    style.photoframeLineW = 3;
//    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;
    
    style.isNeedShowRetangle = NO;
    //    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/coordinate2D"];
    style.animationImage = [UIImage imageNamed:@"scanLine"];
    
    self.style = style;
    
    self.isOpenInterestRect = YES;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.title = @"扫一扫";
    
    [self drawTitle];
    [self.view bringSubviewToFront:_topTitle];
    
}

//绘制扫描区域
- (void)drawTitle
{
    if (!_topTitle){
        
        self.topTitle = [[UILabel alloc]init];
        _topTitle.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 60);
        _topTitle.center = CGPointMake(SCREEN_WIDTH/2, SCREENH_HEIGHT-120);
        
        //3.5inch iphone
        if ([UIScreen mainScreen].bounds.size.height <= 568 )
        {
            //            _topTitle.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, 38);
            _topTitle.font = [UIFont systemFontOfSize:14];
        }
        
        
        _topTitle.textAlignment = NSTextAlignmentCenter;
        _topTitle.numberOfLines = 0;
        _topTitle.text = @"将二维码图案放入取景框内，即可自动扫描";
        _topTitle.textColor = [UIColor whiteColor];
        [self.view addSubview:_topTitle];
    }
}

#pragma mark - 扫描错误处理
- (void)showError:(NSString*)str
{
    [LBXAlertAction showAlertWithTitle:@"提示" msg:str chooseBlock:nil buttonsStatement:@"扫描出错",nil];
}




#pragma mark -实现类继承该方法，作出对应处理
- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
    for (LBXScanResult *result in array) {
        
        NSLog(@"scanResult:%@",result.strScanned);
    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString *strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    [self showNextVCWithScanResult:scanResult];
}



- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
    
    __weak __typeof(self) weakSelf = self;
    [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult chooseBlock:^(NSInteger buttonIdx) {
        
        //点击完，继续扫码
        [weakSelf reStartDevice];
    } buttonsStatement:@"知道了",nil];
}


#pragma mark - 验证IMEI
- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
    
    
    [FZKBVerifyIMEIAction verifyIMEIActionWithImei:strResult.strScanned success:^(id parameter) {
        FZKBCarEntityModel *carModel;
        if (parameter) {
            carModel = [FZKBCarEntityModel mj_objectWithKeyValues:parameter];
           
        }else{
            carModel = [FZKBCarEntityModel new];
        
        }
         carModel.imei = strResult.strScanned;
        
        self.scanVieBlock(carModel);
        [self.navigationController popViewControllerAnimated:YES];
        
    } fail:^(id parameter) {
        [self reStartDevice];
    }];
    
}
@end
