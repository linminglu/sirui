
//
//  FZKBQueryCarSeriesAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryCarSeriesAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBQueryCarSeriesAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"entity":[{"seriesFirstLetter":"B","seriesID":1598,"seriesName":"B4 BITURBO","vehicleModelVOs":[{"vehicleModelID":25538,"vehicleName":"2016款 B4 BITURBO Coupe"}]}],"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 查询车辆系列集合（比如奥迪车集合）
 
 传入参数：
brandID：车辆品牌ID（相当于查询品牌接口中的 entityID）

返回参数：
seriesFirstLetter：首字符（排序用的）
seriesID：系列ID（如奥迪是一个系列）
seriesName：系列名字
vehicleModelVOs：车辆实例
vehicleModelID：车辆实例ID
vehicleName：车辆名字
resultCode：0表示成功

 */
+ (void)queryCarSeriesActionWithBrandID:(NSString * )brandID success:(Action1)success fail:(Action1)fail
{
    FZKBQueryCarSeriesAction *work =[[FZKBQueryCarSeriesAction alloc] init];
    

    [work queryCarSeriesActionWithBrandID:brandID];
    
//    [work addInterceptor:[SRInterceptorUtil buildLoading:@"正在查询" With:nil]];
//    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
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
