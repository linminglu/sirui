//
//  SRBrandVehicleViewController.h
//  SiRui
//
//  Created by 宋搏 on 2017/4/19.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRViewController.h"
#import <Connector/FZKBBrandInfo.h>
#import <Connector/FZKBSeriesInfo.h>
#import <Connector/FZKBVehicleInfo.h>




@protocol SRBrandVehicleViewControllerDelegate <NSObject>

@optional
- (void)selectedBrandInfo:(FZKBBrandInfo *)brandInfo
           andVehicleInfo:(FZKBVehicleInfo *)vehicleInfo;

- (void)selectedBrandInfo:(FZKBBrandInfo *)brandInfo
               seriesInfo:(FZKBSeriesInfo *)seriesInfo
           andVehicleInfo:(FZKBVehicleInfo *)vehicleInfo;

@end




@interface SRBrandVehicleViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, assign) id<SRBrandVehicleViewControllerDelegate> delegate;
@property (nonatomic, assign) BOOL canCanceled;
@property (nonatomic, assign) BOOL needOnlyShowBrandTable;

@end



