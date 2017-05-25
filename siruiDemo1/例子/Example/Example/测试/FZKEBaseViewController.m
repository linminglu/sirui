//
//  FZKEBaseViewController.m
//  Example
//
//  Created by czl on 2017/3/29.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKEBaseViewController.h"

@interface FZKEBaseViewController ()

@end

@implementation FZKEBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

+(instancetype)initVCWithStoryboardName:(NSString *)storyboardWithName
{
    
    
    return [[UIStoryboard storyboardWithName:storyboardWithName?storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}

@end
