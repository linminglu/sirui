//
//  SRCarInfoViewController.m
//  SiRui
//
//  Created by czl on 2017/4/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRCarInfoViewController.h"

@interface SRCarInfoViewController ()
//@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation SRCarInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.parentViewController.navigationController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右边" style:UIBarButtonSystemItemSave target:self action:nil];
//    self.scrollView.contentSize = CGSizeMake(1000, 1000);
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


/**
 地图跳转方法

 @param sender
 */
- (IBAction)mapView:(id)sender {
    
    
    
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"SRMap" bundle:nil]instantiateViewControllerWithIdentifier:@"SRMainMapViewController"];
    
    [self.parentViewController.navigationController pushViewController:vc animated:YES];
}

@end
