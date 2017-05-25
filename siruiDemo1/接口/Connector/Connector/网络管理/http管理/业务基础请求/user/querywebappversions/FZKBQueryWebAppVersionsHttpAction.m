
//
//  FZKBQueryWebAppVersionsHttpAction.m
//  Connector
//
//  Created by czl on 2017/3/27.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBQueryWebAppVersionsHttpAction.h"


@implementation FZKBQueryWebAppVersionsHttpAction


//- (NSString *) getUrlString{
//
//    return [NSString stringWithFormat:@"%@/basic/webapp/queryVersions",KBaseUrl];
//}



/*
 ------------------jsonData----
 {"entity":[{"adddate":"2016-11-01 14:52:19","attrNames":["ZIPFILEURI","ADDDATE","TITLECOLOR","TITLEIMGURL","CURRENTVERSION","BACKARROWCOLOR","VIEWID","ID","TITLEIMGHEIGHT","LASTDATE","TITLE"],"attrValues":["http://sirui-file.oss-cn-hangzhou.aliyuncs.com/webapp/201703/b27aa168-3826-41aa-a7de-bd7cdf50b6b6.zip","2016-11-01 14:52:19","#cccccc","bg.jpg",72,"#cccccc","wzcx",1,null,"2017-03-16 16:51:20","违章查询"],"attrsEntrySet":[{"key":"ZIPFILEURI","value":"http://sirui-file.oss-cn-hangzhou.aliyuncs.com/webapp/201703/b27aa168-3826-41aa-a7de-bd7cdf50b6b6.zip"},{"key":"ADDDATE","value":"2016-11-01 14:52:19"},{"key":"TITLECOLOR","value":"#cccccc"},{"key":"TITLEIMGURL","value":"bg.jpg"},{"key":"CURRENTVERSION","value":72},{"key":"BACKARROWCOLOR","value":"#cccccc"},{"key":"VIEWID","value":"wzcx"},{"key":"ID","value":1},{"key":"TITLEIMGHEIGHT"},{"key":"LASTDATE","value":"2017-03-16 16:51:20"},{"key":"TITLE","value":"违章查询"}],"backArrowColor":"#cccccc","currentVersion":72,"id":1,"lastdate":"2017-03-16 16:51:20","title":"违章查询","titleColor":"#cccccc","titleImgHeight":0,"titleImgUrl":"bg.jpg","viewID":"wzcx","zipFileURI":"http://sirui-file.oss-cn-hangzhou.aliyuncs.com/webapp/201703/b27aa168-3826-41aa-a7de-bd7cdf50b6b6.zip"},{"adddate":"2016-11-01 14:52:46","attrNames":["ZIPFILEURI","ADDDATE","TITLECOLOR","TITLEIMGURL","CURRENTVERSION","BACKARROWCOLOR","VIEWID","ID","TITLEIMGHEIGHT","LASTDATE","TITLE"],"attrValues":["http://sirui-file.oss-cn-hangzhou.aliyuncs.com/webapp/201703/8f026fda-3208-4b0a-93e0-af607bfd3101.zip","2016-11-01 14:52:46","#cccccc","bg.jpg",52,"#cccccc","info",2,null,"2017-03-14 09:38:26","资讯"],"attrsEntrySet":[{"key":"ZIPFILEURI","value":"http://sirui-file.oss-cn-hangzhou.aliyuncs.com/webapp/201703/8f026fda-3208-4b0a-93e0-af607bfd3101.zip"},{"key":"ADDDATE","value":"2016-11-01 14:52:46"},{"key":"TITLECOLOR","value":"#cccccc"},{"key":"TITLEIMGURL","value":"bg.jpg"},{"key":"CURRENTVERSION","value":52},{"key":"BACKARROWCOLOR","value":"#cccccc"},{"key":"VIEWID","value":"info"},{"key":"ID","value":2},{"key":"TITLEIMGHEIGHT"},{"key":"LASTDATE","value":"2017-03-14 09:38:26"},{"key":"TITLE","value":"资讯"}],"backArrowColor":"#cccccc","currentVersion":52,"id":2,"lastdate":"2017-03-14 09:38:26","title":"资讯","titleColor":"#cccccc","titleImgHeight":0,"titleImgUrl":"bg.jpg","viewID":"info","zipFileURI":"http://sirui-file.oss-cn-hangzhou.aliyuncs.com/webapp/201703/8f026fda-3208-4b0a-93e0-af607bfd3101.zip"}],"option":{},"result":{"resultCode":0,"resultMessage":""}}
 --------------------------------------
 */

/*
 ------------------method----
 GET
 --------------------------------------
 */


/**
 方法描述：
 查询WebApp版本号
 
 传入参数
input1：账号
input2：密码（都需加密）
返回值：
adddate:时间
attrNames:属性名
attrValues：属性值
TITLE：标题
titleImgUrl：图片url地址
zipFileURI:文件地址
 */
- (void)queryWebAppVersionsActionWithInput1:(NSString *)input1 input2:(NSString *)input2
{
	[self addPara:@"input1" withValue:input1]; 
	[self addPara:@"input2" withValue:input2]; 

    
}

- (void)smk_requestConfigures
{
    
    [super smk_requestConfigures];
    self.smk_path = @"/basic/webapp/queryVersions";

    
}

@end
