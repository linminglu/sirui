//
//  SRRounteUntils.m
//  SiRui
//
//  Created by czl on 2017/5/5.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRRounteUntils.h"
#import "SRSlideMenuMainViewController.h"
#import "SRCarScrollViewController.h"
#import <RTRootNavigationController.h>
#import "SRSliderMenuCustomerViewController.h"

@implementation SRRounteUntils


+ (MMDrawerController *)slideMainMenu{

    SRSlideMenuMainViewController *leftVC = [[SRSlideMenuMainViewController alloc] init];
    
    RTRootNavigationController *centerNav = [[RTRootNavigationController alloc] initWithRootViewController:[SRCarScrollViewController initVCWithStoryboardName:@"CarStoryboard"]];
//    centerNav.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
//    centerNav.navigationBar.tintColor = [UIColor whiteColor];
//    centerNav.navigationBar.barTintColor = [UIColor colorWithRed:44/255.0 green:185/255.0 blue:176/255.0 alpha:1];
    
    
    SRSliderMenuCustomerViewController *drawerController = [[SRSliderMenuCustomerViewController alloc]initWithCenterViewController:centerNav leftDrawerViewController:leftVC];
    [drawerController setShowsShadow:YES];
    [drawerController setMaximumLeftDrawerWidth:SCREEN_WIDTH-100];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeBezelPanningCenterView];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    
//    [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
//        
//        MMDrawerControllerDrawerVisualStateBlock block;
//        block = [[MMExampleDrawerVisualStateManager sharedManager]
//                 drawerVisualStateBlockForDrawerSide:drawerSide];
//        if(block){
//            block(drawerController, drawerSide, percentVisible);
//        }
//        
//    }];//侧滑效果
    return drawerController;
}

@end
