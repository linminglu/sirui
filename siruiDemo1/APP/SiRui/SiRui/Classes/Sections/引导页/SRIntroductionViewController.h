//
//  SRIntroductionViewController.h
//  SiRui
//
//  Created by 宋搏 on 2017/4/20.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ZWIntroductionViewController.h>

@interface SRIntroductionViewController : UIViewController
@property (nonatomic, strong) ZWIntroductionViewController *introductionView;

@property (nonatomic, strong) NSArray *coverImageNames;

@property (nonatomic, strong) NSArray *backgroundImageNames;

@property (nonatomic, strong) NSArray *coverTitles;

@property (nonatomic, strong) NSURL *videoURL;
@end
