//
//  FZKEAnnimationTestViewController.m
//  Example
//
//  Created by czl on 2017/4/6.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKEAnnimationTestViewController.h"
#import <Commons/FZKCAnimationManager.h>

#import <Lottie/Lottie.h>

@interface FZKEAnnimationTestViewController ()

@property (weak, nonatomic) IBOutlet UIView *sourceView;
@end

@implementation FZKEAnnimationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/**
 缩放
 
 @param sender
 */
- (IBAction)zoom:(id)sender {
    [FZKCAnimationManager springPopZoomWithX:0.5 y:0.5 view:_sourceView];
}


/**
 旋转
 
 @param sender
 */
- (IBAction)retation:(id)sender {
    [FZKCAnimationManager springPopRotatingWithAngle:10*M_PI view:_sourceView];
}


/**
 平移
 
 @param sender
 */
- (IBAction)tranation:(id)sender {
    [FZKCAnimationManager springPopTranslationWithX:50 y:50 view:_sourceView];
}


/**
 加载lottie动画
 
 @param sender
 */
- (IBAction)lottieJson:(id)sender {
    
    LOTAnimationView *lot = [LOTAnimationView animationNamed:@"E"];
    lot.center = CGPointMake(100, 300);
    [self.view addSubview:lot];
    lot.backgroundColor = [UIColor greenColor];
    [self.view setNeedsLayout];
    [lot play];
    
}


@end
