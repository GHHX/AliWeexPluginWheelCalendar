//
//  MVPCalendarYearViewController.m
//  MoviePro
//
//  Created by 风海 on 17/3/3.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPCalendarYearViewController.h"
#import "MVPYearRow.h"
#import "MVPCalendarResultModel.h"
#import "MVPConfirmMenuView.h"
#import "MVPCalendarConfigModel.h"
#import "MVPCalendarShadeView.h"
#import "MVTableViewDataSource.h"
#import "MVTableSection.h"
#import "MVTableView.h"
#import <Masonry/Masonry.h>
#import "NSArray+SHYUtil.h"
#import "NSDictionary+SHYUtil.h"
#import "MVPCommonUtils.h"

@interface MVPCalendarYearViewController ()<UITableViewDelegate>
@property (strong, nonatomic) MVTableView *calendarTableView;
@property (strong, nonatomic) MVTableViewDataSource *yearDataSource;
@property (strong, nonatomic) MVTableSection *yearSection;
@property (strong, nonatomic) NSMutableArray *selectIndexArray;
@property (strong, nonatomic) MVPConfirmMenuView *menuView;
@property (strong, nonatomic) MVPCalendarShadeView *shadeView;
@property (assign, nonatomic) long tagNum;

@property (strong, nonatomic) MVPCalenarConfigModel *bizConfigModel;
@property (assign, nonatomic) long baseYear;
@property (assign, nonatomic) long bizType;
@property (assign, nonatomic) int skipFirstYear;

@end

@implementation MVPCalendarYearViewController

- (MVTableSection *)yearSection{
    if (!_yearSection) {
        _yearSection = [[MVTableSection alloc] init];
    }
    return _yearSection;
}

- (MVTableViewDataSource *)yearDataSource{
    if (!_yearDataSource) {
        _yearDataSource = [[MVTableViewDataSource alloc] init];
    }
    return _yearDataSource;
}

- (NSMutableArray *)selectIndexArray{
    if (!_selectIndexArray) {
        _selectIndexArray = [NSMutableArray array];
    }
    return _selectIndexArray;
}
- (MVPCalendarShadeView *)shadeView{
    if (!_shadeView) {
        _shadeView = [[MVPCalendarShadeView alloc] init];
    }
    return _shadeView;
}

