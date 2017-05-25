//
//  AppDelegate.m
//  SiRui
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRAppDelegate.h"
#import <Commons/FZKCHTTPDNSManager.h>
#import <Commons/FZKAppkeyComon.h>
#import <Connector/FZKBDomainConfig.h>
#import <Connector/FZKHttpWork.h>
#import "SRAppDelegate+XHLaunchAd.h"
#import "SRURLManager.h"
#import <Commons/FZKCMapManager.h>
#import <Connector/FZKBKeychain.h>
#import "SRCarScrollViewController.h"
#import "SRRounteUntils.h"
#import <Commons/FZKCRegisterCommonsAppkey.h>

@interface SRAppDelegate ()

@end

@implementation SRAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [FZKCHTTPDNSManager registerAliHTTPDNSCount:AliHTTPDNSCount  preResolveHosts:PreresolveHosts getIp:^(NSString *ip) {
        
    }];
    [[SMKAction sharedAction] configScheme:@"http" host:[SRURLManager shared].server4SPortal];
    
    UIColor *color=  [UIColor whiteColor];
    [[UINavigationBar appearance] setTintColor:color];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:color, NSForegroundColorAttributeName, nil]];
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"193a4f"]];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    [FZKCMapManager registerMapType:MapTypeAll];
    
//    [self setupXHLaunchAd];

        
//    }];
    
    
    
    if ([FZKBKeychain UserName]  && [FZKBKeychain Password] ) {
        


//        UIViewController * vc = [SRCarScrollViewController initVCWithStoryboardName:@"CarStoryboard"];
//        RTRootNavigationController *nav = [[RTRootNavigationController alloc] initWithRootViewController:vc];
        
    
        
        
        self.window.rootViewController =  [SRRounteUntils slideMainMenu];
    }else{
        
    }
    
    
     [FZKCShareManager registerShareSDKAppkey:ShareSDKAppkey];
    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
