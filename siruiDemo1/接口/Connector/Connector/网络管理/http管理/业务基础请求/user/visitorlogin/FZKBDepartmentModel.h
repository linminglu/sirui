
//
//  FZKBDepartmentModel.h
//  Connector
//
//  Created by czl on date
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZKBDepPartAttrModel.h"
#import "FZKBFDepPartAttrModel.h"

@interface FZKBDepartmentModel : NSObject

@property (nonatomic,copy) NSString *fExtendLevelCode;

@property (nonatomic,assign) NSInteger updateUserID;

@property (nonatomic,assign) NSInteger entityID;

@property (nonatomic,assign) NSInteger userID;

@property (nonatomic,assign) NSInteger isSecond;

@property (nonatomic,copy) NSString *fExtendOrderRule;

@property (nonatomic,copy) NSString *secondLevelCode;

@property (nonatomic,assign) NSInteger gwstock;

@property (nonatomic,assign) NSInteger isCooperateMainten;

@property (nonatomic,copy) NSString *serverPhone;

@property (nonatomic,assign) NSInteger view4SOnline;

@property (nonatomic,assign) NSInteger isChild;

@property (nonatomic,assign) CGFloat lat;

@property (nonatomic,assign) NSInteger createUserID;

@property (nonatomic,assign) NSInteger fHas4sOnline;

@property (nonatomic,assign) CGFloat lng;

@property (nonatomic,assign) NSInteger fHasOrderOpen;

@property (nonatomic,assign) NSInteger querySub;

@property (nonatomic,copy) NSString *fLevelcode;

@property (nonatomic,copy) NSString *assistPhone;

@property (nonatomic,assign) NSInteger storeOtuStock;

@property (nonatomic,copy) NSString *extendLevelCode;

@property (nonatomic,copy) NSString *extendOrderOpen;

@property (nonatomic,assign) NSInteger isTop;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,assign) NSInteger isSelf;

@property (nonatomic,assign) NSInteger has4sOnline;

@property (nonatomic,copy) NSArray *permissionsChZn;

@property (nonatomic,copy) NSString *topLevelCode;

@property (nonatomic,assign) NSInteger otustock;

@property (nonatomic,copy) NSString *fExtendOrderOpen;

@property (nonatomic,assign) NSInteger audiInterfaceSwitch;

@property (nonatomic,assign) NSInteger isTopSystem;

@property (nonatomic,copy) NSString *siruiOnlineName;

@property (nonatomic,copy) NSString *levelCode;

@property (nonatomic,copy) NSString *notifyDangerPhone;

@property (nonatomic,assign) NSInteger brandID;

@property (nonatomic,strong) FZKBDepPartAttrModel *depPartAttr;

@property (nonatomic,assign) NSInteger hasOrderOpen;

@property (nonatomic,assign) NSInteger depID;

@property (nonatomic,assign) NSInteger storeWgStock;

@property (nonatomic,assign) NSInteger isContainsChild;

@property (nonatomic,copy) NSString *address;

@property (nonatomic,assign) NSInteger extendOrderFlag;

@property (nonatomic,assign) NSInteger topOrParentLevel;

@property (nonatomic,copy) NSString *updateTime;

@property (nonatomic,assign) CGFloat imgMathParam;

@property (nonatomic,assign) NSInteger viewOrder;

@property (nonatomic,assign) NSInteger depType;

@property (nonatomic,copy) NSString *createTime;

@property (nonatomic,copy) NSString *extendOrderRule;

@property (nonatomic,strong) FZKBFDepPartAttrModel *fDepPartAttr;


@end