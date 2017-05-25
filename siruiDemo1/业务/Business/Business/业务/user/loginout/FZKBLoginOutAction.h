
//
//  FZKBLoginOutAction.h
//
//
//  Created by mac on date.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Connector/FZKBLoginOutHttpAction.h>

@interface FZKBLoginOutAction : FZKBLoginOutHttpAction
    
/**
 方法描述：
 登出（安全退出）
 
 返回参数
resultCode：0表示成功
 */
+ (void)loginOutActionSuccess:(Action1)success fail:(Action1)fail;

@end
