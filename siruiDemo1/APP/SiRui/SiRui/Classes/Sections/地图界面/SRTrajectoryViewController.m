//
//  SRTrajectoryViewController.m
//  SiRui
//
//  Created by 宋搏 on 2017/4/24.
//  Copyright © 2017年 chinapke. All rights reserved.
//


#import "SRTrajectoryTableViewCell.h"
#import "SRTrajectoryViewController.h"
#import <Business/FZKBQueryTripGpsPointsAction.h>
#import <Commons/FZKCBaiduMapView.h>
#import <Commons/FZKCMapManager.h>
#import <Commons/FZKCShareManager.h>
#import <Commons/FZKPointAnnotation.h>
#import <Connector/FZKBGpsPointInfo.h>
#import <Connector/FZKLocationManager.h>
#import <Connector/NSDate+Utilities.h>


@interface SRTrajectoryViewController ()<FZKMapDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet FZKCBaiduMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *bottomTableView;
@property(nonatomic,strong) NSArray *tripPointsArr;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (assign,nonatomic) BOOL isPlay;


/**
 保存所有返回的标注反编码地址
 */
@property (nonatomic,strong) NSMutableDictionary *params;
@property (nonatomic,strong) NSMutableArray *unReverseGeoArr;

@end

@implementation SRTrajectoryViewController


-(void)setTripInfo:(FZKBTripInfo *)tripInfo{
    
    _tripInfo=tripInfo;
    
    [self queryTripPointsByTripID:tripInfo.tripID];
    
}

-(void)queryTripPointsByTripID:(NSString *)tripID{
    
    [FZKBQueryTripGpsPointsAction queryTripGpsPointsActionWithTripID:tripID success:^(id parameter) {
        
        
        _tripPointsArr = parameter;
        [_bottomTableView reloadData];
        
        [self showTrace];
        [self startTimer];
        
    } fail:^(id parameter) {
        
    }];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.params = [NSMutableDictionary new];
    _unReverseGeoArr = [NSMutableArray new];
    _mapView.mapDelegate = self;
    
    
    
    
    
    
    _bottomTableView.delegate = self;
    _bottomTableView.dataSource = self;
    _bottomTableView.tableHeaderView.hidden = YES;
    
    
    
    
    _timeLabel.text = [NSDate timeConversion: _tripInfo.startTime DateFormat:@"MM-dd HH:mm"];
    _speedLabel.text = [NSString stringWithFormat:@"%.1f km", _tripInfo.mileage];
    
    [_playButton setImage:[UIImage imageNamed:@"zhanting"] forState:UIControlStateSelected];
    [_playButton setImage:[UIImage imageNamed:@"bofang"] forState:UIControlStateNormal];
    
}






#pragma mark - Table view data source


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50.0f;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tripPointsArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    
    
    
    static NSString *CellIdentifier = @"Cell";
    SRTrajectoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SRTrajectoryTableViewCell class])
                                              owner:self
                                            options:nil] objectAtIndex:0];
        
        
        
        
        
    }
    FZKBGpsPointInfo *point = [FZKBGpsPointInfo mj_objectWithKeyValues:_tripPointsArr[indexPath.row]];
    
    if ([self.params objectForKey:[NSString stringWithFormat:@"%f%f",point.lat,point.lng]]) {
        cell.addressLabel.text = [NSString stringWithFormat:@"%@",[self.params objectForKey:[NSString stringWithFormat:@"%f%f",point.lat,point.lng]]];
    }else{
        cell.addressLabel.text = @"正在查询...";
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                           
                           
                           
                           
                           
                           [_mapView reverseGeoMap:CLLocationCoordinate2DMake(point.lat, point.lng) callBack:^(NSString *address) {
                               

                                   [self.params setObject:address forKey:[NSString stringWithFormat:@"%f%f",point.lat,point.lng]];
     
                               
                               
                               
                               dispatch_async(dispatch_get_main_queue(), ^{
                                   
                                   
                                   cell.addressLabel.text = address;
                                   
                                   
                                   
                               });
                               
                               
                           }];
                           
                           
                           
                           
                           
                           
                           
                           
                           
                           
                       });
        
    }
    cell.speedLabel.text = [NSString stringWithFormat:@"%.0fkm/h", point.obdspeed];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@", [NSDate timeConversion:point.uTCTime DateFormat:@"HH:mm:ss"]];
    
    
    
    
    
    
    return cell;
    
}

- (IBAction)play:(UIButton *)sender {
    
    _playButton.selected = !sender.selected;
    
    
    
    
    if (_playButton.selected ) {
        [FZKCMapManager startBaiduTrace];
        _isPlay = YES;
        
        [self updateTimer:nil];
        
        // 创建定时器
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(updateTimer:)
                                               userInfo:nil
                                                repeats:YES];
        
        // 将定时器添加到运行循环
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        
    }else{
        [FZKCMapManager stopBaiduTrace];
        _isPlay = NO;
        
    }
    
    
}



