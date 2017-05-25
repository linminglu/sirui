//
//  SRSlideMenuMainViewController.m
//  SiRui
//
//  Created by czl on 2017/5/5.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRSlideMenuMainViewController.h"
#import <Connector/FZKBCustomerModel.h>
#import "SRViewController.h"

@interface SRSlideMenuMainViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation SRSlideMenuMainViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageview.image = [UIImage imageNamed:@"cehuabeijintu"];
    [self.view addSubview:imageview];
    
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-100, SCREENH_HEIGHT) style:UITableViewStyleGrouped];
    tableview.dataSource = self;
    tableview.delegate  = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.scrollEnabled = NO;
    [self.view addSubview:tableview];
    
    UILabel *visionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, SCREENH_HEIGHT-100, SCREEN_WIDTH-100, 40)];
    visionLabel.text = [NSString stringWithFormat:@"版本:%@", APP_VERSION];
    visionLabel.textColor = [UIColor colorWithHexString:@"#727171"];
    visionLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:visionLabel];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self slideMenu].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *Identifier = @"Identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    NSDictionary *dic = self.slideMenu[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = [UIFont systemFontOfSize:20.0f];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#3e3a39"];
    cell.textLabel.text = dic[@"title"];
    cell.imageView.image = [UIImage imageNamed:dic[@"image"]];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    PushController *pushVC = [[PushController alloc] init];
//    pushVC.titleString = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    SRViewController *other = [SRViewController new];
    
    //拿到我们的LitterLCenterViewController，让它去push
    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;
    [nav pushViewController:other animated:NO];
    //当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 240;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 240)];
    view.backgroundColor = [UIColor clearColor];
    
    
    UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    imageButton.frame = CGRectMake(CGRectGetWidth(view.frame)/2-25, 80, 50, 50);
    imageButton.layer.cornerRadius = 25;
    [imageButton setBackgroundImage:[UIImage imageNamed:@"icon_tabbar_mine_selected"] forState:UIControlStateNormal];
    [view addSubview:imageButton];
    [imageButton addTarget:self action:@selector(imgButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imageButton.frame)+5, tableView.bounds.size.width, 20)];
    nameLabel.text = [FZKBCustomerModel shareCustomer].name;
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:nameLabel];
    
    return view;
}


- (void)imgButtonAction {
    

    UINavigationController* nav = (UINavigationController*)self.mm_drawerController.centerViewController;

    //当我们push成功之后，关闭我们的抽屉
    [self.mm_drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
        //设置打开抽屉模式为MMOpenDrawerGestureModeNone，也就是没有任何效果。
        [self.mm_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    }];
}


- (NSArray *)slideMenu{

    return @[@{@"image":@"gexingfuwu",@"title":@"个性服务"},@{@"image":@"shouquanguanli",@"title":@"授权管理"},@{@"image":@"xingxizhongxin",@"title":@"信息中心"},@{@"image":@"shezhi",@"title":@"系统设置"},@{@"image":@"guanyuwomen",@"title":@"关于我们"}];
}




@end
