//
//  SRWindowsImageView.m
//  SiRui
//
//  Created by czl on 2017/4/19.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRCarLocksImageView.h"
#import <Connector/FZKBLoginModel.h>
#import <Connector/FZKBKeychain.h>
#import <Business/FZKBPhoneControllAction.h>
#import <Business/UUID.h>
//#import "SREnum.h"
#import <Connector/FZKBVehicleStatusInfoModel.h>
#import "SRCarStatueData.h"


@interface SRCarLocksImageView ()

@property (nonatomic,strong) UILongPressGestureRecognizer *longPress;


/**
 可选状态下图片
 */
@property (nonatomic,strong) UIImage *onIm;

/**
 不可选状态下图片
 */
@property (nonatomic,strong) UIImage *offIm;

@end

@implementation SRCarLocksImageView
{

    CGPoint sourceCenter;//本图原始中心点
    SRCarLocksImageView *otherImageView;//另一个图片
 
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame onIm:(UIImage * _Nonnull)onIm offIm:(UIImage * _Nonnull)offIm
{
    self = [super initWithFrame:frame];
    if (self) {
        self.onIm = onIm;
        self.offIm = offIm;
       
        [self setIsCanTouch:NO];

        sourceCenter = self.center;
        
    }
    return self;
}


-(void)setIsCanTouch:(BOOL)isCanTouch{
    _isCanTouch = isCanTouch;
    if(isCanTouch){
        self.image = self.onIm;
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:self.longPress];
    }else{
        self.image = self.offIm;
        self.userInteractionEnabled = NO;
        [self removeGestureRecognizer:self.longPress];
    }
    [self.longPress cancelsTouchesInView];
}

#pragma mark - getter
-(UILongPressGestureRecognizer *)longPress{

    if (!_longPress) {
        _longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressGes:)];
        _longPress.minimumPressDuration = 0;
        _longPress.numberOfTouchesRequired = 1;
    }
    return _longPress;
}

- (void)longPressGes:(UILongPressGestureRecognizer *)ges
{

    CGPoint center = self.center;
    CGRect sourctRect = self.superview.frame;
    CGPoint point = [ges locationInView:self.superview];
    
    switch (ges.state) {
        case UIGestureRecognizerStateBegan:
            //设置原始坐标
            otherImageView = [self findOtherView];
            [self.superview bringSubviewToFront:self];
            //移动的时候隐藏虚线
            [self getLineIm].hidden = YES;
            break;
            
        case UIGestureRecognizerStateEnded:
//            结束移动显示虚线
            
//            比较两个原点的距离，有一半的圆角宽度就进行处理
            if (fabs(center.y-otherImageView.center.y)<=(CGRectGetHeight(self.frame)*0.5)) {
//                self.userInteractionEnabled = NO;
                [self lockAction:[FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel].doorLock];
            }
            
             [self getLineIm].hidden = NO;
             center.y = sourceCenter.y;
            
            break;
        case UIGestureRecognizerStateChanged:
//            设置可以移动的距离不能超过父视图
            if (point.y<=CGRectGetHeight(self.frame)*0.5) {
                center.y = CGRectGetHeight(self.frame)*0.5;
            }else if(point.y>=(CGRectGetHeight(sourctRect)-CGRectGetHeight(self.frame)*0.5)){
                center.y = (CGRectGetHeight(sourctRect)-CGRectGetHeight(self.frame)*0.5);
            }else{
                center.y = point.y;
                
            }
            
            
            break;
        case UIGestureRecognizerStateCancelled:
            center.y = sourceCenter.y;
            break;
            
        default:
            break;
    }
    self.center = center;
}

- (SRCarLocksImageView *)findOtherView{

    for (UIView *view in self.superview.subviews) {
        if ([view isKindOfClass:[SRCarLocksImageView class]] && view!=self) {
            return (SRCarLocksImageView *)view;
        }
    }
    return nil;
    
}


/**
 获取直线

 @return
 */
- (UIImageView *)getLineIm{

    for (UIView *lineIm in self.superview.subviews) {
        if (lineIm.tag == 101) {
            return (UIImageView *)lineIm;
        }
    }
    return nil;
}

#pragma mark - 开关锁功能
- (void)lockAction:(NSInteger)lock{

    

    
    [SRCarStatueData sendCarControlCode:TLVTag_Ability_Unlock value:lock success:^(FZKActionResult *result) {
        
        
        //重置位置
        self.center = sourceCenter;
        
        //        重置拖动事件
//        [self setIsCanTouch:NO];
//        [otherImageView setIsCanTouch:YES];
        
//        self.userInteractionEnabled = YES;
        //        显示虚线
        [self getLineIm].hidden = NO;
        [self.longPress cancelsTouchesInView];
        [SVProgressHUD dismiss];
        
    } fail:^(FZKActionResult *result) {
        
        self.center = sourceCenter;
        //        重置拖动事件
        self.userInteractionEnabled = YES;
        
        [self getLineIm].hidden = NO;
        
        [self.longPress cancelsTouchesInView];
    }];
}



@end
