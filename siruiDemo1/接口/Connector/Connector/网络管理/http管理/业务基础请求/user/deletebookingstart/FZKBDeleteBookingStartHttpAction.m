
//
//  FZKBDeleteBookingStartHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBDeleteBookingStartHttpAction.h"


@implementation FZKBDeleteBookingStartHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/startClock/delete",KBaseUrl];
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
 删除预约启动
 
 传入参数：
startClockID：需要删除的闹钟的ID

返回参数：
resultCode：0表示成功
 */
- (void)deleteBookingStartActionWithStartClockID:(NSString *)startClockID
{
	[self addPara:@"startClockID" withValue:startClockID]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/startClock/delete";

    
}

@end
