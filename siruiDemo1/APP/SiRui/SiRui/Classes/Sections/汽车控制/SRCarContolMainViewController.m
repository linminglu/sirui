//
//  SRCarContolMainViewController.m
//  SiRui
//
//  Created by czl on 2017/4/14.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRCarContolMainViewController.h"
#import <Commons/FZKCAnimationManager.h>
#import <Business/FZKBGetCarInfoAction.h>
#import "UserConfig.h"
#import <Business/FZKBVehicleStatusAction.h>
#import <Connector/FZKBKeychain.h>
#import <Connector/FZKBVehicleBasicInfoModel.h>
#import <Connector/FZKBVehicleStatusInfoModel.h>
#import <Business/UUID.h>
#import "SRCarAblityButton.h"
#import "SRCarStatueData.h"
#import "SRLoginViewController.h"
#import "SRAddEquipmentViewController.h"
#import "SRCarStatueData.h"
#import "SRCarStateViewController.h"
#import <Connector/FZKTBluetoothManager.h>
#import <Connector/FZKTCarStateManager.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <Connector/FZKTDispatch_after.h>
/**
 汽车控制方式
 
 - SRCarControlTypeStart: 启动控制动画
 - SRCarControlTypeWindow: 车窗控制动画
 - SRCarControlTypeTrunk: 后备箱控制
 - SRCarControlTypeTirePressure: 胎压显示
 */
typedef NS_ENUM(NSUInteger, SRCarControlType) {
    SRCarControlTypeStart,
    SRCarControlTypeWindow,
    SRCarControlTypeTrunk,
    SRCarControlTypeTirePressure,
    SRCarControlTypeBack
};

@interface SRCarContolMainViewController ()

/**
 启动视图
 */
@property (weak, nonatomic) IBOutlet UIView *startView;

/**
 主移动视图
 */
@property (weak, nonatomic) IBOutlet UIView *mainView;


/**
 启动
 */
@property (weak, nonatomic) IBOutlet UIButton *startButton;


/**
 车锁
 */
@property (weak, nonatomic) IBOutlet UIButton *carLockButton;

/**
 后备箱
 */
@property (weak, nonatomic) IBOutlet UIButton *trunkButton;


/**
 胎压
 */
@property (weak, nonatomic) IBOutlet UIButton *tirePressureButton;


/**
 寻车按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *findButton;


/**
 车窗按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *carWindowButton;

/**
 保存所有按钮
 */
@property (nonatomic,strong)NSMutableArray<UIButton *> *btnArray;

//汽车图片
@property (weak, nonatomic) IBOutlet UIImageView *carImageView;



/**
 开锁视图
 */
@property (weak, nonatomic) IBOutlet UIView *windowView;


/**
 后备箱视图
 */
@property (weak, nonatomic) IBOutlet UIView *trunkView;


/**
 保存所有按钮控制视图
 */
@property (nonatomic,strong) NSMutableArray<UIView *> *viewsArray;




/**
 点击控制按钮延迟操作
 */
@property (nonatomic,strong) FZKTDispatch_after *dispatch_aft;



/**
 状态界面
 */
@property (nonatomic,strong) SRCarStateViewController *carStateView;

/**
 界面交换控件
 */
@property (weak, nonatomic) IBOutlet UIButton *changeButton;


/**
 判断是否状态界面，默认为no
 */
@property (nonatomic,assign) BOOL isStateView;


/**
 侧边栏按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *slideMenuButton;


/**
 蓝牙连接按钮
 */
@property (weak, nonatomic) IBOutlet UIButton *BLEButton;

@end


@implementation SRCarContolMainViewController
{
    
    //    判断已发生移动
    BOOL isMove;
    
    //    缩放比例
    CGFloat zoom;
    //    x位移
    CGFloat x;
    //    y位移
    NSInteger y;
    
    NSInteger currentCarId;//当前车辆
    
    CGRect mainViewFrame;
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //设置车控制指定通知监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(carAbilityStatueChange:) name:kCarControlNotification object:nil];
    
    
    [self.carImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carImageBack)]];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(bleStateChange:) name:kBleStateNotifacation object:nil];
    
    //添加状态图片
    [self  carStateView];
    
    
    //    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //隐藏navigationBar
    self.navigationController.navigationBar.hidden = YES;
    
    
    if ((currentCarId!=kCurrentCarModleId)||(currentCarId==0)) {
        
        currentCarId = kCurrentCarModleId;
        //隐藏所有按钮
        [self hideButtons];
        
        //查询车功能
        [self loginCarInfo];
    }
    

    
    [[FZKTCarStateManager shareCarStateManager] applicationDidBecomeActiveNotification:currentCarId];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
    //显示navigationBar
    self.navigationController.navigationBar.hidden = NO;
    
    
    [SVProgressHUD dismiss];
    
}

/**
 启动
 
 @param sender
 */
- (IBAction)start:(UIButton *)sender
{
    [self carControlWithType:SRCarControlTypeStart];
}




/**
 车窗
 
 @param sender
 */
- (IBAction)carWindow:(UIButton *)sender
{
    [self carControlWithType:SRCarControlTypeWindow];
}


