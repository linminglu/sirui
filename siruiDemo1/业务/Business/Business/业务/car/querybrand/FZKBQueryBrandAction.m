
//
//  FZKBQueryBrandAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryBrandAction.h"
#import <SVProgressHUD.h>
#import "SRInterceptorUtil.h"

@implementation FZKBQueryBrandAction


/*
 此方法属于异步线程，用于数据处理：如保存数据等
 */
- (void)progress:(FZKActionResult *)result
{
    
    
    
}


/*
 ------------------jsonData----
 {"option":{},"pageResult":{"entityList":[{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"Undefined","entityID":-1,"firstLetter":"0","firstSpellByName":"WDY","imgMathParam":0.10442556620958654,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=-1","memo":"","name":"未定义","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"entityID":182,"firstLetter":"A","firstSpellByName":"ALPINA","imgMathParam":0.9863927572630374,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=182","memo":"","name":"ALPINA","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"entityID":169,"firstLetter":"A","firstSpellByName":"ACSchnitzer","imgMathParam":0.6039021626615303,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=169","memo":"","name":"AC Schnitzer","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"AUDI","entityID":2,"firstLetter":"A","firstSpellByName":"AD","imgMathParam":0.17527317018949573,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=2","memo":"","name":"奥迪","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"ALFA ROMEO","entityID":132,"firstLetter":"A","firstSpellByName":"AEFLMO","imgMathParam":0.6612795465797285,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=132","memo":"","name":"阿尔法罗密欧","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"entityID":133,"firstLetter":"A","firstSpellByName":"AKKC","imgMathParam":0.8472990838996488,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=133","memo":"","name":"安凯客车","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"ASTON.MARTIN","entityID":1,"firstLetter":"A","firstSpellByName":"ASDMD","imgMathParam":0.10131424587803961,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=1","memo":"","name":"阿斯顿·马丁","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"BRABUS","entityID":3,"firstLetter":"B","firstSpellByName":"BBS","imgMathParam":0.14019151435542876,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=3","memo":"","name":"巴博斯","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"MERCEDES-BENZ","entityID":10,"firstLetter":"B","firstSpellByName":"BC","imgMathParam":0.4065142576874392,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=10","memo":"","name":"奔驰","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"BAOJUN","entityID":4,"firstLetter":"B","firstSpellByName":"BJ","imgMathParam":0.8966074248349888,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=4","memo":"","name":"宝骏","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"BEIJING","entityID":162,"firstLetter":"B","firstSpellByName":"BJ","imgMathParam":0.3613324517995494,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=162","memo":"","name":"北京","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"BUGATTI","entityID":17,"firstLetter":"B","firstSpellByName":"BJD","imgMathParam":0.10141350203941157,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=17","memo":"","name":"布加迪","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"BAIC","entityID":7,"firstLetter":"B","firstSpellByName":"BJQC","imgMathParam":0.9084702464398747,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=7","memo":"","name":"北京汽车","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"BUICK","entityID":15,"firstLetter":"B","firstSpellByName":"BK","imgMathParam":0.6872838880324648,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=15","memo":"","name":"别克","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"BENTLEY","entityID":16,"firstLetter":"B","firstSpellByName":"BL","imgMathParam":0.43222383856690505,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=16","memo":"","name":"宾利","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"enName":"BMW","entityID":5,"firstLetter":"B","firstSpellByName":"BM","imgMathParam":0.0016730508377623687,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=5","memo":"","name":"宝马","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"entityID":134,"firstLetter":"B","firstSpellByName":"BQHS","imgMathParam":0.9497992203746062,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=134","memo":"","name":"北汽幻速","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"entityID":163,"firstLetter":"B","firstSpellByName":"BQSB","imgMathParam":0.10495768537215688,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=163","memo":"","name":"北汽绅宝","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"entityID":8,"firstLetter":"B","firstSpellByName":"BQWW","imgMathParam":0.21246202072122333,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=8","memo":"","name":"北汽威旺","updateTime":"2017-03-24 15:41:00","updateUserID":0},{"alterImageCount":0,"brandid":0,"createTime":"2017-03-24 15:41:00","createUserID":0,"depID":0,"entityID":135,"firstLetter":"B","firstSpellByName":"BQXNY","imgMathParam":0.37163966785477165,"isOpen4I18N":false,"logoUrl":"/basic/brand/getImage?entityID=135","memo":"","name":"北汽新能源","updateTime":"2017-03-24 15:41:00","updateUserID":0}],"pageIndex":1,"pageSize":20,"totalCount":179,"totalPage":9},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 查询车辆品牌（流程：添加车辆流程，第一步查询所有车辆品牌，第二步选择一个品牌，第三步根据品牌查询车辆）
 
 传入参数：

返回参数：
alterImageCount：（未用到）
brandid：（未用到）
createTime：创建时间
createUserID：（未用到）
depID：（未用到）
enName：（未用到）
entityID：品牌ID（相当于brandID）（重点获取）
firstLetter：所属字母级/首字母（比如A级）
firstSpellByName：品牌名首单词（如ALPINA）
imgMathParam：图标数字参数
isOpen4I18N：是否是打开
logoUrl：图标加载地址
memo：（未用到）
name：品牌名
updateTime：修改时间
updateUserID：修改ID
 */
+ (void)queryBrandActionSuccess:(Action1)success fail:(Action1)fail
{
    FZKBQueryBrandAction *work =[[FZKBQueryBrandAction alloc] init];
    

    [work queryBrandAction];
    
//    [work addInterceptor:[SRInterceptorUtil buildLoading:@"正在查询" With:nil]];
//    [work addInterceptor:[SRInterceptorUtil buildDisable:nil]];
    
    [SVProgressHUD showWithStatus:nil];
    
    [work onSuncc:^(FZKActionResult *result) {

        success(result.paramters);
        
        [SVProgressHUD dismiss];
        
    }];
    
    [work onError:^(FZKActionResult *result) {

        fail(result.resultMessage);
        [SVProgressHUD showErrorWithStatus:result.resultMessage];
        
        
    }];
    
    [work run];
    
}



@end
