//
//  SRPublicMethod.h
//  SiRui
//
//  Created by czl on 2017/4/13.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRPublicMethod : NSObject


/**
 是否有使用摄像头的权限

 */
+ (BOOL)isCanUerCamer;


/**
 播放音效

 @param fileName 音效名
 */
+ (void)playMusicWithName:(NSString *)fileName;


+ (NSString *)urlEnCode:(NSString *)url;


/**
 
 退出登录清除数据

 */
+ (void)logoutClearData;

@end
