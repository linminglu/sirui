//
//  SRCarScrollViewController.m
//  SiRui
//
//  Created by czl on 2017/4/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRCarScrollViewController.h"
#import "SRCarContolMainViewController.h"
#import "SRCarInfoViewController.h"
//#import <MMDrawerController.h>
#import <UIViewController+MMDrawerController.h>
#import <MMDrawerBarButtonItem.h>
#import "SRCustomerScrollView.h"

#import "SRMainMapViewController.h"

@interface SRCarScrollViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SRCarScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    SRMainMapViewController *carinfo = [SRMainMapViewController initVCWithStoryboardName:@"SRMap"];
    SRCarContolMainViewController *carControl = [SRCarContolMainViewController initVCWithStoryboardName:@"CarStoryboard"];

   CGRect rect = FZKFlexibleFrame(self.scrollView.frame);
    
    self.scrollView.frame = rect;
    
    carControl.view.frame  = CGRectMake(0, 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    [self.scrollView addSubview:carControl.view];
    
//    carinfo.view.frame = CGRectMake(CGRectGetWidth(rect), 0, CGRectGetWidth(rect), CGRectGetHeight(rect));
    
    [self.scrollView addSubview:carControl.view];
//    [self.scrollView addSubview:carinfo.view];
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(rect)*2, 0);
    
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
//    [self addChildViewController:carinfo];
    [self addChildViewController:carControl];
    
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    //设置打开抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //设置关闭抽屉模式
    [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
