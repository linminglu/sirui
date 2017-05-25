//
//  SRTableViewController.m
//  SiRui
//
//  Created by czl on 2017/4/13.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRTableViewController.h"

@interface SRTableViewController ()

@end

@implementation SRTableViewController


+(instancetype)initVCWithStoryboardName:(NSString *)storyboardWithName;{
    
    
    return [[UIStoryboard storyboardWithName:storyboardWithName?storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:NSStringFromClass([self class])];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    

}


@end
