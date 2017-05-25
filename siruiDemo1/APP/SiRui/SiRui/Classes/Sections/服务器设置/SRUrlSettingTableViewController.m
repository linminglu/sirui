//
//  SRUrlSettingTableViewController.m
//  SiRui
//
//  Created by 宋搏 on 2017/4/21.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRUrlSettingTableViewController.h"
#import "SRURLManager.h"
#import <SUIMVVMKit/SMKAction.h>
#import <Connector/FZKHttpWork.h>

@interface SRUrlSettingTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *serverTF;
@property (weak, nonatomic) IBOutlet UISegmentedControl *serverSegmentedControl;

@end

@implementation SRUrlSettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _serverTF.text = [SRURLManager shared].server4SPortal;
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _serverSegmentedControl.selectedSegmentIndex = [[SRURLManager shared].server4SPortal isEqualToString:@"4s.mysirui.com"]?0:1;
    
    
}

- (IBAction)serverChanged:(UISegmentedControl *)sender {
    
    
    if (sender.selectedSegmentIndex == 0) {
        _serverTF.text = @"4s.mysirui.com";
        [self server4SPortal:_serverTF.text];
        
        
    }else{
        
        _serverTF.text = @"192.168.6.148:8080";
        [self server4SPortal:_serverTF.text];
        
        
        
    }
    
}

- (IBAction)done:(id)sender {
    
    
    [self server4SPortal:nil];
    
}

-(void)server4SPortal:(NSString *)server4SPortal{
    
    [SRURLManager shared].server4SPortal = server4SPortal;
    [[SRURLManager shared] archive];
    [[SMKAction sharedAction] configScheme:@"http" host:server4SPortal];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 6;
}



@end
