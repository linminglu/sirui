//
//  SRCarStateViewController.m
//  SiRui
//
//  Created by czl on 2017/5/4.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRCarStateViewController.h"
#import <Connector/FZKBVehicleStatusInfoModel.h>

@interface SRCarStateViewController ()


/**
 电压显示
 */
@property (weak, nonatomic) IBOutlet UILabel *voltageLabel;


/**
 速度显示
 */
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;


/**
 GPS显示控件
 */
@property (weak, nonatomic) IBOutlet UILabel *GPSLabel;


/**
 信号显示控件
 */
@property (weak, nonatomic) IBOutlet UILabel *signalLabel;


/**
 信号类型显示控件
 */
//@property (weak, nonatomic) IBOutlet UILabel *signalTypeLabel;


/**
 温度显示控件
 */
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;

@end

@implementation SRCarStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加刷新界面通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refreshView) name:kCarCoorDinateChangelNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 刷新界面
- (void)refreshView{

    FZKBVehicleStatusInfoModel *model = [FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel];
    

    //设置电压
    _voltageLabel.text = [NSString stringWithFormat:@"%.1f",model.electricity];
    [self setCarStarteColorWithLabel:_voltageLabel low:model.electricityStatus==2];

    //设置速度
    _speedLabel.text = [NSString stringWithFormat:@"%.1f",model.speed];
    
    
    //设置GPS
    [self setCarStarteColorWithLabel:_GPSLabel low:model.startNumber>4];
    [self setCarValue:_GPSLabel low:model.startNumber>4];
    
    //设置信号
    
    [self setCarStarteColorWithLabel:_signalLabel low:model.signalStrength>20];
    [self setCarValue:_signalLabel low:model.signalStrength>20];
    

    
    //设置温度
//    [self setCarStarteWithLabel:_temperatureLabel value:model.temp standard:10];
    _temperatureLabel.text = [NSString stringWithFormat:@"%.1f",model.temp];
    if (model.temp<=10) {
        _temperatureLabel.backgroundColor = [UIColor colorWithHexString:@"1787c8"];
    }else{
        [self setCarStarteColorWithLabel:_temperatureLabel low:model.temp>28];
    }
    
    
}


/**
 设置控件颜色

 @param label 控件
 @param low 强弱
 */
- (void)setCarStarteColorWithLabel:(UILabel *)label low:(BOOL)low{
    if(low){
        label.backgroundColor = [UIColor colorWithHexString:@"#ea5514"];
    }else{
        label.backgroundColor = [UIColor colorWithHexString:@"00913a"];
    }
}

- (void)setCarValue:(UILabel *)label low:(BOOL)low{
   
    if (low) {
        label.text = @"弱";
    }else{
    
        label.text = @"强";
    }
    
}

-(void)dealloc{

    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