- (void)configUI {
    _calendarTableView = [[MVTableView alloc] init];
    [self.view addSubview:_calendarTableView];
    [_calendarTableView setBackgroundView:[UIView new]];
    [_calendarTableView setDelegate:self];
    [_calendarTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_calendarTableView setClipsToBounds:YES];
    [_calendarTableView setScrollsToTop:YES];
    [self.yearDataSource addSection:self.yearSection];
    _calendarTableView.dataSource = self.yearDataSource;
    [_calendarTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)configDataSource {
    NSMutableArray *yearArray = [NSMutableArray array];
    long yearDiff = _targetYear - _baseYear + 1;
    NSMutableDictionary *nowInfo = [MVPCommonUtils getDateInfo:[NSDate date]];
    for (int i = 0; i < yearDiff; i++) {
        if (_skipFirstYear != 1 && (_targetYear - i) == [nowInfo shy_longForKey:@"year"]) {
            [yearArray addObject:[NSString stringWithFormat:@"%ld 年 本年",_targetYear - i]];
        }else{
            [yearArray addObject:[NSString stringWithFormat:@"%ld 年",_targetYear - i]];
        }
    }
    _tagNum = 1;
    for (NSString *year in yearArray) {
        MVPYearRow *row = [[MVPYearRow alloc] init];
        row.tagNum = _tagNum;
        [row setYearContent:year];
        [self.yearSection addRow:row];
        _tagNum ++;
    }
    [self.calendarTableView reloadData];
}

- (void)setIsMult:(BOOL)isMult{
    _isMult = isMult;
    if (_isMult) {
        [self configMenu];
        [self.shadeView setContent:@"选择开始日期"];
        [self.shadeView showShadeViewWithType:MVPShadeTypeDown bgView:self.view];
    }
}

//bizType
- (void)setBizType:(long)bizType configModel:(MVPCalenarConfigModel *)bizConfigModel{
    _bizType = bizType;
    MVPCalenarConfigModel *configModel = [[MVPCalenarConfigModel alloc] initWithDefaultData];
    
    if (bizConfigModel) {
        configModel = bizConfigModel;
        _targetYear = _targetYear + bizConfigModel.yearDelta;
    }
    if (configModel.isSkipFirstDay == 1) {
        if ([MVPCommonUtils isYearFirstDay:configModel.currentTs currentDate:[NSDate date]]) {
            _skipFirstYear = 1;
            _targetYear = _targetYear - 1;
        }
    }
    _baseYear = [[configModel.startDate substringToIndex:4] longLongValue];
    if (_baseYear == 0) {
        _baseYear = 2011;
    }
    _limit = configModel.maxMoths;
    
    self.bizConfigModel = configModel;
    
    [self configUI];
    [self configDataSource];
}

- (void)setSelectionModel:(MVPCalendarResultModel *)selectionModel{
    _selectionModel = selectionModel;
    if (_selectionModel && selectionModel.startModel.year >= _baseYear) {
        [self configSelectionUI];
    }
}

- (void)configSelectionUI{
    if (_selectionModel.type != CalendarTypeYear || _selType != CalendarTypeYear) {
        return;
    }
    if (_isMult) {
        
        MVPCalendarModel *sModel = _selectionModel.startModel;
        NSInteger tagRow = _targetYear - sModel.year;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tagRow inSection:0];
        [self.selectIndexArray addObject:indexPath];
        
        MVPCalendarModel *eModel = _selectionModel.endModel;
        NSInteger etagRow = _targetYear - eModel.year;
        NSIndexPath *eindexPath = [NSIndexPath indexPathForRow:etagRow inSection:0];
        [self.selectIndexArray addObject:eindexPath];
        
        [self refreshSelectionData];
        
    }else{
        MVPCalendarModel *sModel = _selectionModel.startModel;
        NSInteger tagRow = _targetYear - sModel.year;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tagRow inSection:0];
        MVPYearRow *iRow = [self.yearSection rowAtIndex:indexPath.row];
        iRow.isSelect = 1;
        [self.calendarTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.selectIndexArray addObject:indexPath];
    }
    [self setMenuData];
}

