//
//  SRCarStatueData.h
//  SiRui
//
//  Created by czl on 2017/4/21.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SRCarAblityButton.h"
#import <Connector/FZKBlockDefine.h>
#import <Connector/FZKTBluetoothInfoModel.h>

@interface SRCarStatueData : NSObject

SingleInterface(CarStatueData)



/**
 车辆状态值修改的时候发送通知给SRCarContolMainViewController 界面

 @param ability 能力code
 @param value 能力值
 */
+ (void)carStateChangeWithAbility:(SRTLVTag_Ability)ability value:(NSInteger)value;


/**
 预设值设置各种按钮状态图片

 @param btn 当前按钮
 */
+ (void)setAbilityBtnEachStateImagesWithAblityButton:(SRCarAblityButton *)btn;


/**
 刷新按钮状态值

 @param btn 按钮
 */
+ (void)refreshAbilityButton:(NSArray *)btns;



/**
 发送控制指令

 @param ability 能力
 @param value 能力值
 @param success 成功回调
 @param fail 失败回调
 */
+ (void)sendCarControlCode:(SRTLVTag_Ability) ability value:(NSInteger)value success:(ResultAction)success fail:(ResultAction)fail;


/**
 返回可以显示的车功能菜单

 @param allBtnArray 所有车功能按钮集合
 @return 可以显示的车功能菜单
 */
+ (NSArray *)abilityBtns:(NSArray<UIButton *> *) allBtnArray;


/**
 寻车功能
 */
+ (void)findCar;




@end
