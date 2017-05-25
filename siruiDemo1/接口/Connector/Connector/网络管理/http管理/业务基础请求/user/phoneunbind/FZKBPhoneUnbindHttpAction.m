
//
//  FZKBPhoneUnbindHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBPhoneUnbindHttpAction.h"


@implementation FZKBPhoneUnbindHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/customer/unbind",KBaseUrl];
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
 手机解绑
 
 传入参数：
conditionCode：相当于phoneID

返回参数：
resultCode：0表示成功
 */
- (void)phoneUnbindActionWithConditionCode:(NSString *)conditionCode
{
	[self addPara:@"conditionCode" withValue:conditionCode]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/customer/unbind";

    
}

@end