- (void)configMenu{
    _menuView = [[MVPConfirmMenuView alloc] init];
    [self.view addSubview:_menuView];
    [_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(@(60));
    }];
    __weak __typeof(&*self)weakSelf = self;
    _menuView.resultBlock = ^(NSString *startDate, NSString *endDate){
        if (_limit > 0) {
            NSUInteger days = [MVPCommonUtils getDaysBetweenDay:startDate otherDay:endDate];
            if (days > _limit) {
                [weakSelf.shadeView setContent:[NSString stringWithFormat:@"最多可选%ld年",weakSelf.limit]];
                [weakSelf.shadeView momentShowShadeViewWithType:MVPShadeTypeDown bgView:weakSelf.view];
                return;
            }
        }
        [weakSelf callBackCalendarModel];
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    NSDictionary *dateInfo = [MVPCommonUtils getDateInfo:[NSDate date]];
    _targetYear = [dateInfo shy_longForKey:@"year"];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MVPYearRow *row = [self.yearSection rowAtIndex:indexPath.row];
    
    if (!_isMult) {
    //单选 直接返回 不用处理状态
        row.isSelect = row.isSelect?0:1;
        if (row.isSelect) {
            [self.selectIndexArray removeAllObjects];
            [self.selectIndexArray addObject:indexPath];
        }
        [self.calendarTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self callBackCalendarModel];
    }else {
    //多选
        if (self.selectIndexArray.count == 1) {
            NSIndexPath *iPath = [self.selectIndexArray firstObject];
            if (iPath == indexPath) {
                return;
            }
            MVPYearRow *sRow = [self.yearSection rowAtIndex:iPath.row];
            if (labs(sRow.tagNum - row.tagNum) > _limit) {
                [self.shadeView setContent:[NSString stringWithFormat:@"最多可选%ld年",_limit]];
                [self.shadeView momentShowShadeViewWithType:MVPShadeTypeDown bgView:self.view];
                return;
            }
        }
        
       if(self.selectIndexArray.count >= 2){
//           for (NSIndexPath *iPath in self.selectIndexArray) {
//               MVPYearRow *iRow = [self.yearSection rowAtIndex:iPath.row];
//               iRow.isSelect = 0;
//               [self.calendarTableView reloadRowsAtIndexPaths:@[iPath] withRowAnimation:UITableViewRowAnimationNone];
//           }
           for (MVPYearRow *row in [self.yearSection allRows]) {
               row.isSelect = 0;
           }
           [self.calendarTableView reloadData];
           [self.selectIndexArray removeAllObjects];
        }
        row.isSelect = 1;
        [self.selectIndexArray addObject:indexPath];
        [self setMenuData];
        if (self.selectIndexArray.count < 2) {
            [self.shadeView setHidden:NO];
            [self.shadeView setContent:@"选择结束日期"];
            [self.calendarTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }else{
            [self.shadeView setHidden:YES];
            
            [self refreshSelectionData];
        }
    }
}

- (void)refreshSelectionData{
    NSIndexPath *sIndexP = [self.selectIndexArray lastObject];
    NSIndexPath *eIndexP = [self.selectIndexArray firstObject];
    for (NSInteger i = sIndexP.row;i <= eIndexP.row;i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        MVPYearRow *row = [self.yearSection rowAtIndex:indexPath.row];
        row.isSelect = 1;
    }
    [self.calendarTableView reloadData];
}

- (void)setMenuData{
    if (self.selectIndexArray.count >= 2) {
        [self transformSelectionArray];
        NSIndexPath *fIndexPath = [self.selectIndexArray firstObject];
        NSIndexPath *eIndexPath = [self.selectIndexArray lastObject];
        [_menuView setStartDate:[NSString stringWithFormat:@"%ld 年",_targetYear - fIndexPath.row] endDate:[NSString stringWithFormat:@"%ld 年",_targetYear - eIndexPath.row]];
    }else{
        NSIndexPath *monthIndexPath = [self.selectIndexArray firstObject];
        [_menuView setStartDate:[NSString stringWithFormat:@"%ld 年",_targetYear - monthIndexPath.row] endDate:@""];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)transformSelectionArray{
    NSIndexPath *fIndexPath = [self.selectIndexArray firstObject];
    NSIndexPath *eIndexPath = [self.selectIndexArray lastObject];
    if(fIndexPath.row < eIndexPath.row){
        [self.selectIndexArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
    }
}

- (void)callBackCalendarModel{
    
    MVPCalendarResultModel *resultModel = [[MVPCalendarResultModel alloc] init];
    MVPCalendarModel *startModel = [[MVPCalendarModel alloc] init];
    MVPCalendarModel *endModel = [[MVPCalendarModel alloc] init];
    
    
    if (_isMult) {
        NSIndexPath *fIndexPath = [self.selectIndexArray firstObject];
        NSIndexPath *eIndexPath = [self.selectIndexArray lastObject];
        startModel.year = _targetYear - fIndexPath.row;
        startModel.week = 0;
        startModel.month = 1;
        startModel.day = 1;
        endModel.year = _targetYear - eIndexPath.row;
        endModel.week = 0;
        endModel.month = 12;
        endModel.day = 31;
    }else{
        NSIndexPath *fIndexPath = [self.selectIndexArray firstObject];
        startModel.year = _targetYear - fIndexPath.row;
        startModel.week = 0;
        startModel.month = 1;
        startModel.day = 1;
        endModel.year = _targetYear - fIndexPath.row;
        endModel.week = 0;
        endModel.month = 12;
        endModel.day = 31;
    }
   
    resultModel.type = CalendarTypeYear;
    resultModel.startModel = startModel;
    resultModel.endModel = endModel;
    _resultBlock(resultModel);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