/**
 后备箱
 
 @param sender
 */
- (IBAction)trunk:(UIButton *)sender
{
    [self carControlWithType:SRCarControlTypeTrunk];
}

#pragma mark - setter
-(void)setIsStateView:(BOOL)isStateView{
    UIImage *im;
    _isStateView = isStateView;
    
    if (_isStateView) {
        im = [UIImage imageNamed:@"zhuangtai"];
        _carStateView.view.hidden = NO;
        [self hideButtons];
    }else{
        im = [UIImage imageNamed:@"kongzhi"];
        [self showAllAbilityBtn];
        _carStateView.view.hidden = YES;
    }
    [self.changeButton setImage:im forState:UIControlStateNormal];
    //    [self.changeButton setBackgroundImage:im forState:UIControlStateNormal];
}

#pragma mark - getter
- (NSMutableArray<UIButton *> *)btnArray
{
    if (!_btnArray) {
        _btnArray = [NSMutableArray new];
        [_btnArray addObject:_startButton];
        [_btnArray addObject:_carLockButton];
        [_btnArray addObject:_trunkButton];
        [_btnArray addObject:_tirePressureButton];
        [_btnArray addObject:_findButton];
        [_btnArray addObject:_carWindowButton];
    }
    return _btnArray;
}

-(FZKTDispatch_after *)dispatch_aft{

    if (!_dispatch_aft) {
        _dispatch_aft = [FZKTDispatch_after new];
    }
    return _dispatch_aft;
}

- (NSMutableArray<UIView *> *)viewsArray{
    
    if (!_viewsArray) {
        _viewsArray = [NSMutableArray new];
        [_viewsArray addObject:_startView];
        [_viewsArray addObject:_windowView];
        [_viewsArray addObject:_trunkView];
    }
    return _viewsArray;
}

-(SRCarStateViewController *)carStateView{
    
    if (!_carStateView) {
        _carStateView = [SRCarStateViewController initVCWithStoryboardName:@"CarStoryboard"];
        
        [self.view addSubview:_carStateView.view];
        _carStateView.view.hidden = YES;
        //        [self.view bringSubviewToFront:_carStateView.view];
        [self.view bringSubviewToFront:_changeButton];
        [self.view bringSubviewToFront:_slideMenuButton];
        [self addChildViewController:_carStateView];
    }
    return _carStateView;
}

#pragma mark - 隐藏所有按钮
- (void)hideButtons{
    
    for (UIButton *btn in self.btnArray) {
        //        if (btn!=button) {
        //        [UIView animateWithDuration:0.5 animations:^{
        btn.alpha = 0.0;
        //        }];
        //        }
    }
}

#pragma mark - 显示已有功能按钮
- (void)showAllAbilityBtn{
    
    for (UIButton *btn in [SRCarStatueData abilityBtns:self.btnArray]) {
        //        [UIView animateWithDuration:0.5 animations:^{
        btn.alpha = 1.0;
        //        }];
    }
}



#pragma mark - 查询当前车辆功能
- (void)loginCarInfo{
    
    [FZKBGetCarInfoAction getCarInfoActionWithVehicleID:kCurrentCarModleId success:^(id parameter) {
        
        FZKBVehicleBasicInfoModel *model = [FZKBVehicleBasicInfoModel shareVehicleBasicInfoModel];
        
        if (model.vehicleID) {
            
            
            
            //车辆没有移动显示可用功能按钮
            if (!_isStateView&&!isMove) {
                [self showAllAbilityBtn];
                //设置车辆状态
                [self setCarButtonState];
            }
            
            
        }else{
            //没有设备跳转到设备添加界面
            SRAddEquipmentViewController * vc = [SRAddEquipmentViewController initVCWithStoryboardName:@"AddEquipment"];
            [self.rt_navigationController pushViewController:vc animated:YES complete:nil];
        }
        
        
    } fail:nil];
    
    
}


#pragma mark - 寻车方法
- (IBAction)findCarAction:(id)sender{
    
    [SRCarStatueData findCar];
}

#pragma mark - 汽车操作
- (void)carControlWithType:(SRCarControlType)type{
    
    
    
    switch (type) {
        case SRCarControlTypeStart:
            y=200;
            x=0;
            
            break;
        case SRCarControlTypeWindow:
            x=100;
            y=0;
            
            break;
        case SRCarControlTypeTrunk:
            x=0;
            y=-150;
            break;
        case SRCarControlTypeTirePressure:
            
            break;
        case SRCarControlTypeBack:
            
            if (isMove) {
                
                x=-x;
                y=-y;
                zoom=1.0;
                isMove = NO;
            }else{
                //没有移动不进行任何操作
                return;
            }
            
            break;
            
        default:
            
            break;
    }
    
    if (type!=SRCarControlTypeBack) {
        
  
        
        isMove = YES;
        zoom=1.3;
        
        //隐藏所有按钮
        [self hideButtons];
        self.changeButton.hidden = YES;
        //显示点击视图
        [self showOnly:type];
        
        
        
        
    }else{
 
        
        //显示所有按钮
        [self showAllAbilityBtn];
        self.changeButton.hidden = NO;
        // 隐藏所有视图
        [self hideAllView];
    }
    
    [FZKCAnimationManager springPopZoomWithX:zoom y:zoom view:self.mainView];
    
    [FZKCAnimationManager springPopTranslationWithX:x y:y view:self.mainView];
    
    [self.dispatch_aft runDispatch_after:0.5 block:^{
        mainViewFrame = _mainView.frame;
    }];
    
    
//    [_mainView removeConstraints:_mainView.constraints];
}

