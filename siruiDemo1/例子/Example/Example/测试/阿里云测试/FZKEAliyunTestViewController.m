//
//  FZKEAliyunTestViewController.m
//  Example
//
//  Created by czl on 2017/3/29.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKEAliyunTestViewController.h"
#import <Commons/FZKCHTTPDNSManager.h>
@interface FZKEAliyunTestViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@property (weak, nonatomic) IBOutlet UILabel *ipLabel;
@end

@implementation FZKEAliyunTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)getIp:(id)sender {
    
//    NSString *str = [FZKCHTTPDNSManager getIPWithHost:[NSString stringWithFormat:@"http://%@",_textField.text]];
//    NSLog(@"%@",str);
//    _ipLabel.text = str;
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


@end
