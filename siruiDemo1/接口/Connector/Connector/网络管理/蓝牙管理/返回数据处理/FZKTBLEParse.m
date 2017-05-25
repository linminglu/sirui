//
//  FZKTBLEParse.m
//  Connector
//
//  Created by czl on 2017/5/15.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKTBLEParse.h"
#import "FZKBVehicleStatusInfoModel.h"
#import "SRBLEVehicleStatus.h"
#import "FZKEnum.h"
#import "FZKTCarStateManager.h"

@implementation FZKTBLEParse

+(void)BLEReceivedData:(NSData *)response{

    [FZKTCarStateManager parseResponse:[[SRBLEReceivedData alloc ]initWithData:response] type:SRCarStateParseTypeBLE];
    
//    [self receiveData:response];
    

}

+(void)receiveData:(NSData *)response
{
    NSLog(@"收到数据了");
//    NSData *data = response
    //收到数据, 设置推送
    UILocalNotification *noti = [[UILocalNotification alloc] init];
    if (noti)
    {
        //设置时区
        noti.timeZone = [NSTimeZone defaultTimeZone];
        //设置重复间隔
        noti.repeatInterval = NSWeekCalendarUnit;
        //推送声音
        noti.soundName = UILocalNotificationDefaultSoundName;
        //内容
        noti.alertBody = @"接收到数据了";
        noti.alertAction = @"打开";
        //显示在icon上的红色圈中的数子
        noti.applicationIconBadgeNumber = 1;
        //设置userinfo 方便在之后需要撤销的时候使用
        NSDictionary *infoDic = [NSDictionary dictionaryWithObject:response forKey:@"key"];
        noti.userInfo = infoDic;
        //添加推送到uiapplication
        UIApplication *app = [UIApplication sharedApplication];
        [app scheduleLocalNotification:noti];
    }
}
@end
