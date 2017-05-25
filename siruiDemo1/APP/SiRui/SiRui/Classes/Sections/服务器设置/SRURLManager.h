//
//  SRURLManager.h
//  SiRui
//
//  Created by 宋搏 on 2017/4/21.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SRURLManager : NSObject
/**
 单利
 
 @return
 */
+ (instancetype)shared;


/**
 归档
 */
- (void)archive;
@property (nonatomic, copy) NSString *server4SPortal;

@end
