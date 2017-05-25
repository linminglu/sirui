//
//  FZKERoutableTableViewController.m
//  Example
//
//  Created by czl on 2017/5/2.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKERoutableTableViewController.h"
#import "FZKERoutableLasterViewController.h"
#import "FZKERoutableNext1ViewController.h"
#import "FZKERoutableMainViewController.h"
#import "FZKERoutableConfig.h"
#import <Routable.h>

@interface FZKERoutableTableViewController ()

//功能测试数组
@property (nonatomic,strong) NSMutableArray *dataArray;

@end

@implementation FZKERoutableTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"路由功能测试";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
//    配置路由
    [FZKERoutableConfig share];
    
//    设置状态栏
    [[Routable sharedRouter] setNavigationController:self.navigationController];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


#pragma mark - Table view data source
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

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIViewController *vc;
    
    switch (indexPath.row) {
        case 0:
//            vc = [Routable sharedRouter];
            [[Routable sharedRouter]open:@"main"];
            break;
        case 1:
//            vc = [FZKEAliyunTestViewController initVCWithStoryboardName:nil];
            [[Routable sharedRouter]open:@"next1"];
            break;
        case 2:
            [[Routable sharedRouter]open:@"last"];
            break;

            break;
            
        default:
            break;
    }
    
//    [self.navigationController pushViewController:vc animated:YES];
    //    [self presentViewController:vc animated:YES completion:nil];
}

- (NSMutableArray *)dataArray
{
    
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
        [_dataArray addObjectsFromArray:@[@"含storeboard\nFZKERoutableMainViewController",@"含XIB\nFZKERoutableNext1ViewController",@"不使用XIB和storeboard\nFZKERoutableLasterViewControllern"]];
    }
    return _dataArray;
}

@end
