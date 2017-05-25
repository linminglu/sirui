
//
//  FZKBPhoneBindingAction.h
//
//
//  Created by mac on date.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Connector/FZKBPhoneBindingHttpAction.h>

@interface FZKBPhoneBindingAction : FZKBPhoneBindingHttpAction
    
/**
 方法描述：
 绑定手机
 
 传入参数：
conditionCode：相当于phoneID
返回参数：
resultCode：0表示成功
 */
+ (void)phoneBindingActionWithConditionCode:(NSString *)conditionCode success:(Action1)success fail:(Action1)fail;

@end