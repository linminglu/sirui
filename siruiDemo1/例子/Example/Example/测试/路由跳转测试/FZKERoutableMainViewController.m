//
//  FZKERoutableMainViewController.m
//  Example
//
//  Created by czl on 2017/5/2.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKERoutableMainViewController.h"

@interface FZKERoutableMainViewController ()

@end

@implementation FZKERoutableMainViewController


+ (instancetype)allocWithRouterParams:(NSDictionary *)params {
    
    
    FZKERoutableMainViewController *main =[[UIStoryboard storyboardWithName:@"Routable" bundle:nil]instantiateViewControllerWithIdentifier:@"FZKERoutableMainViewController"];
    main.title = @"UIStoryboard 样式路由";
    
    
    return main;
    
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
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
- (IBAction)next:(id)sender {
}

@end
