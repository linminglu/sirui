//
//  SRCarAblityButton.m
//  SiRui
//
//  Created by czl on 2017/4/20.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRCarAblityButton.h"
#import "SRCarStatueData.h"

/*
 {
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
 }
 */

@implementation SRCarAblityButton
{

    UIImage   *_activeImage;
    UIImage   *_shutImage;
    UIImage   *_unknownImage;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [SRCarStatueData setAbilityBtnEachStateImagesWithAblityButton:self];
}


- (void)setCarAblityWithActiveImageName:(NSString *)activeImageName shutImageName:(NSString *)shutImageName unknownImageName:(NSString *)unknownImageName
{
    _activeImage = [UIImage imageNamed:activeImageName];
    _shutImage = [UIImage imageNamed:shutImageName];
    _unknownImage = [UIImage imageNamed:unknownImageName];
}


-(void)setCarState:(NSInteger)carState
{
    UIImage *im;
    switch (carState) {
        case 2:
            im = _activeImage;
            self.enabled = YES;
            break;
        case 1:
            im = _shutImage;
            self.enabled = YES;
            break;
        default:
            im = _unknownImage;
            self.enabled = NO;
            break;
    }
    [self setImage:im forState:UIControlStateNormal];
}


@end