-(void)updateTimer:(NSString *)ss{
    
    
    
    if ([FZKCMapManager currentIndex] == 0) {
        
        _playButton.selected = NO;
        _isPlay = NO;
        return;
        
    }
    
    if (_isPlay == NO) {
        return;
    }
    
    
    [_bottomTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:[FZKCMapManager currentIndex] inSection:0]
                                  animated:NO
                            scrollPosition:UITableViewScrollPositionMiddle];
    
    
    
    
    
    
    
    
}

#pragma mark - getter
-(NSMutableDictionary *)params{
    
    if (!_params) {
        _params = [NSMutableDictionary new];
    }
    return _params;
}

- (void)showTrace{
    
    
    NSArray *array = [FZKBGpsPointInfo mj_objectArrayWithKeyValuesArray:_tripPointsArr];
    
    if (array.count >1) {
        NSMutableArray *tranceArray = [NSMutableArray new];
        
        
        
        
        
      
        
        
        
        for (int i = 0; i < array.count-1; i++) {
            
            
          int remainder =  i % 2 ;
            
            if (remainder == 0 && i > 1 && i < array.count) {
                
                FZKBGpsPointInfo *point = [array copy][i];
                FZKSportNode *sportNode = [[FZKSportNode alloc] init];
                sportNode.coordinate = CLLocationCoordinate2DMake(point.lat , point.lng );
                
                
                
                FZKBGpsPointInfo *point2 = [array copy][i+1];
                FZKSportNode *sportNode2 = [[FZKSportNode alloc] init];
                sportNode2.coordinate = CLLocationCoordinate2DMake(point2.lat , point2.lng );
                
                
                sportNode.angle = (point.direction/180)*M_PI;
                sportNode.speed = point.obdspeed;
                
                
                
                sportNode.distance  = [self countLineDistanceDest:point.lng dest_Lat:point.lat self_Lon:point2.lng self_Lat:point2.lat];
                
                [tranceArray addObject:sportNode2];
                
            }
            

            
        }
        
        
        [_mapView addOverly:tranceArray];
        
        
    }
    
    
    
    
    
    
}



#pragma mark - 系统方法计算距离
- (double)countLineDistanceDest:(double)lon1 dest_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2
{
    //计算2个经纬度之间的直线距离
    CLLocation *destloc = [[CLLocation alloc] initWithLatitude:lat1 longitude:lon1];
    CLLocation *selfloc = [[CLLocation alloc] initWithLatitude:lat2 longitude:lon2];
    CLLocationDistance distance = [destloc distanceFromLocation:selfloc];
    return distance;
}

-(void)startTimer{
    
    
    
    
    _unReverseGeoArr = [_tripPointsArr copy];
    
    
    
    
    
    
    // 创建定时器
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.3
                                             target:self
                                           selector:@selector(startDecompileCoordinates)
                                           userInfo:nil
                                            repeats:YES];
    
    // 将定时器添加到运行循环
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
    
}



-(void)startDecompileCoordinates{
    
    
    
   
    

    NSArray *array = [FZKBGpsPointInfo mj_objectArrayWithKeyValuesArray:_unReverseGeoArr];
    

    
    if (array.count >1) {
        

        

        
  
//        static int i = 0;
//        i++;
        
        //        if (i >= array.count) {
        //            return;
        //        }
        
//        int x =    i;
//        int y =    array.count - i;
        
        
        
        
        //百度 数组经纬度正向反编译
        FZKBGpsPointInfo *forward = [FZKBGpsPointInfo mj_objectWithKeyValues:array[[self arc4random]]];
        
        if (![self.params objectForKey:[NSString stringWithFormat:@"%f%f",forward.lat,forward.lng]]) {
            
            [_mapView bmk_reverseGeoMap:CLLocationCoordinate2DMake(forward.lat, forward.lng) callBack:^(NSString *address) {
                
                NSLog(@"百度%@",address);
                [self.params setObject:address forKey:[NSString stringWithFormat:@"%f%f",forward.lat,forward.lng]];
            }];
            
            
        }
        
        //原生  数组经纬度反向反编译
        FZKBGpsPointInfo *reverse = [FZKBGpsPointInfo mj_objectWithKeyValues:array[[self arc4random]]];
        
        
        if (![self.params objectForKey:[NSString stringWithFormat:@"%f%f",reverse.lat,reverse.lng]]) {
            
            [_mapView reverseGeoMap:CLLocationCoordinate2DMake(reverse.lat, reverse.lng)  callBack:^(NSString *address) {
                
                NSLog(@"原生%@",address);
                [self.params setObject:address forKey:[NSString stringWithFormat:@"%f%f",reverse.lat,reverse.lng]];
                
            }];
            
            
        }
        
        
    }
    
    
    
}

-(int)arc4random{
    NSArray *array = [FZKBGpsPointInfo mj_objectArrayWithKeyValuesArray:_unReverseGeoArr];

    return (arc4random() % array.count);

}


@end
