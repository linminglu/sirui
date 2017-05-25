
//
//  FZKBGetAuthCodeRegisterAction.h
//
//
//  Created by mac on date.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Connector/FZKBGetAuthCodeRegisterHttpAction.h>

@interface FZKBGetAuthCodeRegisterAction : FZKBGetAuthCodeRegisterHttpAction
    
/**
 方法描述：
 注册获取验证码
 
 传入参数
phone：手机号
返回值
authCode：验证码
resultCode：返回结果码，0：成功，其它：失败
resultMessage：返回结果信息
 */
+  (void)getAuthCodeRegisterActionWithPhone:(NSString *)phone fromRegist:(NSString *)fromRegist  type:(NSString *)type success:(Action1)success fail:(Action1)fail;

@end
