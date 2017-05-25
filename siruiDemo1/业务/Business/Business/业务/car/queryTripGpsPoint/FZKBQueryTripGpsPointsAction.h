//
//  FZKBQueryTripGpsPointsAction.h
//  Business
//
//  Created by 宋搏 on 2017/5/4.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import <Connector/Connector.h>
#import <Connector/FZKBQueryTripGpsPointsHttpAction.h>

@interface FZKBQueryTripGpsPointsAction : FZKBQueryTripGpsPointsHttpAction



+ (void)queryTripGpsPointsActionWithTripID:(NSString *)tripID success:(Action1)success fail:(Action1)fail;

@end
