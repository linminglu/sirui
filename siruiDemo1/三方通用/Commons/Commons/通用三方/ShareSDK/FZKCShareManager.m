//
//  FZKCShareManager.m
//  Commons
//
//  Created by czl on 2017/3/28.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCShareManager.h"

#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDKUI.h>

//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <WeiboSDK.h>


//微信SDK头文件
#import "WXApi.h"
//#import <WXApi.h>

//新浪微博SDK头文件
//#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"
#import "FZKAppkeyComon.h"
//#import <SVProgressHUD.h>

@interface FZKCShareManager ()

@end

@implementation FZKCShareManager

+(void)registerShareSDKAppkey:(NSString *)appkey{

        if([ShareSDKQQAppkey stringValue].length==0 || [ShareSDKQQAppId stringValue].length==0 ){
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [SVProgressHUD showErrorWithStatus:@"请在FZKAppkeyComon.h 文件中配置shareSDK 相关appkey和AppSecret"];
                NSLog(@"请在FZKAppkeyComon.h 文件中配置shareSDK 相关appkey和AppSecret");
            });
    
            return;
        }
    
 
    
    
    [ShareSDK registerApp:appkey
     
          activePlatforms:@[
                            
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ),
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeMail),
                            @(SSDKPlatformTypeSMS),
                            @(SSDKPlatformTypeCopy),
                            
                            ]
     
     
     
     
     
                 onImport:^(SSDKPlatformType platformType) {
                     
                     switch (platformType)
                     {
                         case SSDKPlatformTypeWechat:
                             //                             [ShareSDKConnector connectWeChat:[WXApi class]];
                             [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
                             break;
                         case SSDKPlatformTypeQQ:
                                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                             break;
                         case SSDKPlatformTypeSinaWeibo:
                             [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                             break;
                             
                         default:
                             break;
                     }
                 }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
              
              switch (platformType)
              {
                      
                      
                  case SSDKPlatformTypeWechat:
                      [appInfo SSDKSetupWeChatByAppId:ShareSDKWebchatAppkey
                                            appSecret:ShareSDKWebchatAppSecret];
                      break;
                  case SSDKPlatformTypeQQ:
                      [appInfo SSDKSetupQQByAppId:ShareSDKQQAppId
                                           appKey:ShareSDKQQAppkey
                                         authType:SSDKAuthTypeBoth];
                      break;
                      
                  case SSDKPlatformTypeSinaWeibo:
                      //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                      [appInfo SSDKSetupSinaWeiboByAppKey:ShareSDKSinaAppkey
                                                appSecret:ShareSDKSinaAppSecret
                                              redirectUri:@"http://www.mysirui.com/app.html"
                                                 authType:SSDKAuthTypeBoth];
                      break;
                      
                  default:
                      break;
              }
          }];
    
    
    



    
}

+(void)shareSetupShareParamsByText:(NSString *)text
                            images:(id)images
                               url:(NSString *)url
                             title:(NSString *)title
{
    //    //1、构造分享内容
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params SSDKSetupShareParamsByText:text
                                images:images
                                   url:[NSURL URLWithString:url]
                                 title:title
                                  type:SSDKContentTypeAuto];
    [params SSDKEnableUseClientShare];
    
    //1.2、自定义分享平台（非必要）
    
    NSMutableArray *activePlatforms = [NSMutableArray arrayWithArray:
                                       @[
                                         @(SSDKPlatformSubTypeWechatSession ),
                                         @(SSDKPlatformSubTypeWechatTimeline ),
                                         @(SSDKPlatformSubTypeQQFriend ),
                                         @(SSDKPlatformSubTypeQZone ),
                                         @(SSDKPlatformTypeSinaWeibo),
                                         @(SSDKPlatformTypeMail),
                                         @(SSDKPlatformTypeSMS),
                                         
                                         ]
                                       ];
    
//    SSUIShareActionSheetCustomItem *item = [SSUIShareActionSheetCustomItem itemWithIcon:[UIImage imageNamed:@"copy"]
//                                                                                  label:@"复制"
//                                                                                onClick:^{
//                                                                                    
//                                                                                    
//                                                                                    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//                                                                                    pasteboard.string = @"ddd";
//                                                                                    
//                                                                                    
//                                                                                    if (pasteboard.string) {
//                                                                                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"复制成功"
//                                                                                                                                        message:nil
//                                                                                                                                       delegate:nil
//                                                                                                                              cancelButtonTitle:@"确定"
//                                                                                                                              otherButtonTitles:nil, nil];
//                                                                                        [alert show];
//                                                                                    }
//                                                                                    
//                                                                                    
//                                                                                    NSLog(@"=== 自定义item点击 === %@", pasteboard.string);
//                                                                                    
//                                                                                }];
//    [activePlatforms addObject:item];
    
    
    
    //1.3、自定义分享菜单栏（非必要）
    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
    [SSUIShareActionSheetStyle setActionSheetColor:[UIColor whiteColor]];
    
    
    
    
    
    //2、弹出分享菜单栏
    //    SSUIShareActionSheetController *actionSheet =
    [ShareSDK showShareActionSheet:nil
                             items:activePlatforms
     
     
     
                       shareParams:params
               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                   
                   switch (state)
                   {
                       case SSDKResponseStateSuccess:
                       {
                           NSLog(@"分享成功");
                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                           message:nil
                                                                          delegate:nil
                                                                 cancelButtonTitle:@"确定"
                                                                 otherButtonTitles:nil, nil];
                           [alert show];
                       }
                           break;
                       case SSDKResponseStateFail:
                       {
                           if (platformType == SSDKPlatformTypeSMS && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、短信应用没有设置帐号；2、设备不支持短信应用；3、短信应用在iOS 7以上才能发送带附件的短信；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                           }
                           else if(platformType == SSDKPlatformTypeMail && [error code] == 201)
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:@"失败原因可能是：1、邮件应用没有设置帐号；2、设备不支持邮件应用；"
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                           }
                           else
                           {
                               NSLog(@"分享失败");
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"确定"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                           }
                       }
//                       case SSDKResponseStateCancel:
//                       {
//                           NSLog(@"取消");
//                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享取消"
//                                                                           message:nil
//                                                                          delegate:nil
//                                                                 cancelButtonTitle:@"确定"
//                                                                 otherButtonTitles:nil, nil];
//                           [alert show];
//                       }
                           
                       default:
                           break;
                   }
               }];
    
    

    
    
    
}

@end
