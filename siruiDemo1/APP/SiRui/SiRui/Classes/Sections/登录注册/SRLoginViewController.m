//
//  SRLoginViewController.m
//  SiRui
//
//  Created by 宋搏 on 2017/4/13.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRLoginViewController.h"
#import <Business/FZKBLoginAction.h>
#import <Connector/FZKViewActionProcessor.h>
#import "SRAddEquipmentViewController.h"
#import <Commons/FZKCHTTPDNSManager.h>
#import <Connector/FZKBDomainConfig.h>
#import <RTRootNavigationController/RTRootNavigationController.h>
#import <Connector/FZKBLoginModel.h>
#import "SRCarContolMainViewController.h"
#import <MJExtension.h>
#import "SRIntroductionViewController.h"
#import <AFNetworking.h>
#import "SRCarScrollViewController.h"
#import "SRRounteUntils.h"


@interface SRLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *urlSettingButton;

@end

@implementation SRLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    
    
#if DEBUG
    _urlSettingButton.hidden  = NO;
#else
     _urlSettingButton.hidden  = YES;
#endif


    
}


-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:@"FirstStart"]) {
        
        SRIntroductionViewController *welcome = [[SRIntroductionViewController alloc] init];
        [self presentViewController:welcome animated:NO completion:NULL];
        
        
    }

}


/**
 登录
 */
- (IBAction)loginButtonClicked:(id)sender {
    
    
    if (_userNameTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"用户名不能为空"];
        return;
    }
    if (_passwordTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        
        return;
    }
    
    
    [FZKBLoginAction loginActionWithInput1:_userNameTF.text.RSAEncode input2:_passwordTF.text.RSAEncode
                                   success:^(id parameter) {
                                       
                                       [self goMain:parameter];
                                       
                                   } fail:^(id parameter) {
                                       
                                   }];
    
    // 初始化Session对象
//    AFHTTPSessionManager  *manger = [AFHTTPSessionManager manager];
    // 设置请求接口回来的时候支持什么类型的数据
//    manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"application/x-json",@"text/html", nil];
    
//    [manger POST:@"http://4s.mysirui.com/basic/customer/phoneLogin" parameters:@{@"input1":_userNameTF.text.RSAEncode,@"input2":_passwordTF.text.RSAEncode} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        
//        NSLog(@"%@",responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"error:%@",error.localizedDescription);
//    }];
}


-(void) showAuthInput{
    NSLog(@"showAuthInput");
}


-(void) goMain:(id)paramters{
    NSLog(@"goMain");
//       FZKBLoginModel *model = [FZKBLoginModel mj_objectWithKeyValues:paramters];
    UIViewController *vc;
//    if(model.customer.customerBinded){
//        [[NSUserDefaults standardUserDefaults]setObject:@(model.customer.vehicleModelID) forKey:@"kSelectCarId"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//        vc = [SRCarContolMainViewController initVCWithStoryboardName:@"CarStoryboard"];
    vc = [SRCarScrollViewController initVCWithStoryboardName:@"CarStoryboard"];
        
//    }else{
//        vc = [SRAddEquipmentViewController initVCWithStoryboardName:@"AddEquipment"];
//        [vc setValue:@(model.customer.customerBinded) forKey:@"hasDevice"];
//    }
//    RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:vc];
//    
//    [self presentViewController:nav animated:NO completion:NULL];
    
    [self presentViewController:[SRRounteUntils slideMainMenu] animated:YES completion:NULL];
    
    
    
    
}




/**
 找回密码
 */
- (IBAction)retrievePasswordButtonClicked:(id)sender {
    
}

@end
