//
//  FZKEPeripheralViewController.h
//  Example
//
//  Created by czl on 2017/5/18.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "FZKEBaseViewController.h"
#import <Connector/FZKTBluetoothInfoModel.h>

@interface FZKEPeripheralTestViewController : FZKEBaseViewController

@property (nonatomic,strong) FZKTBluetoothInfoModel *bleModel;

@end
