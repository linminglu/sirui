//
//  FZKBKeychain.m
//  Business
//
//  Created by 宋搏 on 2017/4/14.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKBKeychain.h"

NSString * const SRKeychainService = @"com.chinapke.SiRui";
NSString * const SRKeychainAccountUserName = @"UserName";
NSString * const SRKeychainAccountPassword = @"Password";
NSString * const SRKeychainAccountUUID = @"UUID";

static NSString *UserName = nil;
static NSString *Password = nil;
static NSString *UUID = nil;

@implementation FZKBKeychain


+ (NSString *)UserName{
    
    UserName = [self passwordForService:SRKeychainService
                                account:SRKeychainAccountUserName];
    return UserName;
}

+ (void)updateUserName:(NSString *)userName{
    
    [self setPassword:userName
           forService:SRKeychainService
              account:SRKeychainAccountUserName];
    
}

+ (NSString *)Password{
    
    Password = [self passwordForService:SRKeychainService
                                account:SRKeychainAccountPassword];
    return Password;
}

+ (void)updatePassword:(NSString *)password{
    
    [self setPassword:password
           forService:SRKeychainService
              account:SRKeychainAccountPassword];
    
}

+(void)deletePassword{


    [self deletePasswordForService:SRKeychainService account:SRKeychainAccountPassword];


}





+ (NSString *)UUID
{
    if (UUID) {
        return UUID;
    }
    
    UUID = [self passwordForService:SRKeychainService
                            account:SRKeychainAccountUUID];
    if (!UUID || UUID.length == 0) {
        CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
        UUID = (NSString *)CFBridgingRelease(CFUUIDCreateString (kCFAllocatorDefault,uuidRef));
        [self updateUUID:UUID];
        CFBridgingRelease(uuidRef);
    }
    return UUID;
}
+ (void)updateUUID:(NSString *)uuid
{
    [self setPassword:uuid
           forService:SRKeychainService
              account:SRKeychainAccountUUID];
}

@end
