//
//  WebViewController.m
//  XHLaunchAdExample
//
//  Created by zhuxiaohui on 16/9/8.
//  Copyright © 2016年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHLaunchAd
//  广告详情页

#import "WebViewController.h"
#import "UIView+MBProgressHUD.h"
#import <WebKit/WebKit.h>
@interface WebViewController ()<WKNavigationDelegate, WKUIDelegate>


@property (strong, nonatomic) WKWebView *webView;

@end

@implementation WebViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"详情";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    [_webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:_URLString]]];
}


- (IBAction)closeAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation{
    [self.view showHUD];
}



- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error{
    [self.view hideHUD];
    
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    
    [self.view hideHUD];
}


@end

