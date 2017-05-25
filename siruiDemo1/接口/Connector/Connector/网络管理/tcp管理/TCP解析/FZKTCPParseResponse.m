//
//  SRTCPParseResponse.m
//  TCP
//
//  Created by 宋搏 on 2017/5/2.
//  Copyright © 2017年 Fuizk. All rights reserved.
//

#import "FZKTCPParseResponse.h"
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
#import "FZKVehicleDataProcess.h"

@implementation FZKTCPParseResponse



#pragma mark - 数据解析



+ (void)parseResponseWithResponse:(FZKTCPResponse *)respon{
    
    NSInteger direct = respon.head.direction;
    NSInteger funcID = respon.head.functionID;
    
    if (direct == TCPDirect_Response && funcID == TCPFuncID_Login) {
        [self parseLoginResponse:respon];
    } else if (direct == TCPDirect_OneWay && funcID == TCPFuncID_Synchronous) {
        [self parseSynchronousResponse:respon];
    } else if (direct == TCPDirect_Response && funcID == TCPFuncID_Instruction) {
        [self parseInstructionResponse:respon];
    } else if (direct == TCPDirect_Response && funcID == TCPFuncID_Addressing) {
        [self parseAddresingResponse:respon];
    } else if (direct == TCPDirect_OneWay && funcID == TCPFuncID_BleDebugging) {
        [self parseBleDebuggingData:respon];
    }
    
}

+ (void)parseAddresingResponse:(FZKTCPResponse *)response {
    
//    [FZKTCPClient sharedInterface].isRedirected = NO;
//    [FZKTCPClient sharedInterface].isTCPLogin = NO;
    FZKTLV *tlv;
    if (response.body.parameters.count) {
        tlv = response.body.parameters[0];
        //    for (FZKTLV *tlv in [FZKTLV mj_objectArrayWithKeyValuesArray:response.body.parameters]) {
        [FZKTCPClient shareTCPClient].port = tlv.tag;
        [FZKTCPClient shareTCPClient].host = tlv.value;
        //    }
        
        NSLog(@"TCP寻址成功");
        [FZKTCPClient shareTCPClient].isRedirected = YES;
    }
    

    
    //    [self executeOnMain:^{
    CompleteBlock completeBlock = (CompleteBlock)[[FZKTCPClient shareTCPClient].completeBlockDic objectForKey:@(response.head.serialNumber)];
    if (completeBlock) {
        
        completeBlock(nil, response.head);
        [[FZKTCPClient shareTCPClient].completeBlockDic removeObjectForKey:@(response.head.serialNumber)];
        completeBlock = nil;
    }
    //    } afterDelay:0];
}


+ (void)parseLoginResponse:(FZKTCPResponse *)response {
    
//    [FZKTCPClient sharedInterface].isTCPLogin = NO;
    
    NSError *error = nil;
//    NSDictionary *jsonObject=[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&error];
//    if (error) {
//        NSLog(@"%@", error);
//        NSLog(@"%@", [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding]);
//        [[FZKTCPClient sharedInterface] tcpLogin];
//        return;
//    }
    
//    FZKTCPResponse *response = [FZKTCPResponse mj_objectWithKeyValues:jsonObject];
    
    if (!response||response.head.invokeResult.resultCode != SRHTTP_Success) {
        NSLog(@"TCP登陆失败：%@", response.head.invokeResult.errorMessage);
        [FZKTCPClient shareTCPClient].isTCPLogin = NO;
        error = [NSError errorWithDomain:response.head.invokeResult.errorMessage
                                    code:response.head.invokeResult.resultCode userInfo:nil];
    } else {
        NSLog(@"TCP登陆成功");
        [FZKTCPClient shareTCPClient].isTCPLogin = YES;
    }
    
    
//    [self executeOnMain:^{
        CompleteBlock completeBlock = (CompleteBlock)[[FZKTCPClient shareTCPClient].completeBlockDic objectForKey:@(response.head.serialNumber)];
        if (completeBlock) {
            completeBlock(error, response.head);
            [[FZKTCPClient shareTCPClient].completeBlockDic removeObjectForKey:@(response.head.serialNumber)];
            completeBlock = nil;
        }
//    } afterDelay:0];
}



+ (void)parseInstructionResponse:(FZKTCPResponse *)response {
    
    NSError *error = nil;
    
    if (!response || response.head.invokeResult.resultCode != SRHTTP_Success) {
        if (!response.head.invokeResult.errorMessage
            ||  response.head.invokeResult.errorMessage.length <= 0 ) {
            response.head.invokeResult.errorMessage = @"指令执行失败，请稍候再试";
        }
        NSLog(@"TCP指令执行失败：%zd %@", response.head.invokeResult.resultCode, response.head.invokeResult.errorMessage);
        
        error = [NSError errorWithDomain:response.head.invokeResult.errorMessage code:0 userInfo:nil];
    }
    
//    [self executeOnMain:^{
        CompleteBlock completeBlock = (CompleteBlock)[[FZKTCPClient shareTCPClient].completeBlockDic objectForKey:@(response.head.serialNumber)];
        if (completeBlock) {
            completeBlock(error, response.head);
            [[FZKTCPClient shareTCPClient].completeBlockDic removeObjectForKey:@(response.head.serialNumber)];
            completeBlock = nil;
        }
//    } afterDelay:0];
}

+ (void)parseSynchronousResponse:(FZKTCPResponse *)response {
    
    NSError *error = nil;
    
    if (response.head.serialNumber <= [FZKTCPClient shareTCPClient].latestSynchronousResponseSerialNumber) {
        NSLog(@"无效流水号，消息丢弃！当前推送流水号：%zd 本地最新流水号：%zd", response.head.serialNumber, [FZKTCPClient shareTCPClient].latestSynchronousResponseSerialNumber);
        return;
    }
    
    [FZKTCPClient shareTCPClient].latestSynchronousResponseSerialNumber = response.head.serialNumber;
    
    //回复服务器
    FZKTCPRequest *ack = [FZKTCPRequest AckWithDirect:TCPDirect_OneWay_Ack
                                               funcID:response.head.functionID
                                      andSerialNumber:response.head.serialNumber];
    [[FZKTCPClient shareTCPClient] sendTCPRequest:ack withCompleteBlock:nil];
    
    
    
    NSInteger vehicleId = response.body.entityID;
    
    if (vehicleId != [FZKCUserDefaults currentVehicleID]) {
        return;
    }
    
    
    
    [FZKVehicleDataProcess synchronous:response];
    
    
}



+ (void)parseBleDebuggingData:(FZKTCPResponse *)debuggingData {
//    NSError *error = nil;
//    NSDictionary *jsonObject=[NSJSONSerialization JSONObjectWithData:debuggingData options:NSJSONReadingMutableLeaves error:&error];
//    if (error) {
//        NSLog(@"%@", error);
//        NSLog(@"%@", [[NSString alloc] initWithData:debuggingData encoding:NSUTF8StringEncoding]);
//        return;
//    }
    
    //    FZKTCPResponse *debugging = [FZKTCPResponse objectWithKeyValues:jsonObject];
    
    
    
}

+ (void)executeOnMain:(dispatch_block_t)block afterDelay:(int64_t)delta {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta),
                   dispatch_get_main_queue(),
                   block);
}






@end
