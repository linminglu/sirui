
//
//  FZKBQueryXuFeiServiceAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryXuFeiServiceAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBQueryXuFeiServiceAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"entity":{"vehicleXuFeis":[{"annualFee":99.0,"endDays":"2017-06-14","endYearMon":"2017-06","isWulianCard":1,"plateNumber":"渝225","surplusMonth":4,"vehicleID":17482},{"annualFee":99.0,"endDays":"2017-06-19","endYearMon":"2017-06","isWulianCard":0,"plateNumber":"车NH6167","surplusMonth":0,"vehicleID":17670}]},"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 续费查询（查询用户车辆是否欠费等）
 
 传入参数：

返回参数：
annualFee：一年需要费用
endDays：到期日期
endYearMon：到期年月（显示用的）
isWulianCard：1表示是物联卡，0表示不是物联卡
plateNumber：车牌号
surplusMonth：剩余月数（用来判断是否需要续费的标准）
vehicleID：车辆ID
resultCode：0表示成功

 */
+ (void)queryXuFeiServiceActionSuccess:(Action1)success fail:(Action1)fail
{
    FZKBQueryXuFeiServiceAction *work =[[FZKBQueryXuFeiServiceAction alloc] init];
    

    [work queryXuFeiServiceAction];
    
    [work addInterceptor:[SRInterceptorUtil buildLoading:@"这里填写自己的........" With:nil]];
    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
    [work onSuncc:^(FZKActionResult *result) {

        success(result.paramters);
        
    }];
    
    [work onError:^(FZKActionResult *result) {

        fail(result.resultMessage);
        [SVProgressHUD showErrorWithStatus:result.resultMessage];
        
        
    }];
    
    [work run];
    
}



@end
