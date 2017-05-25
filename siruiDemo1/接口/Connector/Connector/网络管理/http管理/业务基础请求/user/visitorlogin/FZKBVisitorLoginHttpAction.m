
//
//  FZKBVisitorLoginHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBVisitorLoginHttpAction.h"


@implementation FZKBVisitorLoginHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/customer/phoneLogin",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"option":{"bindingStatus":0,"customerType":0,"endPoints":[{"endtype":"2","id":12,"ip":"phoneapp.mysirui.com","port":2300},{"endtype":"2","id":23,"ip":"phoneapp.mysirui.com","port":2300},{"context":"4sOnline","endtype":"4","id":304,"ip":"4sonline.mysirui.com","port":80},{"endtype":"5","id":305,"ip":"mqtt.mysirui.com","port":61613}],"updateVersion":"3.00","token":"CMjU3MTU=","department":{"address":"重庆市巴南区经济园区界石数码产业园一期12-13栋","assistPhone":"023-63063486","audiInterfaceSwitch":0,"brandID":2,"createTime":"2017-03-24 15:36:45","createUserID":0,"depID":0,"depPartAttr":{"annualFee":0.0,"depID":2,"isDirectSale":false,"isInstallationShop":false,"levelCode":"1/2","parentDirectSaleDepID":0},"depType":1,"entityID":2,"extendLevelCode":"1","extendOrderFlag":0,"extendOrderOpen":"1/2","extendOrderRule":"1/2","fDepPartAttr":{"annualFee":0.0,"depID":0,"isDirectSale":false,"isInstallationShop":false,"levelCode":"1","parentDirectSaleDepID":0},"fExtendLevelCode":"1","fExtendOrderOpen":"1","fExtendOrderRule":"1","fHas4sOnline":true,"fHasOrderOpen":false,"fLevelcode":"1","gwstock":0,"has4sOnline":true,"hasOrderOpen":false,"imgMathParam":0.9441301839300142,"isChild":false,"isContainsChild":0,"isCooperateMainten":false,"isSecond":true,"isSelf":false,"isTop":false,"isTopSystem":false,"lat":29.39617,"levelCode":"1/2","lng":106.621679,"name":"思锐","notifyDangerPhone":"023-63063486","otustock":0,"permissionsChZn":[],"querySub":true,"secondLevelCode":"1/2","serverPhone":"023-63063486","siruiOnlineName":"开启网络车生活","storeOtuStock":0,"storeWgStock":0,"topLevelCode":"1","topOrParentLevel":true,"updateTime":"2017-03-24 15:36:45","updateUserID":0,"userID":0,"view4SOnline":0,"viewOrder":0},"exhibitionExperienceTime":5,"needChangeUserName":false,"customerID":25715,"customer":{"ageFlag":false,"app":"sr","brandID":0,"cars":[{"balance":0.0,"barcode":"245973otumini","bindTime":"2016-12-26 09:35:30","brandID":2,"brandName":"奥迪","color":"银白色‘","confirmMaxAlarmID":0,"createTime":"2017-03-24 15:36:45","createUserID":0,"customerBinded":false,"customerBindedByInt":0,"customerID":25715,"customerName":"demo","customerPhone":"18523025151","customerSex":1,"customerSexString":"男","customerUserName":"demo","depID":0,"engineNumber":"k065197","entityID":25284,"from":0,"giftMaintenanceTimes":0,"groupID":0,"importExcelFlag":0,"isChild":false,"isContainsChild":0,"isOnline":0,"isSecond":false,"isSelf":false,"isTop":false,"isTopSystem":false,"lastMessageTime":0,"levelCode":"1/2","maintenCount":0,"maintenOrderCount":0,"mileAge":0.0,"msisdn":"1064826230001","needMainten":false,"nextBigMaintenMileage":60000,"nextMaintenMileage":3000.0,"oilSize":0.0,"plateNumber":"陕AZJR8188","preMaintenMileage":0,"querySub":true,"renewServiceEndTime":"2017-11-26 09:35:30","renewServiceStartTime":"2016-12-26 09:35:30","saleDate":"2010-06-01 00:00:00","saleDateStr":"2010-06-01","search_star":0,"secondLevelCode":"1/2","serialNumber":"966717024145973","seriesID":0,"serviceEndTime":"2019-12-26 00:00:00","star":5,"terminalID":58158,"terminal_status":0,"toCustomerFenceRedius":0,"topLevelCode":"1","topOrParentLevel":true,"updateTime":"2017-03-24 15:36:45","updateUserID":0,"vehicleID":25284,"vehicleModelID":40,"vehicleModelName":"2013款 Sportback 30 TFSI 舒适型","vin":"LZWADAGA4FD081645","wgs":[]},{"balance":0.0,"barcode":"OT5000000006","bindTime":"2017-03-23 17:38:01","brandID":23,"brandName":"大众","confirmMaxAlarmID":0,"createTime":"2017-03-24 15:36:45","createUserID":0,"customerBinded":false,"customerBindedByInt":0,"customerID":25715,"customerName":"demo","customerPhone":"18523025151","customerSex":1,"customerSexString":"男","customerUserName":"demo","depID":0,"entityID":28871,"from":0,"giftMaintenanceTimes":0,"groupID":0,"importExcelFlag":0,"isChild":false,"isContainsChild":0,"isOnline":0,"isSecond":false,"isSelf":false,"isTop":false,"isTopSystem":false,"lastMessageTime":0,"levelCode":"1/2","maintenCount":0,"maintenOrderCount":0,"mileAge":0.0,"msisdn":"15178709520","needMainten":false,"nextBigMaintenMileage":60000,"nextMaintenMileage":3000.0,"oilSize":0.0,"plateNumber":"车548922","preMaintenMileage":0,"querySub":true,"renewServiceEndTime":"2018-02-23 17:38:01","renewServiceStartTime":"2017-03-23 17:38:01","saleDate":"2017-03-23 17:38:01","saleDateStr":"2017-03-23","search_star":0,"secondLevelCode":"1/2","serialNumber":"864244022064686","seriesID":0,"serviceEndTime":"2020-03-23 00:00:00","star":5,"terminalID":4934,"terminal_status":0,"toCustomerFenceRedius":0,"topLevelCode":"1","topOrParentLevel":true,"updateTime":"2017-03-24 15:36:45","updateUserID":0,"vehicleID":28871,"vehicleModelID":1634,"vehicleModelName":"2012款 1.4TSI 手动两驱都会版","vin":"LSVAM4187C2184848","wgs":[]}],"createTime":"2017-03-24 15:36:45","createUserID":0,"customerBinded":false,"customerID":25715,"customerIDNumberType":0,"customerManagerID":0,"customerPassword":"123456","customerPhone":"18523025151","customerSex":1,"customerSexStr":"男","customerType":0,"customerUserName":"demo","depID":2,"depName":"思锐","entityID":25715,"exhibtionID":0,"isChild":false,"isContainsChild":0,"isFrozen":false,"isSecond":false,"isSelf":false,"isTop":false,"isTopSystem":false,"levelCode":"1/2","name":"demo","openHiddenTrip":false,"phoneID":"356e87cd-e4e8-495f-90dc-42b5777bf134","phoneType":2,"querySub":true,"realNameAuthentication":0,"secondLevelCode":"1/2","temporary":false,"topLevelCode":"1","topOrParentLevel":true,"updateTime":"2017-03-24 15:36:45","updateUserID":0,"vehicleModelID":0},"updateURL":"http://www.carsecretary.com/download/sirui308.apk","controlSeries":11,"needUpdate":true},"result":{"resultCode":0,"resultMessage":"登录成功"}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 游客登录
 
 传入参数
