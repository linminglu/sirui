//
//  FZKEPeripheralViewController.m
//  Example
//
//  Created by czl on 2017/5/18.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKEPeripheralTestViewController.h"
#import <Connector/FZKTBluetoothManager.h>
#import <SVProgressHUD.h>
#import <Business/FZKBPhoneControllAction.h>

@interface FZKEPeripheralTestViewController ()

@end

@implementation FZKEPeripheralTestViewController
{

    FZKTBluetoothManager *manager;
    NSInteger cmds;
}
- (void)viewDidLoad {
    

    
    
    [super viewDidLoad];
    
    
    self.title = @"蓝牙连接测试";
    self.view.backgroundColor = [UIColor whiteColor];
    
    manager = [FZKTBluetoothManager shareBluetoothManager];
    
    [manager connect:_bleModel];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发送控制指令" style:UIBarButtonItemStylePlain target:self action:@selector(sendCommand)];
    
    // Do any additional setup after loading the view.
}

- (void)dealloc{

    [manager disConnect];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)sendCommand{

    cmds++;
    
//    [manager sendCommand:(cmds%2==0)?SRBLEInstruction_Lock:SRBLEInstruction_Unlock withCompleteBlock:^(NSError *error, id responseObject) {
//        NSString *str;
//        if (error) {
//            str = error.domain;
//        }else{
//        
//            str = responseObject;
//        }
//        
////        [SVProgressHUD showInfoWithStatus:str];
//    }];
    
    
//    FZKBPhoneControllAction *action =[FZKBPhoneControllAction new];
    
    FZKBPhoneControllAction *phone = [FZKBPhoneControllAction new];
    
    [phone phoneControllActionWithCarId:0 tag:TLVTag_Instruction_Lock controlSeries:123 success:^(id parameter) {
        
        [SVProgressHUD dismiss];
//        success(nil);
        
    } fail:^(FZKActionResult *parameter) {
        
        [SVProgressHUD showErrorWithStatus:parameter.resultMessage];
//        fail(nil);
    }];
}


@end
