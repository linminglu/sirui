//
//  FSCalendarScopeExampleViewController.m
//  FSCalendar
//
//  Created by Wenchao Ding on 8/29/15.
//  Copyright (c) 2015 Wenchao Ding. All rights reserved.
//

#import "SRHistoricalTrackViewController.h"

#import "SRHistoricalTrackTableViewCell.h"
#import <Business/FZKBQueryTripListAction.h>
#import <Connector/FZKCUserDefaults.h>
#import <Connector/FZKBTripInfo.h>
#import "SRTrajectoryViewController.h"
#import <Connector/NSDate+Utilities.h>




@interface SRHistoricalTrackViewController()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate>
{
    void * _KVOContext;
}

@property (weak, nonatomic) IBOutlet UITableView *MyTableView;
@property (weak, nonatomic) IBOutlet UISwitch *animationSwitch;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *calendarHeightConstraint;

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@property (nonatomic, strong) NSMutableArray * tripEntityList;
@property (strong ,nonatomic) FZKBTripInfo *selectTripInfo;
@property (nonatomic, strong) NSMutableArray * localTimeTripEntityList;
@property (nonatomic, strong) NSMutableArray * localTimeTripEntityListByDate;



@end


@implementation SRHistoricalTrackViewController

#pragma mark - Life cycle

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _tripEntityList = [[NSMutableArray alloc] init];
    _localTimeTripEntityList = [[NSMutableArray alloc] init];
    _localTimeTripEntityListByDate = [[NSMutableArray alloc] init];
    

    
    
    

    _MyTableView.delegate = self;
    _MyTableView.dataSource = self;
//    _MyTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    

    
    
     [self queryTripList:[self.dateFormatter stringFromDate:[NSDate date]]];
    
    _MyTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
          [_MyTableView.mj_header endRefreshing];
    }];
    
    _MyTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
          [_MyTableView.mj_footer endRefreshing];
    }];
    
}




#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _localTimeTripEntityListByDate.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_localTimeTripEntityListByDate[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"Cell";
    SRHistoricalTrackTableViewCell *cell = (SRHistoricalTrackTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([SRHistoricalTrackTableViewCell class])
                                              owner:self
                                            options:nil] objectAtIndex:0];
        
    }
    
    
    
    
    
    
    [self configureCell:cell TableView:tableView atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(SRHistoricalTrackTableViewCell *)cell TableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    
    
    FZKBTripInfo *info  = [FZKBTripInfo mj_objectWithKeyValues: [[_localTimeTripEntityListByDate objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] ];
    cell.tripInfo = info;
    
    
    
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    
    _selectTripInfo  = [FZKBTripInfo mj_objectWithKeyValues:[[_localTimeTripEntityListByDate objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
 
    
    [self performSegueWithIdentifier:@"ShowSRTrajectoryViewController" sender:self];
    
    
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 30.0f;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    FZKBTripInfo *info  = [FZKBTripInfo mj_objectWithKeyValues:[[_localTimeTripEntityListByDate objectAtIndex:section] objectAtIndex:0]];
    
    UIControl *view = [[UIControl alloc] init] ;
    view.tag = section;
    view.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.width, 30)];
    titleLabel.font = [UIFont systemFontOfSize:16.0];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = [NSDate timeConversion:info.startTime DateFormat:@"yyyy-MM-dd"];
    [view addSubview:titleLabel];
    

    
    return view;
    
}








-(void)queryTripList:(NSString *)date{
    
    [FZKBQueryTripListAction queryTripListActionWithSelectTime:date success:^(id parameter) {
        
        
        
        if (parameter) {
            
            _tripEntityList = parameter;
//            [_MyTableView reloadData];
            [self dataProcessing];
            
        }else{
          
            [_tripEntityList removeAllObjects];
            [_MyTableView reloadData];
            
            
        }
        
        
    } fail:^(id parameter) {
        
    }];
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    if ([segue.identifier isEqualToString:@"ShowSRTrajectoryViewController"]) {

        SRTrajectoryViewController *trajectory = segue.destinationViewController;
        trajectory.tripInfo = _selectTripInfo;

    }
}








-(void)dataProcessing{
    
    
    for (FZKBTripInfo *info in [FZKBTripInfo mj_objectArrayWithKeyValuesArray:_tripEntityList]) {

        info.startTime  =  [NSDate timeConversion:  info.startTime DateFormat:@"yyyy-MM-dd HH:mm:ss"];
        info.endTime   = [NSDate timeConversion:  info.endTime DateFormat:@"yyyy-MM-dd HH:mm:ss"];

        [_localTimeTripEntityList addObject:info];
        
    
    }
    
    

    
       NSLog(@"_tripEntityList %@",_tripEntityList);
       NSLog(@"_localTimeTripEntityList %@",[NSMutableArray mj_keyValuesArrayWithObjectArray:_localTimeTripEntityList]);
    
    [self groupedByDate];
    
    

}


- (void)groupedByDate{
    
    
    
    
    NSArray *array1 = [NSMutableArray mj_keyValuesArrayWithObjectArray:_localTimeTripEntityList];
    
    
    
    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    for (int i = 0; i<array.count/2.0; i++) {
        [array exchangeObjectAtIndex:i withObjectAtIndex:array.count-1-i];
    }
    NSLog(@"%@",array);
    
    
//    NSMutableArray *array = [NSMutableArray arrayWithArray:array1];
    
    NSMutableArray *dateMutablearray = [@[] mutableCopy];
    for (int i = 0; i < array.count; i ++) {
        
        NSString *string = [NSDate timeConversion:  [array[i] objectForKey:@"startTime"] DateFormat:@"yyyy-MM-dd"];
        
        NSMutableArray *tempArray = [@[] mutableCopy];
        
        NSDictionary *dic = array[i];
        
        [tempArray addObject:dic];
        
        for (int j = i+1; j < array.count; j ++) {
            
            NSString *jstring = [NSDate timeConversion:  [array[j] objectForKey:@"startTime"] DateFormat:@"yyyy-MM-dd"];
            
            if([string isEqualToString:jstring]){
                
                
                NSDictionary *dic = array[j];
                [tempArray addObject:dic];
                
                [array removeObjectAtIndex:j];
                j -= 1;
                
            }
            
        }
        
        [_localTimeTripEntityListByDate addObject:tempArray];
        
        
        
    }

    
    
    
    
                [_MyTableView reloadData];
    
    NSLog(@"dateMutable:%@",_localTimeTripEntityListByDate);
     NSLog(@"dateMutable0:%lu",(unsigned long)_localTimeTripEntityListByDate.count);
}

@end
