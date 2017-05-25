//
//  FZKPointAnnotation.h
//  Example
//
//  Created by czl on 2017/4/26.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FZKAnnotation.h"

@interface FZKPointAnnotation : NSObject<FZKAnnotation>
{
   	@package
    CLLocationCoordinate2D _coordinate;
    NSString *title;
    NSString *subtitle;
}

@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *subtitle;
//标注标识符
@property (nonatomic,copy) NSString *uid;
@end
