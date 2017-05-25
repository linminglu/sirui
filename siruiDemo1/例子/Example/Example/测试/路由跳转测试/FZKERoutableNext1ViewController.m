//
//  FZKERoutableNext1ViewController.m
//  Example
//
//  Created by czl on 2017/5/2.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKERoutableNext1ViewController.h"

@interface FZKERoutableNext1ViewController ()

@end

@implementation FZKERoutableNext1ViewController


- (id)initWithRouterParams:(NSDictionary *)params {
    if ((self = [self initWithNibName:nil bundle:nil])) {
        self.title = @"使用XIB";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
