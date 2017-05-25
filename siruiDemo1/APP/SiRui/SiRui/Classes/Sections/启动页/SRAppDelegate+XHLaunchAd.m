//
//  SRAppDelegate+XHLaunchAd.m
//  SiRui
//
//  Created by 宋搏 on 2017/4/21.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRAppDelegate+XHLaunchAd.h"
#import "XHLaunchAd.h"

#import <Commons/Network.h>
#import <Commons/LaunchAdModel.h>
#import <Commons/WebViewController.h>





@interface SRAppDelegate()<XHLaunchAdDelegate>

@end

@implementation SRAppDelegate (XHLaunchAd)
-(void)setupXHLaunchAd
{
    
    //1.******图片开屏广告 - 网络数据******
    [self example01_imageAd_networkData];
    
    
}
#pragma mark - 图片开屏广告-网络数据-示例
//图片开屏广告 - 网络数据
-(void)example01_imageAd_networkData
{
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将自动进入window的RootVC
    //3.数据获取成功,初始化广告时,自动结束等待,显示广告
    [XHLaunchAd setWaitDataDuration:3];//请求广告数据前,必须设置
    
    //广告数据请求
    [Network getLaunchAdImageDataSuccess:^(NSDictionary * response) {
        
        NSLog(@"广告数据 = %@",response);
        
        //广告数据转模型
        LaunchAdModel *model = [[LaunchAdModel alloc] initWithDict:response[@"data"]];
        //配置广告数据
        XHLaunchImageAdConfiguration *imageAdconfiguration = [XHLaunchImageAdConfiguration new];
        //广告停留时间
        imageAdconfiguration.duration = model.duration;
        //广告frame
        imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width/model.width*model.height);
        //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
        imageAdconfiguration.imageNameOrURLString = model.content;
        //缓存机制(仅对网络图片有效)
        imageAdconfiguration.imageOption = XHLaunchAdImageDefault;
        //图片填充模式
        imageAdconfiguration.contentMode = UIViewContentModeScaleToFill;
        //广告点击打开链接
        imageAdconfiguration.openURLString = model.openUrl;
        //广告显示完成动画
        imageAdconfiguration.showFinishAnimate =ShowFinishAnimateFadein;
        //跳过按钮类型
        imageAdconfiguration.skipButtonType = SkipTypeTimeText;
        //后台返回时,是否显示广告
        imageAdconfiguration.showEnterForeground = NO;
        
        //图片已缓存 - 显示一个 "已预载" 视图 (可选)
        if([XHLaunchAd checkImageInCacheWithURL:[NSURL URLWithString:model.content]])
        {
            //设置要添加的自定义视图(可选)
            imageAdconfiguration.subViews = [self launchAdSubViews_alreadyView];
            
        }
        //显示开屏广告
        [XHLaunchAd imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
        
    } failure:^(NSError *error) {
    }];
    
}

#pragma mark - subViews
-(NSArray<UIView *> *)launchAdSubViews_alreadyView
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-140, 30, 60, 30)];
    label.text  = @"已预载";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}
-(NSArray<UIView *> *)launchAdSubViews
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width-170, 30, 60, 30)];
    label.text  = @"subViews";
    label.font = [UIFont systemFontOfSize:12];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = 5.0;
    label.layer.masksToBounds = YES;
    label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    return [NSArray arrayWithObject:label];
    
}
#pragma mark - customSkipView
//自定义跳过按钮
-(UIView *)customSkipView
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor =[UIColor orangeColor];
    button.layer.cornerRadius = 5.0;
    button.layer.borderWidth = 1.5;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100,30, 85, 40);
    [button addTarget:self action:@selector(skipAction) forControlEvents:UIControlEventTouchUpInside];
    return button;
}
//跳过按钮点击事件
-(void)skipAction
{
    [XHLaunchAd skipAction];
}
#pragma mark - XHLaunchAd delegate - 倒计时回调
/**
 *  倒计时回调
 *
 *  @param launchAd XHLaunchAd
 *  @param duration 倒计时时间
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd customSkipView:(UIView *)customSkipView duration:(NSInteger)duration
{
    //设置自定义跳过按钮时间
    UIButton *button = (UIButton *)customSkipView;//此处转换为你之前的类型
    //设置时间
    [button setTitle:[NSString stringWithFormat:@"自定义%lds",duration] forState:UIControlStateNormal];
}
#pragma mark - XHLaunchAd delegate - 其他

/**
 *  广告点击事件 回调
 */
- (void)xhLaunchAd:(XHLaunchAd *)launchAd clickAndOpenURLString:(NSString *)openURLString;
{
    NSLog(@"广告点击");
    WebViewController *VC = [[WebViewController alloc] init];
    VC.URLString = openURLString;
    [VC setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    [self.window.rootViewController presentViewController:VC animated:YES completion:nil];
    
}
/**
 *  图片本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param image    image
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd imageDownLoadFinish:(UIImage *)image
{
    NSLog(@"图片下载完成/或本地图片读取完成回调");
}
/**
 *  视频本地读取/或下载完成回调
 *
 *  @param launchAd XHLaunchAd
 *  @param pathURL  视频保存在本地的path
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadFinish:(NSURL *)pathURL
{
    NSLog(@"video下载/加载完成/保存path = %@",pathURL.absoluteString);
}

/**
 *  视频下载进度回调
 */
-(void)xhLaunchAd:(XHLaunchAd *)launchAd videoDownLoadProgress:(float)progress total:(unsigned long long)total current:(unsigned long long)current
{
    NSLog(@"总大小=%lld,已下载大小=%lld,下载进度=%f",total,current,progress);
    
}
/**
 *  广告显示完成
 */
-(void)xhLaunchShowFinish:(XHLaunchAd *)launchAd
{
    NSLog(@"广告显示完成");
}


@end
