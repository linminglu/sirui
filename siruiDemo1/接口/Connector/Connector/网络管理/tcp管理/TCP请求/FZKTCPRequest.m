//
//  SRTCPRequest.m
//  SiRuiV4.0
//
//  Created by zhangjunbo on 15/6/16.
//  Copyright (c) 2015年 SiRui. All rights reserved.
//

#import "FZKTCPRequest.h"
#import <MJExtension/MJExtension.h>

#import "FZKTCPReqLoginBody.h"
#import "FZKTCPReqInstructionBody.h"
#import "FZKTCPRequestHead.h"
#import "FZKCUserDefaults.h"
#import "FZKTCPResponseBody.h"
#import "FZKEnum.h"
#import "FZKBKeychain.h"

@implementation FZKTCPRequest

+ (FZKTCPRequest *)AddressingRequestWithUserName:(NSString *)userName {
    
    

    
    
    FZKTCPReqLoginBody *loginBody = [[FZKTCPReqLoginBody alloc] init];
    loginBody.userName = userName;
    
    FZKTCPRequest *request = [[FZKTCPRequest alloc] init];
    request.head = [[FZKTCPRequestHead alloc] initWithDirect:TCPDirect_Request
                                                     funcID:TCPFuncID_Addressing
                                            andSerialNumber:[FZKCUserDefaults serialNumber]];
    request.body = loginBody.mj_keyValues;
    
    return request;
}

+ (FZKTCPRequest *)LoginRequestWithUserName:(NSString *)userName andPassword:(NSString *)password {
    
    

    
    FZKTCPReqLoginBody *loginBody = [[FZKTCPReqLoginBody alloc] init];
    loginBody.userName = userName;
    loginBody.password = password;
    
    FZKTCPRequest *request = [[FZKTCPRequest alloc] init];
    request.head = [[FZKTCPRequestHead alloc] initWithDirect:TCPDirect_Request
                                                     funcID:TCPFuncID_Login
                                            andSerialNumber:[FZKCUserDefaults serialNumber]];
    request.body = loginBody.mj_keyValues;
    
    return request;
}

+ (FZKTCPRequest *)InstructionRequestWithCmdID:(NSInteger)instructionID
                                controlSeries:(NSInteger)controlSeries
                                 andVehicleID:(NSInteger)vehicleID {
    FZKTCPReqInstructionBody *instructionBody = [[FZKTCPReqInstructionBody alloc] init];
    instructionBody.instructionID = instructionID;
    instructionBody.vehicleID = vehicleID;
    
    FZKTCPRequest *request = [[FZKTCPRequest alloc] init];
    request.head = [[FZKTCPRequestHead alloc] initWithDirect:TCPDirect_Request
                                                     funcID:TCPFuncID_Instruction
                                            andSerialNumber:controlSeries];
    request.body = instructionBody.mj_keyValues;
    
    return request;
}

+ (FZKTCPRequest *)AckWithDirect:(NSInteger)direction
                         funcID:(NSInteger)functionID
                andSerialNumber:(NSInteger)serialNumber {
    FZKTCPRequest *request = [[FZKTCPRequest alloc] init];
    request.head = [[FZKTCPRequestHead alloc] initWithDirect:direction funcID:functionID andSerialNumber:serialNumber];
    
    return request;
}


//蓝牙调试
+ (FZKTCPRequest *)bleStatusWithVehicleID:(NSInteger)vehicleID
                             isConnected:(BOOL)isConnected
{
    FZKTCPRequest *request = [[FZKTCPRequest alloc] init];
    request.head = [[FZKTCPRequestHead alloc] initWithDirect:TCPDirect_OneWay funcID:TCPFuncID_Synchronous andSerialNumber:[FZKCUserDefaults serialNumber]];
    
    FZKTLV *tlv = [[FZKTLV alloc] init];
    tlv.tag = SRTLVTag_Debugging_BleStatus;
    tlv.value = [NSString stringWithFormat:@"%@_%@", @(vehicleID), @(isConnected)];
    
    FZKTCPResponseBody *body = [[FZKTCPResponseBody alloc] init];
    body.clientType = 4;
    body.entityID = [FZKCUserDefaults currentVehicleID];
    body.parameters = @[tlv];
    
    request.body = body.keyValues;
    
    return request;
}

+ (FZKTCPRequest *)bleDebuggingWithVehicleID:(NSInteger)vehicleID
                                  logString:(NSString *)logString
{
    FZKTCPRequest *request = [[FZKTCPRequest alloc] init];
    request.head = [[FZKTCPRequestHead alloc] initWithDirect:TCPDirect_OneWay funcID:TCPFuncID_BleDebugging andSerialNumber:[FZKCUserDefaults serialNumber]];
    
    FZKTLV *tlv = [[FZKTLV alloc] init];
    tlv.tag = SRTLVTag_Debugging_TerminalToServer;
    tlv.value = [NSString stringWithFormat:@"%@", logString];
    
    FZKTCPResponseBody *body = [[FZKTCPResponseBody alloc] init];
    body.clientType = 4;
    body.entityID = [FZKCUserDefaults currentVehicleID];
    body.parameters = @[tlv];
    
    request.body = body.keyValues;
    
    return request;
}



- (instancetype)init {
    self = [super init];
    if (self) {
        _head = [[FZKTCPRequestHead alloc] init];
    }
    
    return self;
}

- (NSData *)dataValue {
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.mj_keyValues options:kNilOptions error:nil];
    NSString *preString = [NSString stringWithFormat:@"%04zd%02zd%02zd", jsonData.length, self.head.direction, self.head.functionID];
    NSMutableData *reusltData = [NSMutableData data];
    [reusltData appendData:[preString dataUsingEncoding:NSUTF8StringEncoding]];
    [reusltData appendData:jsonData];
    
    NSLog(@"TCP Request: %@", [[NSString alloc] initWithData:reusltData encoding:NSUTF8StringEncoding]);
    
    return reusltData;
}


@end
