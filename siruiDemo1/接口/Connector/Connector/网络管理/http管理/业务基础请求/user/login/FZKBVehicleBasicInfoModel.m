//
//  FZKBVehicleBasicInfoModel.m
//  Connector
//
//  Created by czl on 2017/4/19.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBVehicleBasicInfoModel.h"
#import <MJExtension.h>

@implementation FZKBVehicleBasicInfoModel

MJExtensionCodingImplementation

+ (instancetype)shareVehicleBasicInfoModel
{
     id instance = nil;
//    // 使用GCD
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
        // 保证代码执行一次
        instance = [FZKBVehicleBasicInfoModel unarchive];
        if (!instance) {
            instance = [[[self class] alloc]init];
        }
//    });
    return instance;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"abilities" : [FZKBAbilitiesModel class],@"abilities_v2":[FZKBAbilitiesModel class]};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"abilities" : [FZKBAbilitiesModel class],@"abilities_v2":[FZKBAbilitiesModel class]};
}

#pragma mark - 私有方法
+ (NSString *)archivePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = paths.firstObject;
    NSString *filePath = [basePath stringByAppendingPathComponent:@"carInfo.dat"];
    return filePath;
}
#pragma mark - 接口方法
- (void)archive {
    [NSKeyedArchiver archiveRootObject:self toFile:[FZKBVehicleBasicInfoModel archivePath]];
}
// 因为在解档的时候,还没有任何的usermodel实例.所以写成类方法,并把解档的对象返回
// 在usermodel创建的时候调用
+ (instancetype)unarchive {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[FZKBVehicleBasicInfoModel archivePath]];
}

@end
