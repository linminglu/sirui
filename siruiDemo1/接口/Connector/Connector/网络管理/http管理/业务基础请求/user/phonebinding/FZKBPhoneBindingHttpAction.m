
//
//  FZKBPhoneBindingHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBPhoneBindingHttpAction.h"


@implementation FZKBPhoneBindingHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/customer/binding",KBaseUrl];
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
 绑定手机
 
 传入参数：
conditionCode：相当于phoneID
返回参数：
resultCode：0表示成功
 */
- (void)phoneBindingActionWithConditionCode:(NSString *)conditionCode
{
	[self addPara:@"conditionCode" withValue:conditionCode]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/customer/binding";

    
}

@end
