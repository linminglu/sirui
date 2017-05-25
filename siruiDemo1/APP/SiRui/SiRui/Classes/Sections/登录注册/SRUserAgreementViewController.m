//
//  SRUserAgreementViewController.m
//  SiRui
//
//  Created by 宋搏 on 2017/4/18.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRUserAgreementViewController.h"
#import <WebKit/WebKit.h>
#import "SRURLManager.h"

@interface SRUserAgreementViewController ()<WKNavigationDelegate, WKUIDelegate>

@property (strong, nonatomic) WKWebView *webView;

@end

@implementation SRUserAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"思锐用户协议";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _webView = [[WKWebView alloc] initWithFrame:self.view.bounds];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    [self.view addSubview:_webView];
    
    NSString *url = [NSString stringWithFormat:@"http://%@/basic/protocol/query",[SRURLManager shared].server4SPortal];

    [_webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]]];
  ;
}



@end
