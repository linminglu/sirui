//
//  FZKBRegisterViewController.m
//  Business
//
//  Created by 宋搏 on 12/04/2017.
//  Copyright © 2017 chinapke. All rights reserved.
//

#import "SRAddEquipmentViewController.h"
#import "SRRegisterTableViewController.h"
#import <Business/FZKBCustomerRegisterAction.h>
#import <Business/FZKBGetAuthCodeRegisterAction.h>
#import <Commons/JKCountDownButton.h>
#import <Connector/FZKInterceptorUtil.h>
#import <Connector/FZKViewActionProcessor.h>
#import <RTRootNavigationController/RTRootNavigationController.h>
#import "SRUserAgreementViewController.h"
//#import <Connector/FZKTCPClient.h>


@interface SRRegisterTableViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *verificationCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (weak, nonatomic) IBOutlet JKCountDownButton *verificationCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *userAgreementChoiceButton;

@end

@implementation SRRegisterTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = NO;

    [_userAgreementChoiceButton setImage:[UIImage imageNamed:@"4"] forState:UIControlStateSelected];
    [_userAgreementChoiceButton setImage:[UIImage imageNamed:@"5"] forState:UIControlStateNormal];
    
    
    
}
- (IBAction)userAgreementButtonClicked:(id)sender {
    SRUserAgreementViewController *userAgreement = [SRUserAgreementViewController new];
    [self.navigationController pushViewController:userAgreement animated:YES];
    
}
- (IBAction)userAgreementChoice:(UIButton *)sender {
    
    _userAgreementChoiceButton.selected = !sender.selected;

    NSLog(@"%@",_userAgreementChoiceButton.selected?@"YES":@"NO");
}

/**
 获取验证码
 */
- (IBAction)verificationCodeButtonClicked:(JKCountDownButton *)sender {
    
    if (_phoneTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"手机号不能为空"];
        return;
    }
    
    if (![FZKPublicMothod validateMobile:_phoneTF.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号格式错误"];
        
        return;
    }
    
    
    [FZKBGetAuthCodeRegisterAction getAuthCodeRegisterActionWithPhone:_phoneTF.text fromRegist:nil type:nil
                                                              success:^(id parameter) {
                                                                  
                                                                  
                                                                  [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
                                                                  sender.enabled = NO;
                                                                  //button type要 设置成custom 否则会闪动
                                                                  [sender startCountDownWithSecond:60];
                                                                  
                                                                  [sender countDownChanging:^NSString *(JKCountDownButton *countDownButton,NSUInteger second) {
                                                                      NSString *title = [NSString stringWithFormat:@"剩余%zd秒",second];
                                                                      return title;
                                                                  }];
                                                                  [sender countDownFinished:^NSString *(JKCountDownButton *countDownButton, NSUInteger second) {
                                                                      countDownButton.enabled = YES;
                                                                      return @"重新获取";
                                                                      
                                                                  }];
                                                              } fail:^(id parameter) {
                                                                  
                                                                  
                                                                  
                                                              }];
    
    
    
    
    
    
    
}







/**
 注册
 */
- (IBAction)registerButtonClicked:(id)sender {
    
    
    
    
    if (_userAgreementChoiceButton.selected == NO) {
        [SVProgressHUD showInfoWithStatus:@"请先同意用户协议"];
        return;
    }
    
    if (_phoneTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"手机号不能为空"];
        return;
    }
    
    if (![FZKPublicMothod validateMobile:_phoneTF.text]) {
        [SVProgressHUD showInfoWithStatus:@"手机号格式错误"];
        
        return;
    }
    
    
    if (_verificationCodeTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"验证码不能为空"];
        return;
    }
    
    if (_passwordTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"密码不能为空"];
        return;
    }
    
    if (_confirmPasswordTF.text.length == 0) {
        [SVProgressHUD showInfoWithStatus:@"请输入确认密码"];
        return;
    }
    
    
    if (![_passwordTF.text isEqualToString:_confirmPasswordTF.text]) {
        [SVProgressHUD showInfoWithStatus:@"两次密码输入不一致"];
        return;
    }
    
    if (_passwordTF.text.length < 6 || _confirmPasswordTF.text.length < 6 ) {
        [SVProgressHUD showInfoWithStatus:@"密码长度必须大于6位"];
        return;
    }
    

    
    
    [FZKBCustomerRegisterAction customerRegisterActionWithCustomerPhone:_phoneTF.text authcode:_verificationCodeTF.text customerPassword:_confirmPasswordTF.text
                                                                success:^(id parameter) {
                                                                    [self goMain];
                                                                } fail:^(id parameter) {
                                                                    
                                                                }];
    
    
}


-(void) goMain{
    NSLog(@"goMain");
    
    UITableViewController * vc = [SRAddEquipmentViewController initVCWithStoryboardName:@"AddEquipment"];
    RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:vc];
    [self presentViewController:nav animated:NO completion:NULL];
    
    
}

@end