input1：用户名
input2：用户密码（两参数都需加密）
返回值
bindingStatus：账户绑定状态 0：未绑定 1：已绑定，且当前用户为绑定用户 2：已绑定，当前用户不是绑定用户
customerType：账户类型 0：正常用户 2：体验用户
endPoints：endPoints列表
updateVersion：APP最新版本号
token：APP登陆token，供4S在线接口使用
department：部门（4S店）信息
depPartAttr：部门属性
levelCode：部门层级
name：部门名称
address：地址
assistPhone：救援电话
createTime：登录时间
createUserID：登陆者id
depID：部门id
siruiOnlineName:4S在线广告语
lat:经度
lng：维度
notifyDangerPhone：客服电话
serverPhone：服务电话
customer：用户信息
customerID：用户id
customerName:用户账号
customerPhone：用户电话
customerSex：用户性别1：男 2：女
cars：车信息
brandID：经营品牌ID
brandName：品牌名
terminalID;//终端ID
plateNumber;//车牌号
vehicleModelName;//车辆类型名称
serviceEndTime:服务结束时间
needUpdate：是否需要更新true：是false：不需要
resultCode：结果码，0：成功，其它：失败
resultMessage：返回结果信息

 */
- (void)visitorLoginActionWithInput1:(NSString *)input1 input2:(NSString *)input2
{
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/customer/phoneLogin";

    
}

@end
