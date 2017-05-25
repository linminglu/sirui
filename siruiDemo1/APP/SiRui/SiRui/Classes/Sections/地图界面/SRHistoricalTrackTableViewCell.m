//
//  SRHistoricalTrackTableViewCell.m
//  SiRui
//
//  Created by 宋搏 on 2017/5/4.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRHistoricalTrackTableViewCell.h"
#import <Connector/NSDate+Utilities.h>

@implementation SRHistoricalTrackTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setTripInfo:(FZKBTripInfo *)tripInfo{
    
    
    


    


    
    
    _startTimeLabel.text = [self timeConversion:tripInfo.startTime ];
    _stopTimeLabel.text = [self timeConversion:tripInfo.endTime];
    _travelDistanceLabel.text = [NSString stringWithFormat:@"%.1fkm", tripInfo.mileage];
    _oilConsumptionLabel.text = [NSString stringWithFormat:@"%.1f", tripInfo.fuelCons];

 

}


-(NSString *)timeConversion:(NSString *)time{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:time];
    
    
    NSDate *date =timeDate;
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];


  
    
    
    [dateFormatter setDateFormat:@"HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:localeDate ];
    return strDate;

}


@end
