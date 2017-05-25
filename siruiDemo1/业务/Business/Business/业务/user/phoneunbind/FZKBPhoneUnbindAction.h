
//
//  FZKBPhoneUnbindAction.h
//
//
//  Created by mac on date.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Connector/FZKBPhoneUnbindHttpAction.h>

@interface FZKBPhoneUnbindAction : FZKBPhoneUnbindHttpAction
    
/**
 方法描述：
 手机解绑
 
 传入参数：
conditionCode：相当于phoneID

返回参数：
resultCode：0表示成功
 */
+ (void)phoneUnbindActionWithConditionCode:(NSString *)conditionCode success:(Action1)success fail:(Action1)fail;

@end