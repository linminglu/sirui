//
//  UserConfig.h
//  SiRui
//
//  Created by czl on 2017/4/17.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#ifndef UserConfig_h
#define UserConfig_h

/*
 保存登录成功后的账户与密码，用于使用plist文件
 */
static  NSString const *kUserNameRSA = @"kUserNameRSA";

static  NSString const *kUserPwdRSA = @"kUserPwdRSA";




//汽车状态改变指令
static  NSString const *kCarStateChangelNotification = @"kCarStateChangelNotification";

//汽车坐标修改指令
static  NSString const *kCarCoorDinateChangelNotification = @"kCarCoorDinateChangelNotification";







#endif /* UserConfig_h */
