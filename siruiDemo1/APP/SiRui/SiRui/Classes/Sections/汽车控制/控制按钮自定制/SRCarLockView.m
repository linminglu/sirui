//
//  SRCarWindowsView.m
//  SiRui
//
//  Created by czl on 2017/4/19.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRCarLockView.h"
#import "SRCarLocksImageView.h"
#import <Connector/FZKBVehicleStatusInfoModel.h>

@interface SRCarLockView ()

@property (nonatomic,strong) SRCarLocksImageView *openIm;

@property (nonatomic,strong) SRCarLocksImageView *closeIm;


/**
 虚线
 */
@property (nonatomic,strong) UIImageView *lineIm;

@end

@implementation SRCarLockView
{

    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib{

    [super awakeFromNib];
    [self addSubview:self.openIm];
    [self addSubview:self.closeIm];
    [self addSubview:self.lineIm];
    
//    添加通知处理界面刷新逻辑
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCarWindows) name:kCarStateChangelNotification object:nil];
    
}


#pragma mark - getter
- (SRCarLocksImageView *)openIm
{
    if (!_openIm) {
        //        CGRect rect = FZKFlexibleFrame(self.frame);
        _openIm  =[[SRCarLocksImageView alloc]initWithFrame:CGRectMake(10,180, 60, 60)
                                                        onIm:[UIImage imageNamed:@"kaisuozhuantai"] offIm:[UIImage imageNamed:@"kaisuo"]];
        
        
        _openIm.isCanTouch = ([FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel].doorLock==2);
    }
    return _openIm;

}

-(SRCarLocksImageView *)closeIm
{

    if (!_closeIm) {
        //        CGRect rect = FZKFlexibleFrame(self.frame);
        _closeIm  =[[SRCarLocksImageView alloc]initWithFrame:CGRectMake(10, 0, 60, 60) onIm:[UIImage imageNamed:@"shangsuo"] offIm:[UIImage imageNamed:@"shangsuozhuantai"]];
        //        NSLog(@"%@",NSStringFromCGRect(_openIm.frame));
        
        
        _closeIm.isCanTouch = ([FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel].doorLock==1);
        //        _openIm.backgroundColor = [UIColor greenColor];
    }
    return _closeIm;
}

- (UIImageView *)lineIm{

    if (!_lineIm) {
        _lineIm = [[UIImageView alloc]initWithFrame:CGRectMake(38, CGRectGetMaxY(self.closeIm.frame)+2, 4, (CGRectGetMinY(self.openIm.frame)-CGRectGetMaxY(self.closeIm.frame)-4))];
        //设置标记
        _lineIm.tag=101;
        _lineIm.image = [UIImage imageNamed:@"xuxian"];
    }
    return _lineIm;
}

#pragma mark - 界面刷新处理
- (void)refreshCarWindows
{   
    _openIm.isCanTouch = ([FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel].doorLock==2);
    _closeIm.isCanTouch = ([FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel].doorLock==1);
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
