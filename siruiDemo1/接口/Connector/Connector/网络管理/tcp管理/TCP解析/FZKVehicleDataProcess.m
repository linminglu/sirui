//
//  FZKVehicleSynchronousResponse.m
//  Connector
//
//  Created by 宋搏 on 2017/5/3.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKVehicleDataProcess.h"
#import "FZKEnum.h"
#import "FZKTCPResponse.h"
#import <MJExtension/MJExtension.h>
#import "FZKTLV.h"
#import "FZKTCPResponseBody.h"
#import "FZKTCPClient.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "FZKTCPResponseHead.h"
#import "FZKTCPRspInvokeResult.h"
#import "FZKTCPRequest.h"
#import "FZKBVehicleStatusInfoModel.h"
#import "FZKCUserDefaults.h"
#import "FZKBVehicleBasicInfoModel.h"
#import "FZKEnum.h"
#import "FZKTCarStateManager.h"

@implementation FZKVehicleDataProcess



+(void)synchronous:(FZKTCPResponse *)response{
    
    [FZKTCarStateManager parseResponse:response type:SRCarStateParseTypeTCP];

}


@end
