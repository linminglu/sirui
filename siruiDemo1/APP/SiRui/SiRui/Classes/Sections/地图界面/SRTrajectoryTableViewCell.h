//
//  SRTrajectoryTableViewCell.h
//  SiRui
//
//  Created by 宋搏 on 2017/5/5.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SRTrajectoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;

@end
