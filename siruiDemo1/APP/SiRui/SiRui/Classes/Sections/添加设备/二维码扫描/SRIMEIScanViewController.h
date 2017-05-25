//
//  SRIMEIScanViewController.h
//  SiRui
//
//  Created by czl on 2017/4/17.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <LBXScan/LBXScanViewController.h>
#import <Connector/Connector.h>

@interface SRIMEIScanViewController : LBXScanViewController


/**
 扫描后的回调
 */
@property (nonatomic,copy) Action1 scanVieBlock;

@end
