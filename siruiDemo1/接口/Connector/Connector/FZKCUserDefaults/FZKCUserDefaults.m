//
//  FZKCUserDefaults.m
//  Connector
//
//  Created by 宋搏 on 2017/5/2.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKCUserDefaults.h"
#import "FZKBKeychain.h"
#import "FZKBVehicleBasicInfoModel.h"
#import "FZKEnum.h"

#define isNull(obj)  (!obj||[obj isKindOfClass:[NSNull class]])
NSString * const kCurrentVehicleID = @"kCVID";//当前车辆ID
NSString * const kLoginStatus   = @"kLS";//登陆状态


@implementation FZKCUserDefaults

//流水号
+ (NSInteger)serialNumber{
    

    
    NSInteger ser   = [FZKBVehicleBasicInfoModel shareVehicleBasicInfoModel].serialNumber ;
    ++ser;
    if (ser>1000000000) {
        ser=1;
    }
    
    return ser;
}




+(BOOL)isLogin{
    
    if ([FZKBKeychain UserName] && [FZKBKeychain Password]) {
        
        return YES;
        
    }else{
    
        return NO;
    }
    
  
    

    
}
+(void)updateLoginStatus:(BOOL)isLogin{
    
    [[self standardUserDefaults] setBool:isLogin
                                  forKey:kLoginStatus];
    [[self standardUserDefaults] synchronize];
    
}


+ (NSInteger)currentVehicleID{
    
    
    
    NSInteger currentVehicleID = kCurrentCarModleId;
    if (  currentVehicleID > 0) {
        
        
        return  currentVehicleID;
        
        
    }
    
    return 0;
    
}

+ (void)updateCurrentVehicleID:(NSInteger)vehicleID
{
    
    
    
    [[self standardUserDefaults] setObject:[NSNumber numberWithInteger:vehicleID]
                                    forKey:kCurrentVehicleID];
    [[self standardUserDefaults] synchronize];
}


@end
