
//
//  FZKBGetCarInfoAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBGetCarInfoAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"
#import <Connector/FZKBVehicleBasicInfoModel.h>
#import <MJExtension.h>
#import <Connector/FZKBKeychain.h>

//#import <Connector/FZKEnum.h>

@implementation FZKBGetCarInfoAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    NSArray *array = result.paramters[@"entity"];
    if (array.count>0) {
        
        //       判断是否返回车辆功能，返回就保存
   
        NSDictionary *dic = array[0];
        FZKBVehicleBasicInfoModel *model2 = [FZKBVehicleBasicInfoModel mj_objectWithKeyValues:dic];
        [model2 archive];
        
        //保存当前车辆id
        [[NSUserDefaults standardUserDefaults] setObject:@(model2.vehicleID) forKey:@"kSelectCarId"];
        [[NSUserDefaults standardUserDefaults]synchronize];
//        kSaveCurrentCarModleId@(model2.vehicleID);
   
        
        
    }
    else{
        //清空保存数据
        FZKBVehicleBasicInfoModel *model2 = [FZKBVehicleBasicInfoModel new];
        [model2 archive];
        
    }
    
    
    
}


/*
 ------------------jsonData----
 {"entity":[{"abilities":[{"tag":1286,"value":"1"},{"tag":1285,"value":"1"},{"tag":1282,"value":"2"},{"tag":1283,"value":"2"},{"tag":1281,"value":"2"},{"tag":1287,"value":"2"},{"tag":1284,"value":"2"}],"abilities_v2":[{"tag":1286,"value":"1"},{"tag":1285,"value":"1"},{"tag":1282,"value":"2"},{"tag":1283,"value":"2"},{"tag":1281,"value":"2"},{"tag":1287,"value":"2"},{"tag":1284,"value":"2"}],"balance":0,"barcode":"OR899070015112641","brandID":10,"brandName":"奔驰","controlBt":0,"controlSms":1,"customerID":28719,"customerName":"老大","customerPhone":"18883286600","customized":"ost","fenceCentralLat":2.585652,"fenceCentralLng":3.5854,"fenceRadius":500,"goHomeTime":"17:50","gotBalance":false,"gotoV3":false,"has4SModule":true,"hasControlModule":false,"hasOBDModule":true,"insuranceSaleDate":"2017-03-23 09:06:51","insuranceSaleDateStr":"2017-03-23","insuranceSaleDateStrStr":"2017-03-23","isInFence":0,"isPreciseFuelCons":false,"maxStartTimeLength":15,"nextMaintenMileage":3000,"openObd":1,"plateNumber":"车MC0598","preMaintenMileage":0,"product":"yj","renewServiceEndTime":"2018-02-23 09:06:51","renewServiceStartTime":"2017-03-23 09:06:51","saleDate":"2017-03-23 09:06:51","saleDateStr":"2017-03-23","serialNumber":"899070015112641","terminalID":72254,"tripHidden":0,"vehicleID":28602,"vehicleModelID":516,"vehicleModelName":"2012款 CLS63 AMG","whetherExpire":false,"workTime":"07:30"}],"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 查询车辆信息
 
 传入参数：
 input1：用户名（加密）
 input2：密码（加密）
 vehicleID：车辆id
 返回参数：
 balance :终端余额
 barcode :终端主机编码
 brandID :品牌ID
 brandName :品牌名称
 controlBt : 0表示没有
 controlSms : 通过sms控制 0表示没有
 customerID : 用户ID
 customerName :用户名
 customerPhone :用户手机号
 customized :车辆标志audi：奥迪null：普通
 fenceCentralLat :  围栏中心点经度
 fenceCentralLng : 围栏中心点纬度
 fenceRadius : 围栏半径
 goHomeTime :  回家时间
 gotBalance : 是否已经有了余额
 gotoV3 : 是否需要连接到新的网关平台
 has4SModule : 没用到
 hasControlModule : 是否有控制权限（功能）
 hasOBDModule :是否有诊断功能
 insuranceSaleDate : 保险购买时间
 insuranceSaleDateStr :保单购买时间无用
 insuranceSaleDateStrStr :没用
 isInFence : 是否在围栏内2表示不在围栏内，其他表示在围栏内
 isPreciseFuelCons : 没用到
 maxStartTimeLength :预约启动时长有用的
 nextMaintenMileage : 下次维修里程
 openObd :OBD检测状态1：开启2：关闭
 plateNumber : 车牌号
 preMaintenMileage : 上次维修里程
 product : 产品类型空表示思锐，yj表示云警
 renewServiceEndTime :续费服务到期时间无用
 renewServiceStartTime :续费服务开始时间无用
 saleDate : 购车时间
 saleDateStr :购买车时间
 serialNumber :终端IMEI
 terminalID :终端ID
 tripHidden :当前车辆是否隐藏轨迹0表示隐藏，1表示不隐藏
 vehicleID : 车辆id
 vehicleModelID : 车辆类型ID
 vehicleModelName : 车辆类型名称
 whetherExpire : 是否到期
 workTime : 无用
 */
+ (void)getCarInfoActionWithVehicleID:(NSInteger)vehicleID success:(Action1)success fail:(Action1)fail
{
    FZKBGetCarInfoAction *work =[[FZKBGetCarInfoAction alloc] init];
    
    [work getCarInfoActionWithInput1:[FZKBKeychain UserName] input2:[FZKBKeychain Password] vehicleID:vehicleID>0?@(vehicleID).stringValue:nil];
    
//    [work addInterceptor:[SRInterceptorUtil buildLoading:@"正在查询车辆功能........" With:nil]];
//    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
    [work onSuncc:^(FZKActionResult *result) {
        
        success(result.paramters);
        
    }];
    
    [work onError:^(FZKActionResult *result) {
        
//        fail(result.resultMessage);
        [SVProgressHUD showErrorWithStatus:result.resultMessage];
        
        
    }];
    
    [work run];
    
}



@end
