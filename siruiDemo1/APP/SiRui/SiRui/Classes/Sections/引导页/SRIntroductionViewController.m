//
//  SRIntroductionViewController.m
//  SiRui
//
//  Created by 宋搏 on 2017/4/20.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRIntroductionViewController.h"

@interface SRIntroductionViewController ()

@end

@implementation SRIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor= [UIColor colorWithHexString:@"193a4f"];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"FirstStart"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    // data source
    self.coverImageNames = @[@"yidaoye@2x-27", @"yidaoye@2x-28", @"yidaoye@2x-29",@"yidaoye@2x-30"];

    
    self.introductionView = [self customButtonIntroductionView];
    

    
    
    [self.view addSubview:self.introductionView.view];
    
    __weak __typeof__(self) weakSelf = self;
    self.introductionView.didSelectedEnter = ^() {
        weakSelf.introductionView = nil;
        [weakSelf dismissViewControllerAnimated];
    };
    
}


- (ZWIntroductionViewController *)customButtonIntroductionView{
    UIButton *enterButton = [UIButton new];
    [enterButton setImage:[UIImage imageNamed:@"lijitiyan"] forState:UIControlStateNormal];
    [enterButton setTitle:nil forState:UIControlStateNormal];
    ZWIntroductionViewController *vc = [[ZWIntroductionViewController alloc] initWithCoverImageNames:self.coverImageNames backgroundImageNames:self.backgroundImageNames button:enterButton];
    return vc;
}



- (void)dismissViewControllerAnimated{
    
    
    
    [UIView transitionWithView:self.navigationController.view duration:1.0 options:UIViewAnimationCurveEaseInOut|UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [self dismissViewControllerAnimated:NO completion:NULL];
    } completion:NULL];
}

@end

