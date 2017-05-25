//
//  SRBrandVehicleViewController.m
//  SiRui
//
//  Created by 宋搏 on 2017/4/19.
//  Copyright © 2017年 chinapke. All rights reserved.
//

#import "SRBrandVehicleViewController.h"
#import <Business/FZKBQueryBrandAction.h>
#import <Business/FZKBQueryCarSeriesAction.h>
#import <Commons/FZKCChineseSort.h>
#import <Connector/FZKBDomainConfig.h>
#import <Connector/FZKBBrandPageResultModel.h>



@interface SRBrandVehicleViewController ()
{
    volatile BOOL isSubTableShow;
    volatile NSInteger selectedSection;
}


@property (strong, nonatomic) FZKBBrandInfo   *selectedBrandInfo;
@property (strong, nonatomic) FZKBSeriesInfo  *selectedSeriesInfo;
@property (strong, nonatomic) FZKBVehicleInfo *selectedVehicleInfo;
@property (strong, nonatomic) NSArray *brankEntityList;
@property (strong, nonatomic) NSArray *seriesInfoArr;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonCancel;
@property (weak, nonatomic) IBOutlet UITableView *brandTable;
@property (weak, nonatomic) IBOutlet UITableView *subTable;
@property (weak, nonatomic) IBOutlet UIView *containerView;




//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;

@end

@implementation SRBrandVehicleViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    _brandTable.sectionIndexBackgroundColor = [UIColor colorWithHexString:@"455966"];
    _containerView.frame = CGRectMake(77, 64, SCREEN_WIDTH-77, SCREENH_HEIGHT-64);
    _containerView.layer.shadowColor = [UIColor colorWithHexString:@"193a4f"].CGColor;
    _containerView.layer.shadowOffset = CGSizeMake(-5.0f, 7.0f);
    _containerView.layer.shadowOpacity = 0.5f;
    _containerView.layer.shadowRadius = 5;
    _subTable.frame = CGRectMake(0, 0,  _containerView.frame.size.width, _containerView.frame.size.height);
    selectedSection = -1;
    
    
    _brandTable.tableFooterView = [UIView new];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self hideContainerViewAnimated:NO];
        
    });
    
    
    [self queryBrand];
    
    
}






/**
 取消
 */
- (IBAction)buttonCancelPressed:(id)sender {
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectedBrandInfo:andVehicleInfo:)]) {
        [_delegate selectedBrandInfo:nil
                      andVehicleInfo:nil];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectedBrandInfo:seriesInfo:andVehicleInfo:)]) {
        [_delegate selectedBrandInfo:nil seriesInfo:nil andVehicleInfo:nil];
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}


/**
 完成
 */
- (IBAction)buttonDonePressed:(id)sender {
    
    
    
    if (!_selectedBrandInfo || !_selectedSeriesInfo || !_selectedVehicleInfo) {
        
        [SVProgressHUD showErrorWithStatus:@"请选择车型"];
        return;
    }
    
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectedBrandInfo:andVehicleInfo:)]) {
        [_delegate selectedBrandInfo:_selectedBrandInfo
                      andVehicleInfo:_selectedVehicleInfo];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectedBrandInfo:seriesInfo:andVehicleInfo:)]) {
        [_delegate selectedBrandInfo:_selectedBrandInfo
                          seriesInfo:_selectedSeriesInfo
                      andVehicleInfo:_selectedVehicleInfo];
    }
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}




#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (isSubTableShow && [(UITableView *)scrollView isEqual:_brandTable]) {
        isSubTableShow = NO;
        [self hideContainerViewAnimated:YES];
    }
}



#pragma mark - UITableView
//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (tableView == _brandTable) {
        return [self.indexArray objectAtIndex:section];
        
        
    }else{
        return nil;
        
    }
    
}
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    
    if (tableView == _brandTable) {
        return [self.indexArray count];
        
        
    }else{
        return _seriesInfoArr.count;
        
    }
}
//每组section个数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if (tableView == _brandTable) {
        return [[self.letterResultArr objectAtIndex:section] count];
        
        
    }else if ([tableView isEqual:_subTable] && section==selectedSection) {
        FZKBSeriesInfo *seriesInfo = [_seriesInfoArr objectAtIndex:section];
        return seriesInfo.vehicleModelVOs.count;
        
    }else{
        return 0;
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40.0f;
}

//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    if (tableView == _brandTable) {
        return self.indexArray;
        
        
    }else{
        return nil;
        
    }
    
}
//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    return index;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    
    if (tableView == _brandTable) {
        UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
        
        header.contentView.backgroundColor = [UIColor colorWithHexString:@"193a4f"];
        
    }
   
    
}
//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.backgroundColor = [UIColor colorWithHexString:@"455966"];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:13.0];
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithHexString:@"1a86c6"];
        [cell setSelectedBackgroundView:bgColorView];
    }
    
    
    
    
    if (tableView == _brandTable) {
        FZKBBrandInfo *info = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.textLabel.text = info.name;
        
        cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }else{
        FZKBSeriesInfo *seriesInfo = [_seriesInfoArr objectAtIndex:indexPath.section];
        NSArray *vehicleInfoArr = [FZKBVehicleInfo mj_objectArrayWithKeyValuesArray:seriesInfo.vehicleModelVOs];
        FZKBVehicleInfo *vehicleInfo = [vehicleInfoArr objectAtIndex:indexPath.row];
        cell.textLabel.text = vehicleInfo.vehicleName;
        
    }
    
    
    return cell;
}






- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:_subTable]) {
        
        
        FZKBSeriesInfo *seriesInfo = [_seriesInfoArr objectAtIndex:section];
        
        UIControl *view = [[UIControl alloc] init] ;
        view.tag = section;
        view.backgroundColor = [UIColor colorWithHexString:@"193a4f"];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
        titleLabel.font = [UIFont systemFontOfSize:12.0];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = seriesInfo.seriesName;
        [view addSubview:titleLabel];
        
        UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xuanze"]];
        if (section == selectedSection) {
            icon.transform = CGAffineTransformMakeRotation((M_PI / 2));
        }
        [icon setX:_subTable.frame.size.width - 30 ];
        [icon setY:titleLabel.frame.size.height/2];
        [view addSubview:icon];
        
        [view addTarget:self action:@selector(handleHeaderViewTapEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        return view;
    } else {
        return nil;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _brandTable) {
        
        selectedSection = -1;
        
        FZKBBrandInfo *info = [[self.letterResultArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        
        _selectedBrandInfo = info;
        _selectedSeriesInfo = nil;
        _selectedVehicleInfo = nil;
        
        [self queryCarSeriesBrandID:info.entityID];
        
        
    }else{
        
        
        _selectedSeriesInfo = [_seriesInfoArr objectAtIndex:indexPath.section];
        NSArray *vehicleInfoArr = [FZKBVehicleInfo mj_objectArrayWithKeyValuesArray:_selectedSeriesInfo.vehicleModelVOs];
        _selectedVehicleInfo = [vehicleInfoArr objectAtIndex:indexPath.row];
        
        
    }
    
    
}







#pragma mark - Handle Gesture Recognizer

- (IBAction)handleHeaderViewTapEvent:(id)sender {
    if (selectedSection == [sender tag]) {
        selectedSection = -1;
    } else {
        selectedSection = [sender tag];
    }
    
    [_subTable reloadData];
}




- (IBAction)handleContainerViewSwipeGestureRecognizer:(UISwipeGestureRecognizer *)recognizer {
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self hideContainerViewAnimated:YES];
    }
}





- (void)showContainerViewAnimated:(BOOL)animated{
    
    [UIView animateWithDuration:animated?0.5:0 animations:^{
        CGRect frame = _containerView.frame;
        frame.origin.x = SCREEN_WIDTH - frame.size.width;
        _containerView.frame = frame;
    } completion:^(BOOL finished) {
        isSubTableShow = YES;
        [_subTable reloadData];
    }];
}

- (void)hideContainerViewAnimated:(BOOL)animated{
    
    [UIView animateWithDuration:animated?0.5:0 animations:^{
        CGRect frame = _containerView.frame;
        
        frame.origin.x = SCREEN_WIDTH+10;
        _containerView.frame = frame;
        
        
    } completion:^(BOOL finished) {
        isSubTableShow = NO;
    }];
    
}





#pragma mark - 请求数据

/**
 请求品牌信息
 */
-(void)queryBrand{
    
    
    [FZKBQueryBrandAction queryBrandActionSuccess:^(id parameter) {
        
        
        FZKBBrandPageResultModel *model =   [FZKBBrandPageResultModel mj_objectWithKeyValues:[parameter objectForKey:@"pageResult"]];
        
        _brankEntityList =       [FZKBBrandInfo mj_objectArrayWithKeyValuesArray:model.entityList];
        _indexArray =      [FZKCChineseSort IndexWithArray:_brankEntityList Key:@"name"];
        _letterResultArr = [FZKCChineseSort sortObjectArray:_brankEntityList Key:@"name"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [_brandTable reloadData];
            
        });
        
        
        
    } fail:^(id parameter) {
        
    }];
    
}
/**
 请求车系信息
 */
-(void)queryCarSeriesBrandID:(NSString *)brandID{
    
    [FZKBQueryCarSeriesAction queryCarSeriesActionWithBrandID:brandID success:^(id parameter) {
        
        NSMutableArray* arr =   [parameter objectForKey:@"entity"] ;
        
        _seriesInfoArr =   [FZKBSeriesInfo mj_objectArrayWithKeyValuesArray:arr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [_subTable setContentOffset:CGPointMake(0, 0)];
            [_subTable reloadData];
            [self showContainerViewAnimated:YES];
            
        });
        
        
        
    } fail:^(id parameter) {
        
    }];
    
    
}


@end