#pragma mark -点击汽车图片方法
- (void)carImageBack{
    
    [self carControlWithType:SRCarControlTypeBack];
}


#pragma mark - 隐藏所有功能视图
- (void)hideAllView{
    
    for (UIView *view in self.viewsArray) {
        if (view.alpha!=0.0) {
            //            [UIView animateWithDuration:1.0 animations:^{
            view.alpha=0.0;
            //            }];
        }
    }
}

#pragma mark - 显示其中一个视图
- (void)showOnly:(SRCarControlType)type{
    UIView *view;
    switch (type) {
        case SRCarControlTypeStart:
            view = _startView;
            break;
        case SRCarControlTypeWindow:
            view = _windowView;
            break;
        case SRCarControlTypeTrunk:
            view = _trunkView;
            break;
        default:
            break;
    }
    
    for (UIView *v in self.viewsArray) {
        if (v==view) {
            [UIView animateWithDuration:0.5 animations:^{
                v.alpha = 1.0;
                
            }];
            
        }else{
            v.alpha = 0.0;
        }
    }
    
}

#pragma mark - 设置车辆显示状态图片
- (void)setCarButtonState{
    
    
    [SRCarStatueData refreshAbilityButton:[SRCarStatueData abilityBtns:self.btnArray]];
    
    
}

#pragma mark - 收到车辆状态改变时候的通知处理
- (void)carAbilityStatueChange:(NSNotification *)notification{
    
    if ([notification.object integerValue] && isMove) {
        //车返回 处理按钮
        [self carImageBack];
    }
    
        //按钮状态重新设置
        [self setCarButtonState];
        
//        [self showAllAbilityBtn];
    
        
        //添加刷新界面通知
        [[NSNotificationCenter defaultCenter]postNotificationName:kCarStateChangelNotification object:nil];
        
//    }
    
    //发送汽车坐标修改指令
    [[NSNotificationCenter defaultCenter]postNotificationName:kCarCoorDinateChangelNotification object:nil];
    
    
}


- (IBAction)bleAction:(UIButton *)sender {
    
    [[FZKTCarStateManager shareCarStateManager] applicationDidBecomeActiveNotification:currentCarId];
}


#pragma mark - 蓝牙状态改变处理
- (void)bleStateChange:(NSNotification *)noti{
    
    NSInteger state = [noti.object integerValue];
    UIImage *bleIm;
    BOOL isTouch;
    if(state == CBPeripheralStateConnected){
    //蓝牙连接成功处理
        bleIm = [UIImage imageNamed:@"lanya"];
        isTouch = NO;
    }else if(state == CBPeripheralStateConnecting){
       //正在连接中处理
        bleIm = [UIImage animatedGIFNamed:@"bleloading"];
       isTouch = NO;
    }else{
       //蓝牙连接失败处理
         bleIm = [UIImage imageNamed:@"lanyaweilianjie"];
        isTouch = YES;
    }
    [_BLEButton setImage:bleIm forState:UIControlStateNormal];
    _BLEButton.enabled = isTouch;
    

        
}



#pragma mark - 显示侧边栏
- (IBAction)showSlideMenuAction:(UIButton *)sender {
    
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - 切换界面
- (IBAction)changeViewAction:(UIButton *)sender {
    
    self.isStateView = !self.isStateView;
}




/**
 注销
 
 @param sender 暂时性代码以后删除
 */
- (IBAction)loginOut:(id)sender {
    
    [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Login" bundle:nil]instantiateViewControllerWithIdentifier:@"RTRootNavigationController"];
    
 
    //清空数据
    [SRPublicMethod logoutClearData];
}



-(void)dealloc{
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark -
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (isMove) {
        [self carImageBack];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
//    NSLog(@"%@", _contenLabel);
//    [_scrContainViewHeightConstaint setConstant:CGRectGetMaxY(_contenLabel.frame)];
//    [_scrContaintView updateConstraintsIfNeeded];
    
//    [_mainView updateConstraintsIfNeeded];
    NSLog(@"mainFrame:%@",NSStringFromCGRect(_mainView.frame));
    
    if (CGRectGetWidth(mainViewFrame)>1.0) {
        _mainView.frame = mainViewFrame;
    }
    
    
    
}

- (void)viewWillLayoutSubviews{

    [super viewWillLayoutSubviews];
//    [_mainView updateConstraintsIfNeeded];
    NSLog(@"mainFrame:%@",NSStringFromCGRect(_mainView.frame));
    
    
}



- (IBAction)showMap:(id)sender {
    
    
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"SRMap" bundle:nil]instantiateViewControllerWithIdentifier:@"SRMainMapViewController"];
    
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
}




@end
