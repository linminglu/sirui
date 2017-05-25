//
//  FZKERoutableLasterViewController.m
//  Example
//
//  Created by czl on 2017/5/2.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKERoutableLasterViewController.h"

@interface FZKERoutableLasterViewController ()

@end

@implementation FZKERoutableLasterViewController


- (id)initWithRouterParams:(NSDictionary *)params {
    if ((self = [super init])) {
        self.title = @"不使用xib和storyboard";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
