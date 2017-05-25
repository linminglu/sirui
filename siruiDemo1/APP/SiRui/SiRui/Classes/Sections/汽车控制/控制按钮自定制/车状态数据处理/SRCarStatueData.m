//
//  SRCarStatueData.m
//  SiRui
//
//  Created by czl on 2017/4/21.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRCarStatueData.h"
#import <Connector/FZKBVehicleStatusInfoModel.h>
#import <FZKNetWorking.h>
#import <Connector/FZKBKeychain.h>
#import <Business/UUID.h>
#import <Connector/FZKBLoginModel.h>
#import <AFNetworking.h>
#import <Business/FZKBPhoneControllAction.h>
#import <Connector/FZKCUserDefaults.h>
#import <Business/FZKBVehicleStatusAction.h>

/*
 typedef NS_ENUM(NSUInteger, SRTLVTag_Ability) {
 TLVTag_Ability_Lock         = 0x0501,     //关锁权限 1281
 TLVTag_Ability_Unlock       = 0x0502,     //开锁权限 1282
 TLVTag_Ability_EngineOn     = 0x0503,     //启动权限 1283
 TLVTag_Ability_EngineOff    = 0x0504,     //熄火权限 1284
 TLVTag_Ability_OilOn        = 0x0505,     //油路恢复权限 1285
 TLVTag_Ability_OilBreak     = 0x0506,     //油路关闭权限 1286
 TLVTag_Ability_Call         = 0x0507,     //寻车权限 1287
 TLVTag_Ability_Silence      = 0x0508,     //静音权限 1288
 TLVTag_Ability_WindowClose  = 0x0509,     //关窗权限 1289
 TLVTag_Ability_WindowOpen   = 0x050a,     //开窗权限 1290
 TLVTag_Ability_SkyClose     = 0x050b,     //关天窗权限 1291
 TLVTag_Ability_SkyOpen      = 0x050c,     //开天窗权限 1292
 
 TLVTag_Ability_Lock_SMS         = 0x0601,     //关锁权限 1537
 TLVTag_Ability_Unlock_SMS       = 0x0602,     //开锁权限 1538
 TLVTag_Ability_EngineOn_SMS     = 0x0603,     //启动权限 1539
 TLVTag_Ability_EngineOff_SMS    = 0x0604,     //熄火权限 1540
 TLVTag_Ability_OilOn_SMS        = 0x0605,     //油路恢复权限 1541
 TLVTag_Ability_OilBreak_SMS     = 0x0606,     //油路关闭权限 1542
 TLVTag_Ability_Call_SMS         = 0x0607,     //寻车权限 1543
 };
 
 */

@interface SRCarStatueData()



@end

@implementation SRCarStatueData

SingleImplementation(CarStatueData)


+ (void)carStateChangeWithAbility:(SRTLVTag_Ability)ability value:(NSInteger)value
{
    
    FZKBVehicleStatusInfoModel *model = [FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel];
    
    switch (ability) {
        case TLVTag_Ability_Unlock:
            model.doorLock = value;
            break;
        case TLVTag_Ability_EngineOn:
            model.engineStatus = value;
            break;
        case TLVTag_Ability_WindowOpen:
            /*
             windowLB: 左后窗 0：未知 1：开启   2：关闭
             windowLF: 左前窗0：未知 1：开启   2：关闭
             windowRB: 右后窗 0：未知 1：开启   2：关闭
             windowRF: 右前窗 0：未知 1：开启   2：关闭
             windowSky: 天窗 0：未知 1：开启   2：关闭
             */
            model.windowLB = value;
            model.windowLF = value;
            model.windowRB = value;
            model.windowRF = value;
            model.windowSky = value;
            break;
        case TLVTag_Ability_Call:
            //不做任何处理
            break;
            
        default:
            break;
    }
    [model archive];
    
    
}

+ (void)setAbilityBtnEachStateImagesWithAblityButton:(SRCarAblityButton *)btn
{
    
    switch (btn.tag) {
            
        case TLVTag_Ability_Unlock:
            [btn setCarAblityWithActiveImageName:@"jiesuo" shutImageName:@"suozhuantai" unknownImageName:@"suoweizhi"];
            break;
            
        case TLVTag_Ability_EngineOn:
            [btn setCarAblityWithActiveImageName:@"qidong" shutImageName:@"xihuo" unknownImageName:@"qidongweizhi"];
            break;
        case TLVTag_Ability_WindowOpen:
            [btn setCarAblityWithActiveImageName:@"jiangchuang" shutImageName:@"shengchuang" unknownImageName:@"windowsweizhi"];
            break;
            
            
        default:
            break;
    }
}

