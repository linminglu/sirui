//
//  SRAddEquipmentViewController.m
//  SiRui
//
//  Created by czl on 2017/4/13.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRAddEquipmentViewController.h"
//#import "SRQrScanViewController.h"
#import "SRIMEIScanViewController.h"
#import <Business/FZKBBindTerminalAction.h>
#import "SRCarContolMainViewController.h"
#import <LBXScan/LBXScanViewController.h>
#import <Connector/FZKBCarEntityModel.h>
#import "SRBrandVehicleViewController.h"
#import <Business/FZKBLoginAction.h>
#import <Connector/FZKBKeychain.h>

@interface SRAddEquipmentViewController ()<SRBrandVehicleViewControllerDelegate>


/**
 设备
 */
@property (weak, nonatomic) IBOutlet UILabel *deviceLabel;


/**
 车型
 */
@property (weak, nonatomic) IBOutlet UILabel *automobileBrandLabel;


/**
 车架号
 */
@property (weak, nonatomic) IBOutlet UITextField *VINTextField;


/**
 车牌号
 */
@property (weak, nonatomic) IBOutlet UITextField *plateNumberTextField;



@end

@implementation SRAddEquipmentViewController
{
    
    //是否可以选择车牌  默认为no
    BOOL isNotCanSelect;
    //记录当前设备信息
    FZKBCarEntityModel *currentCar;
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    currentCar = [FZKBCarEntityModel new];
    
    //    如果没有设备，就直接跳转到二维码扫描界面
    if (!self.hasDevice) {
        [self pushScanViewController];
    }
    
    

    
    
}


- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
    self.title = @"添加设备";
}


#pragma mark - tableViewDelegate 代理
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row==1) {
        [self pushScanViewController];
        
        
    }else if (indexPath.row==2 && !isNotCanSelect){
        
        
        [self selectBrandInfo];
        
    }
}

#pragma mark - 跳转到扫描界面
- (void)pushScanViewController{
    if ([SRPublicMethod isCanUerCamer]) {
        
        SRIMEIScanViewController *scanView = [SRIMEIScanViewController new];
        //        扫描结果回调
        scanView.scanVieBlock = ^ (FZKBCarEntityModel *model){
            
            //解析数据并赋值
            [self parseIMEIModel:model];
            
        };
        
        [self.navigationController pushViewController:scanView animated:YES];
    }
    
}




- (IBAction)addNewCar:(id)sender
{
    
    //    这里判断是否可以添加车辆
    if ([_deviceLabel.text isEqualToString:@"请扫描设备"]) {
        [SVProgressHUD showInfoWithStatus:@"请扫描设备"];
        return;
    }
    //
    
    if ([_automobileBrandLabel.text isEqualToString:@"请选择爱车车型"]) {
        [SVProgressHUD showInfoWithStatus:@"请选择爱车车型"];
        return;
    }
    
    
    
    //以上为测试数据
    
    //    [FZKBAddNewCarAction addNewCarActionWithVehicleModelID:@(currentCar.sid).stringValue imei:currentCar.imei success:^(id parameter) {
    //        [self addCarAction];
    //    } fail:^(id parameter) {
    //        [self addCarAction];
    //    }];
    
    
    [FZKBBindTerminalAction bindTerminalActionWithVehicleModelID:@(currentCar.sid).stringValue imei:currentCar.imei vin:currentCar.vin plateNumber:currentCar.platenumber success:^(id parameter) {
        [self addCarAction];
    } fail:^(id parameter) {

    }];
    
    
}

#pragma mark - 添加车辆成回调
- (void)addCarAction{
    
//    [self login];
    
            [self goMain:nil];
}

#pragma mark - 解析扫描返回的数据
- (void)parseIMEIModel:(FZKBCarEntityModel *)model{
    
    
    
    currentCar.imei = model.imei;
    
    _deviceLabel.text = currentCar.imei;
    
    //    判断是否可以选择车型
    if (model.sid) {
        isNotCanSelect = YES;
        _automobileBrandLabel.text = [NSString stringWithFormat:@"%@%@%@",currentCar.bname,currentCar.vmname,currentCar.sname];
        currentCar.sid = model.sid;
    }else{
        
      isNotCanSelect = NO;
      _automobileBrandLabel.text = @"请选择爱车车型";
    }
    
    //    是否可以编辑车架号
    if (model.vin) {
        _VINTextField.enabled = NO;
        currentCar.vin = model.vin;
    }else{
        _VINTextField.enabled = YES;
    }
    //    是否可以编辑车牌
    if (model.platenumber) {
        _VINTextField.enabled = NO;
        
        currentCar.platenumber = model.platenumber;
    }else{
        _VINTextField.enabled = YES;
    }
    
    _VINTextField.text = currentCar.vin;
    _plateNumberTextField.text = currentCar.platenumber;
    
    
}






#pragma mark - 选择车型
-(void)selectBrandInfo{
    
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"BrandVehicle" bundle:nil];
    SRBrandVehicleViewController *brandVehicle=[story instantiateViewControllerWithIdentifier:@"SRBrandVehicleViewController"];
    brandVehicle.delegate = self;
    [self presentViewController:brandVehicle animated:YES completion:NULL];
    
}

- (void)selectedBrandInfo:(FZKBBrandInfo *)brandInfo seriesInfo:(FZKBSeriesInfo *)seriesInfo andVehicleInfo:(FZKBVehicleInfo *)vehicleInfo {
    
    if (!brandInfo||!seriesInfo||!vehicleInfo) {
        return;
    }
    NSString *textString = [NSString stringWithFormat:@"%@/%@",brandInfo.name, vehicleInfo.vehicleName];
    
    _automobileBrandLabel.text =textString?textString:@"请选择爱车车型";
    currentCar.sid = vehicleInfo.vehicleModelID;
    
}


//请求车辆信息
-(void)login{
    
    [FZKBLoginAction loginActionWithInput1:[FZKBKeychain UserName] input2:[FZKBKeychain Password]
                                   success:^(id parameter) {
                                       
                                       [self goMain:parameter];
                                       
                                   } fail:^(id parameter) {
                                       
                                   }];
    
    
}

-(void) goMain:(id)paramters{
    
    UIViewController *vc;
    vc = [SRCarContolMainViewController initVCWithStoryboardName:@"CarStoryboard"];
    RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:NO completion:NULL];
    
    
    
    
    
}

@end
