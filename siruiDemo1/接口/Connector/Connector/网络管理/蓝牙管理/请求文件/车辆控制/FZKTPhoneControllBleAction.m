//
//  FZKTPhoneControllBleAction.m
//  Connector
//
//  Created by czl on 2017/5/17.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKTPhoneControllBleAction.h"

@implementation FZKTPhoneControllBleAction


- (void)phoneControllActionWithtag:(NSInteger)tag{

    self.command = [self bleInstructionFromTLVInstruction:tag];
}

- (SRBLEInstruction)bleInstructionFromTLVInstruction:(SRTLVTag_Instruction)instruction{
    
    NSDictionary *dic = @{@(TLVTag_Instruction_Lock)        :   @(SRBLEInstruction_Lock),
                          @(TLVTag_Instruction_Unlock)      :   @(SRBLEInstruction_Unlock),
                          @(TLVTag_Instruction_EngineOn)    :   @(SRBLEInstruction_EngineOn),
                          @(TLVTag_Instruction_EngineOff)   :   @(SRBLEInstruction_EngineOff),
                          @(TLVTag_Instruction_OilOn)       :   @(SRBLEInstruction_OilOn),
                          @(TLVTag_Instruction_OilBreak)    :   @(SRBLEInstruction_OilBreak),
                          @(TLVTag_Instruction_Call)        :   @(SRBLEInstruction_Call),
                          @(TLVTag_Instruction_Silence)     :   @(SRBLEInstruction_Silence),
                          @(TLVTag_Instruction_WindowClose) :   @(SRBLEInstruction_WindowClose),
                          @(TLVTag_Instruction_WindowOpen)  :   @(SRBLEInstruction_WindowOpen),
                          @(TLVTag_Instruction_SkyClose)    :   @(SRBLEInstruction_SkyClose),
                          @(TLVTag_Instruction_SkyOpen)     :   @(SRBLEInstruction_SkyOpen),
                          @(TLVTag_Instruction_GPSWeak)     :   @(SRBLEInstruction_NULL),
                          @(TLVTag_Instruction_Defence)     :   @(SRBLEInstruction_NULL),
                          @(TLVTag_Instruction_Undefence)   :   @(SRBLEInstruction_NULL)
                          };
    return [dic[@(instruction)] integerValue];
}

@end