+ (void)refreshAbilityButton:(NSArray *)btns{
    
    FZKBVehicleStatusInfoModel *carInfo = [FZKBVehicleStatusInfoModel shareVehicleStatusInfoModel];
    for (SRCarAblityButton *btn in btns) {
        
        switch (btn.tag) {
            case TLVTag_Ability_Unlock:
                btn.carState = carInfo.doorLock;
                break;
            case TLVTag_Ability_EngineOn:
                btn.carState = carInfo.engineStatus;
                break;
            case TLVTag_Ability_WindowOpen:
                if(carInfo.windowLB==carInfo.windowLF==carInfo.windowRB==carInfo.windowRF==carInfo.windowSky){
                    btn.carState = carInfo.windowLB;
                }else if(carInfo.windowLB==1 || carInfo.windowLF==1 || carInfo.windowRB==1 || carInfo.windowRF==1 ||carInfo.windowSky==1){
                    btn.carState = 1;
                }else{
                    btn.carState = 2;
                }
                
                break;
            case TLVTag_Ability_Call:
                
                break;
                
            default:
                break;
        }
    }
    
    
    
}


+ (void)sendCarControlCode:(SRTLVTag_Ability) ability value:(NSInteger)value success:(ResultAction)success fail:(ResultAction)fail{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:kCarControlNotification object:@(1)];
    
    [SVProgressHUD setBackgroundColor:[UIColor clearColor]];
    
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];

    [SVProgressHUD showWithStatus:@"正在发送指令请稍等" maskType:SVProgressHUDMaskTypeNone];
    
    //服务数指令
    NSInteger series = [FZKCUserDefaults serialNumber];
    
    //控制指令
    NSInteger cmd= [self InstructionFromCode:value==2 CarControlCode:ability];
    
    FZKBPhoneControllAction *phone = [FZKBPhoneControllAction new];
    
    [phone phoneControllActionWithCarId:kCurrentCarModleId tag:cmd controlSeries:series success:^(id parameter) {
        
        [SVProgressHUD dismiss];
        success(nil);
        
    } fail:^(FZKActionResult *parameter) {
        
        [SVProgressHUD showErrorWithStatus:parameter.resultMessage];
        fail(nil);
    }];


    
}







+ (SRTLVTag_Instruction)InstructionFromCode:(BOOL)on CarControlCode:(SRTLVTag_Ability) ability
{
    
    
    SRTLVTag_Instruction code;
    
    if (on) {
        
        switch (ability) {
            case TLVTag_Ability_Unlock:
                code = TLVTag_Instruction_Lock;
                break;
                
            case TLVTag_Ability_EngineOn:
                code = TLVTag_Instruction_EngineOn;
                break;
                
            case TLVTag_Ability_Call:
                code = TLVTag_Instruction_Call;
                break;
                
            case TLVTag_Ability_WindowOpen:
                code = TLVTag_Instruction_SkyOpen;
                break;
                
            default:
                break;
        }
    }else{
        
        switch (ability) {
            case TLVTag_Ability_Unlock:
                code = TLVTag_Instruction_Unlock;
                break;
                
            case TLVTag_Ability_EngineOn:
                code = TLVTag_Instruction_EngineOff;
                break;
                
            case TLVTag_Ability_Call:
                code = TLVTag_Instruction_Call;
                break;
                
            case TLVTag_Ability_WindowOpen:
                code = TLVTag_Instruction_SkyClose;
                break;
            default:
                break;
        }
        
    }
    
    return code;
}

+ (NSArray *)abilityBtns:(NSArray<UIButton *> *) allBtnArray{
    
    //获取能力数组
    NSArray *abilityArray = [FZKBVehicleBasicInfoModel shareVehicleBasicInfoModel].abilities_v2;
    
    NSMutableArray *fifter = [NSMutableArray new];
    //添加过滤数组tags值
    for (FZKBAbilitiesModel  *model in abilityArray) {
        if ([model.value isEqualToString:@"1"] && model.tag>0) {
            [fifter addObject:@(model.tag)];
        }
        
    }
    
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"(SELF.tag IN %@)",fifter];
    
    NSArray *array = [allBtnArray filteredArrayUsingPredicate:pre];
    
    return array;
    
}

+ (void)findCar{
    
    [SRCarStatueData sendCarControlCode:TLVTag_Ability_Call value:1 success:^(FZKActionResult *result) {
        
    } fail:^(FZKActionResult *result) {
        
    }];
    
}





@end
