//
//  SRSliderMenuCustomerViewController.m
//  SiRui
//
//  Created by czl on 2017/5/5.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRSliderMenuCustomerViewController.h"

@interface SRSliderMenuCustomerViewController ()

@end

@implementation SRSliderMenuCustomerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    //    CGPoint velocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:self];
    UIScrollView *scrollView;
    RTRootNavigationController *nav = self.centerViewController;
    
    for (UIView *ui in nav.rt_topViewController.view.subviews) {
        //约定scrollView tag202
        if (ui.tag==202) {
            scrollView = (UIScrollView *)ui;
            break;
        }
    }
    
    CGPoint location = [gestureRecognizer locationInView:scrollView];
//    if(location.x>[UIScreen mainScreen].bounds.size.width+60){
//        scrollView.scrollEnabled = NO;
//    }else{
//        scrollView.scrollEnabled = YES;
//    }
    
    if (self.openSide!=MMDrawerSideNone) {
        return YES;
    }
    //    NSLog(@"velocity.x:%f----location.x:%d",velocity.x,(int)location.x%(int)[UIScreen mainScreen].bounds.size.width);
    if (location.x<60) {
        return YES;
    }
    return NO;
}

@end
