//
//  SRCarControlButton.m
//  SiRui
//
//  Created by czl on 2017/4/14.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRCarStartControlButton.h"
#import <UAProgressView.h>

//#import "SREnum.h"
#import <Connector/FZKBLoginModel.h>
#import <Connector/FZKBKeychain.h>
#import <Business/FZKBPhoneControllAction.h>
#import <Connector/FZKBVehicleStatusInfoModel.h>
#import <Business/UUID.h>
#import <Connector/FZKBVehicleStatusInfoModel.h>
#import "SRCarStatueData.h"

@interface SRCarStartControlButton ()

@property (nonatomic,strong) NSTimer *tiemr;


/**
 获取进度
 */
@property (nonatomic,assign) CGFloat count;

@property (nonatomic,strong) UAProgressView *progressView;



@end

@implementation SRCarStartControlButton
{

    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(void)awakeFromNib
{
    
    [super awakeFromNib];

    //添加长按手势
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];

    [self addGestureRecognizer:press];
    
    //添加长按视图
    [self addSubview:self.progressView];
    [self sendSubviewToBack:self.progressView];
    
    //    添加通知处理界面刷新逻辑
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCarWindows) name:kCarStateChangelNotification object:nil];
}


//- (void)tip{
//
//    NSLog(@"pin");
//}

/**
 长按手势处理

 @param ges <#ges description#>
 */
- (void)longPress:(UIGestureRecognizer *)ges{
    
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:
            _count = 0;
            [self.tiemr fire];
            break;
        case UIGestureRecognizerStateEnded:
            
            if (_count<1.0) {
                _count=0;
            }
            
            self.progressView.progress = _count;
            [self.tiemr invalidate];
            self.tiemr =nil;
            break;
        case UIGestureRecognizerStateCancelled:
            
            if (_count<1.0) {
                _count=0;
            }
            
            self.progressView.progress = _count;
            [self.tiemr invalidate];
            self.tiemr =nil;
            break;
            
        default:
            
            break;
    }
}

- (NSTimer *)tiemr
{

    if (!_tiemr) {
//        _tiemr = [NSTimer timerWithTimeInterval:0.02 repeats:YES block:^(NSTimer * _Nonnull timer) {
//            _count += 0.02;
//            if (self.count>=1.0) {
//                self.count=0.0;
//                
//                [self startStateAction:[FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel].engineStatus];
//                [timer invalidate];
//                timer = nil;
//            }
//            self.progressView.progress = _count;
//        }];
        _tiemr = [NSTimer timerWithTimeInterval:0.02 target:self selector:@selector(setCount) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:_tiemr forMode:NSRunLoopCommonModes];

    }
    return _tiemr;
}

-(void)setCount{
    _count += 0.02;
    if (self.count>=1.0) {
        self.count=0.0;
        
        [self startStateAction:[FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel].engineStatus];
        [self.tiemr invalidate];
        self.tiemr = nil;
    }
    self.progressView.progress = _count;
}

#pragma mark - getter
-(UAProgressView *)progressView
{

    if (!_progressView) {
        _progressView = [[UAProgressView alloc]initWithFrame:CGRectMake(-2, -2, CGRectGetWidth(self.frame)+4, CGRectGetHeight(self.frame)+4)];
        _progressView.borderWidth = 0.0;
        _progressView.progress = 0.0;
        _progressView.tintColor = [UIColor colorWithHexString:@"#509eba"];
        _progressView.userInteractionEnabled = NO;
    }
    return _progressView;
}


#pragma mark - 发动机启动状态改变处理

-(void)startStateAction:(NSInteger)startState{
    

    NSString *audioName;

    audioName = @"engine_open.wav";
    
    //播放发动机音效
    [SRPublicMethod playMusicWithName:audioName];
  
    
    [SRCarStatueData sendCarControlCode:TLVTag_Ability_EngineOn value:startState success:^(FZKActionResult *result) {
        
    } fail:^(FZKActionResult *result) {
        
    }];
    
}

#pragma mark - 界面刷新处理
- (void)refreshCarWindows
{
    FZKBVehicleStatusInfoModel *model = [FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel];
    
    NSString *str;
    if (model.engineStatus==1) {
        str = @"STOP";
    }else{
        str = @"START";
    }
    
    [self setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
}


-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
