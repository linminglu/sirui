//
//  FZKEShareTestViewController.m
//  Example
//
//  Created by czl on 2017/3/29.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKEShareTestViewController.h"
#import <Commons/FZKCShareManager.h>

@interface FZKEShareTestViewController ()

@end

@implementation FZKEShareTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)share:(id)sender {
    [FZKCShareManager shareSetupShareParamsByText:@"测试内容" images:nil url:nil title:@"分享标题"];
}



@end
