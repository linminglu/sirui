
//
//  FZKBAccountComplaintHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBAccountComplaintHttpAction.h"


@implementation FZKBAccountComplaintHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@basic/examinePsw/add",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"option":{},"result":{"resultCode":0}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 账号申诉
 
 传入参数：
name：用户姓名
phone：用户手机号
email：用户邮箱
idNumber：身份证号
plateNumber：车牌号
vin：车架号
picUrl：（传入一张图片）

返回参数：
resultCode：0表示成功
 */
- (void)accountComplaintActionWithName:(NSString *)name phone:(NSString *)phone email:(NSString *)email idNumber:(NSString *)idNumber plateNumber:(NSString *)plateNumber vin:(NSString *)vin
{
	[self addPara:@"name" withValue:name]; 
	[self addPara:@"phone" withValue:phone]; 
	[self addPara:@"email" withValue:email]; 
	[self addPara:@"idNumber" withValue:idNumber]; 
	[self addPara:@"plateNumber" withValue:plateNumber]; 
	[self addPara:@"vin" withValue:vin]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"basic/examinePsw/add";

    
}

@end
