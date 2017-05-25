
//
//  FZKBPhoneControllAction.h
//
//
//  Created by mac on date.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Connector/FZKBPhoneControllHttpAction.h>
#import <Connector/FZKTPhoneControllTCPAction.h>

@interface FZKBPhoneControllAction : FZKBPhoneControllHttpAction
    


/**
 方法描述：
 发送车控制指令给服务器
 
 传入参数:

 @param carId 车id
 @param tag 命令行
 @param pwd 用户密码
 @param success
 @param fail
 */
- (void)phoneControllActionWithCarId:(NSInteger)carId tag:(NSInteger)tag controlSeries:(NSInteger)controlSeries success:(Action1)success fail:(Action1)fail;



@end
