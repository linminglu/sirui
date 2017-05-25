//
//  FZKBQueryTripGpsPointsAction.m
//  Business
//
//  Created by 宋搏 on 2017/5/4.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryTripGpsPointsAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"
#import <Connector/FZKCUserDefaults.h>
#import <Connector/FZKBKeychain.h>

@implementation FZKBQueryTripGpsPointsAction

+ (void)queryTripGpsPointsActionWithTripID:(NSString *)tripID success:(Action1)success fail:(Action1)fail{


    

    FZKBQueryTripGpsPointsAction *work =[[FZKBQueryTripGpsPointsAction alloc] init];
    
    
    
    
    
    [work queryTripListActionWithTripID:tripID input1:[FZKBKeychain UserName] input2:[FZKBKeychain Password] pageIndex:@"1" pageSize:@"3000" ];
    
    //    [work addInterceptor:[SRInterceptorUtil buildLoading:@"这里填写自己的........" With:nil]];
    //    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
    [work onSuncc:^(FZKActionResult *result) {
        
        success( [[result.paramters objectForKey:@"pageResult"] objectForKey:@"entityList"]);
        
    }];
    
    [work onError:^(FZKActionResult *result) {
        
        fail(result.resultMessage);
        [SVProgressHUD showErrorWithStatus:result.resultMessage];
        
        
    }];
    
    [work run];
    
    
  

}

@end
