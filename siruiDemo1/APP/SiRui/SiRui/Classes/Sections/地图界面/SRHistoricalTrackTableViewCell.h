//
//  SRHistoricalTrackTableViewCell.h
//  SiRui
//
//  Created by 宋搏 on 2017/5/4.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Connector/FZKBTripInfo.h>

@interface SRHistoricalTrackTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *startTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *stopTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *travelDistanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oilConsumptionLabel;
@property (strong ,nonatomic)FZKBTripInfo *tripInfo;

@end
