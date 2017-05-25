
//
//  FZKBValidateImeiHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBValidateImeiHttpAction.h"


@implementation FZKBValidateImeiHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/terminal/validateIMEI",KBaseUrl];
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
 用户注册验证imei号
 
 传入参数
imei：设备唯一识别码
version：APP版本号
返回值
resultCode：结果码,0表示验证成功，其它表示获取失败

 */
- (void)validateImeiActionWithImei:(NSString *)imei version:(NSString *)version
{
	[self addPara:@"imei" withValue:imei]; 
	[self addPara:@"version" withValue:version]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/terminal/validateIMEI";

    
}

@end
