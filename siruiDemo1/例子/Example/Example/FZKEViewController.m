//
//  ViewController.m
//  Example
//
//  Created by czl on 2017/3/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKEViewController.h"
#import "FZKEAliyunTestViewController.h"
#import "FZKEPayTestViewController.h"
#import "FZKEShareTestViewController.h"
#import "FZKEMapTestViewController.h"
#import "FZKEAnnimationTestViewController.h"
#import "FZKEBaiduMapViewController.h"
#import "FZKERoutableTableViewController.h"
#import "FZKEBLETestViewController.h"
#import <MJExtension.h>
@interface FZKEViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

//功能测试数组
@property (nonatomic,strong) NSMutableArray *dataArray;


@end

@implementation FZKEViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"功能测试";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(7_0){

    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.numberOfLines=0;
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *vc;
    
    switch (indexPath.row) {
        case 0:
            vc = [FZKEPayTestViewController initVCWithStoryboardName:nil];
            break;
        case 1:
            vc = [FZKEAliyunTestViewController initVCWithStoryboardName:nil];
            break;
        case 2:
            vc = [FZKEShareTestViewController initVCWithStoryboardName:nil];
            break;
        case 3:
            vc = [FZKEMapTestViewController initVCWithStoryboardName:nil];
            break;
        case 4:
            vc = [FZKEAnnimationTestViewController initVCWithStoryboardName:nil];
            break;


        case 5:
            vc = [FZKEBaiduMapViewController initVCWithStoryboardName:nil];
            break;
        case 6:
           vc = [[UIStoryboard storyboardWithName:@"Routable" bundle:nil] instantiateViewControllerWithIdentifier:@"FZKERoutableTableViewController"];
            break;
        case 7:
       
            vc = [FZKEBLETestViewController initVCWithStoryboardName:nil];
            break;
        default:
            break;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
}

- (NSMutableArray *)dataArray
{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
        [_dataArray addObjectsFromArray:@[@"支付测试\nFZKEPayTestViewController",@"阿里云测试\nFZKEAliyunTestViewController",@"分享测试\nFZKEShareTestViewController",@"地图Manger测试\nFZKEMapTestViewController",@"动画测试\nFZKEAnnimationTestViewController",@"百度地图封装测试\nFZKEBaiduMapViewController",@"路由跳转测试\nFZKERoutableTableViewController",@"蓝牙测试\nFZKEBLETestViewController"]];
    }
    return _dataArray;
}


@end
