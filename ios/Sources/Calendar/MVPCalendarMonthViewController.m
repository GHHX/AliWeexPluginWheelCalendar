//
//  MVPCalendarMonthViewController.m
//  MoviePro
//
//  Created by 风海 on 17/3/4.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPCalendarMonthViewController.h"
#import "MVPYearRow.h"
#import "MVPYearSection.h"
#import "MVPCalendarResultModel.h"
#import "MVPConfirmMenuView.h"
#import "MVPCalendarConfigModel.h"
#import "MVPCalendarShadeView.h"
#import "MVTableViewDataSource.h"
#import "MVPCommonUtils.h"
#import "MVTableView.h"
#import <Masonry/Masonry.h>
#import "UIColor+SHYUtil.h"
#import "NSArray+SHYUtil.h"

@interface MVPCalendarMonthViewController ()<UITableViewDelegate>

@property (strong, nonatomic) MVTableView *yearTableView;
@property (strong, nonatomic) MVTableViewDataSource *yearDataSource;
@property (strong, nonatomic) MVTableSection *yearSection;

@property (strong, nonatomic) MVTableView *calendarTableView;
@property (strong, nonatomic) MVTableViewDataSource *calendarDataSource;

@property (assign, nonatomic) BOOL isScrollDown;

@property (strong, nonatomic) NSMutableArray *selectIndexArray;
@property (strong, nonatomic) NSMutableArray *selectYearIndexArray;

@property (strong, nonatomic) MVPConfirmMenuView *menuView;
@property (strong, nonatomic) MVPCalendarShadeView *shadeView;
@property (assign, nonatomic) long tagNum;
@property (strong, nonatomic) NSMutableArray *tempIndexArray;

@property (strong, nonatomic) MVPCalenarConfigModel *bizConfigModel;
@property (assign, nonatomic) long baseYear;
@property (assign, nonatomic) long bizType;
@property (assign, nonatomic) int skipFirstMonth;

@end

@implementation MVPCalendarMonthViewController

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

- (MVTableViewDataSource *)calendarDataSource{
    if (!_calendarDataSource) {
        _calendarDataSource = [[MVTableViewDataSource alloc] init];
    }
    return _calendarDataSource;
}
- (NSMutableArray *)selectIndexArray{
    if (!_selectIndexArray) {
        _selectIndexArray = [NSMutableArray array];
    }
    return _selectIndexArray;
}

- (NSMutableArray *)selectYearIndexArray{
    if (!_selectYearIndexArray) {
        _selectYearIndexArray = [NSMutableArray array];
    }
    return _selectYearIndexArray;
}

- (NSMutableArray *)tempIndexArray{
    if (!_tempIndexArray) {
        _tempIndexArray = [NSMutableArray array];
    }
    return _tempIndexArray;
}

- (MVPCalendarShadeView *)shadeView{
    if (!_shadeView) {
        _shadeView = [[MVPCalendarShadeView alloc] init];
    }
    return _shadeView;
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
        if(_targetMonth + bizConfigModel.monthDelta > 12){
            _targetYear = _targetYear + 1;
            _targetMonth = bizConfigModel.monthDelta - (12 - _targetMonth);
        }else if (_targetMonth + bizConfigModel.monthDelta <= 0){
            _targetYear = _targetYear - 1;
            _targetMonth = 12 - (abs(bizConfigModel.monthDelta) - _targetMonth);
        }else{
            _targetMonth = _targetMonth + bizConfigModel.monthDelta;
        }
    }
    if (configModel.isSkipFirstDay == 1) {
        if ([MVPCommonUtils isMonthFirstDay:configModel.currentTs currentDate:[NSDate date]]) {
            _skipFirstMonth = 1;
            if (_targetMonth > 1) {
                _targetMonth = _targetMonth - 1;
            }
            if (_targetMonth <= 1 && _targetMonth > 0) {
                _targetYear = _targetYear - 1;
                _targetMonth = 12;
            }
        }
    }
    _baseYear = [[configModel.startDate substringToIndex:4] longLongValue];
    if (_baseYear == 0) {
        _baseYear = 2011;
    }
    
    _limit = configModel.maxMoths;
    self.bizConfigModel = configModel;
    
    [self configUI];
    [self configYearUI];
    [self configCalendarUI];
}


- (void)setSelectionModel:(MVPCalendarResultModel *)selectionModel{
    _selectionModel = selectionModel;
    if (_selectionModel && selectionModel.startModel.year >= _baseYear) {
        [self configSelectionUI];
    }
}

- (void)configSelectionUI{
    if (_selectionModel.type != CalendarTypeMonth || _selType != CalendarTypeMonth) {
        return;
    }
    if (_isMult) {
        MVPCalendarModel *sModel = _selectionModel.startModel;
        NSInteger stagSection = _targetYear - sModel.year;
        NSInteger sBaseMonth = stagSection == 0 ?_targetMonth:12;
        NSInteger sRow = sBaseMonth - sModel.month;
        NSIndexPath *sindexPath = [NSIndexPath indexPathForRow:sRow inSection:stagSection];
        MVPYearRow *srow = [self.calendarDataSource rowAtIndexPath:sindexPath];
        srow.isSelect = 1;
        [self.calendarTableView reloadRowsAtIndexPaths:@[sindexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.selectIndexArray addObject:sindexPath];
        
        MVPCalendarModel *eModel = _selectionModel.endModel;
        NSInteger etagSection = _targetYear - eModel.year;
        NSInteger eBaseMonth = etagSection == 0 ?_targetMonth:12;
        NSInteger eRow = eBaseMonth - eModel.month;
        NSIndexPath *eindexPath = [NSIndexPath indexPathForRow:eRow inSection:etagSection];
        MVPYearRow *erow = [self.calendarDataSource rowAtIndexPath:eindexPath];
        erow.isSelect = 1;
        [self.calendarTableView reloadRowsAtIndexPaths:@[eindexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.selectIndexArray addObject:eindexPath];
        
        NSIndexPath *eYearIndexPath = [NSIndexPath indexPathForRow:etagSection inSection:0];
        MVPYearRow *eYearRow = [self.yearSection rowAtIndex:eYearIndexPath.row];
        eYearRow.isSelect = 1;
        [self.yearTableView reloadRowsAtIndexPaths:@[eYearIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.selectYearIndexArray addObject:eYearIndexPath];
        
        [self getAllIndexs];
        for (NSIndexPath *ip in self.tempIndexArray) {
            MVPYearRow *row = [self.calendarDataSource rowAtIndexPath:ip];
            row.isSelect = 1;
        }
        [self.calendarTableView reloadData];
        
        [self.yearTableView scrollToRowAtIndexPath:eYearIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [self.calendarTableView scrollToRowAtIndexPath:eindexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        
    }else{
        MVPCalendarModel *sModel = _selectionModel.startModel;
        NSInteger stagSection = _targetYear - sModel.year;
        NSInteger sBaseMonth = stagSection == 0 ?_targetMonth:12;
        NSInteger sRow = sBaseMonth - sModel.month;
        NSIndexPath *sindexPath = [NSIndexPath indexPathForRow:sRow inSection:stagSection];
        MVPYearRow *srow = [self.calendarDataSource rowAtIndexPath:sindexPath];
        srow.isSelect = 1;
        [self.calendarTableView reloadRowsAtIndexPaths:@[sindexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.selectIndexArray addObject:sindexPath];
        
        NSIndexPath *sYearIndexPath = [NSIndexPath indexPathForRow:stagSection inSection:0];
        MVPYearRow *sYearRow = [self.yearSection rowAtIndex:sYearIndexPath.row];
        sYearRow.isSelect = 1;
        [self.yearTableView reloadRowsAtIndexPaths:@[sYearIndexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self.selectYearIndexArray addObject:sYearIndexPath];
        
        [self.yearTableView scrollToRowAtIndexPath:sYearIndexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [self.calendarTableView scrollToRowAtIndexPath:sindexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    [self setMenuData];
}



- (void)configMenu{
    _menuView = [[MVPConfirmMenuView alloc] init];
    [self.view addSubview:_menuView];
    [_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(60));
    }];
    __weak __typeof(&*self)weakSelf = self;
    _menuView.resultBlock = ^(NSString *startDate, NSString *endDate){
        if (_limit > 0) {
            NSUInteger days = [MVPCommonUtils getDaysBetweenDay:startDate otherDay:endDate];
            if (days > _limit) {
                [weakSelf.shadeView setContent:[NSString stringWithFormat:@"最多可选%ld月",weakSelf.limit]];
                [weakSelf.shadeView momentShowShadeViewWithType:MVPShadeTypeDown bgView:weakSelf.view];
                return;
            }
        }
        [weakSelf callBackCalendarModel];
    };
    
    [_calendarTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(_yearTableView.mas_right);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(_menuView.mas_top);
    }];
    
}



- (void)configUI {
    _yearTableView = [[MVTableView alloc] init];
    [self.view addSubview:_yearTableView];
    [_yearTableView setBackgroundColor:[UIColor shy_colorWithHex:0xf8f8f8]];
    [_yearTableView setDelegate:self];
    [_yearTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_yearTableView setClipsToBounds:YES];
    [self.yearDataSource addSection:self.yearSection];
    _yearTableView.dataSource = self.yearDataSource;
    [_yearTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(self.view.mas_left);
        make.bottom.mas_equalTo(self.view.mas_bottom);
        make.width.mas_equalTo(80);
    }];
    
    _calendarTableView = [[MVTableView alloc] init];
    [self.view addSubview:_calendarTableView];
    [_calendarTableView setBackgroundView:[UIView new]];
    [_calendarTableView setDelegate:self];
    [_calendarTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [_calendarTableView setClipsToBounds:YES];
    [_calendarTableView setScrollsToTop:YES];
    _calendarTableView.dataSource = self.calendarDataSource;
    [_calendarTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top);
        make.left.mas_equalTo(_yearTableView.mas_right);
        make.right.mas_equalTo(self.view.mas_right);
        make.bottom.mas_equalTo(self.view.mas_bottom);
    }];
    
    UIView *sLine = [[UIView alloc] init];
    [sLine setBackgroundColor:[UIColor shy_colorWithHex:0xd6dade]];
    [self.view addSubview:sLine];
    [sLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_yearTableView.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(@(0.5));
    }];
}

- (void)configYearUI {
    NSMutableArray *yearArray = [NSMutableArray array];
    long yearDiff = _targetYear - _baseYear + 1;
    for (int i = 0; i < yearDiff; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%ld",_targetYear - i]];
    }
    for (NSString *year in yearArray) {
        MVPYearRow *row = [[MVPYearRow alloc] init];
        row.isYear = YES;
        [row setYearContent:year];
        [self.yearSection addRow:row];
    }
    [self.yearTableView reloadData];
}

- (void)configCalendarUI {
    _tagNum = 1;
    long yearDiff = _targetYear - _baseYear + 1;
    NSMutableDictionary *nowInfo = [MVPCommonUtils getDateInfo:[NSDate date]];
    for (int i = 0; i < yearDiff; i++) {
        if(i == 0){
            MVPYearSection *section = [[MVPYearSection alloc] initWithTitle:[NSString stringWithFormat:@"%ld年",(_targetYear - i)]];
            [self.calendarDataSource addSection:section];
            for (long j = _targetMonth;j > 0 ;j--) {
                MVPYearRow *row = [[MVPYearRow alloc] init];
                if (_skipFirstMonth != 1 && j == _targetMonth && (_targetYear - i) == [[nowInfo objectForKey:@"year"] longValue]) {
                    [row setYearContent:[NSString stringWithFormat:@"%ld月 本月",j]];
                }else{
                    [row setYearContent:[NSString stringWithFormat:@"%ld月",j]];
                }
                row.tagNum = _tagNum;
                _tagNum++;
                [section addRow:row];
            }
        }else{
            MVPYearSection *section = [[MVPYearSection alloc] initWithTitle:[NSString stringWithFormat:@"%ld年",(_targetYear - i)]];
            [self.calendarDataSource addSection:section];
            for (long j = 12;j > 0;j--) {
                MVPYearRow *row = [[MVPYearRow alloc] init];
                if (_skipFirstMonth != 1 && j == _targetMonth && (_targetYear - i) == [[nowInfo objectForKey:@"year"] longValue]) {
                    [row setYearContent:[NSString stringWithFormat:@"%ld月 本月",j]];
                }else{
                    [row setYearContent:[NSString stringWithFormat:@"%ld月",j]];
                }
                row.tagNum = _tagNum;
                _tagNum++;
                [section addRow:row];
            }
        }
    }
    
    [self.calendarTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dateInfo = [MVPCommonUtils getDateInfo:[NSDate date]];
    _targetYear = [[dateInfo objectForKey:@"year"] longValue];
    _targetMonth = [[dateInfo objectForKey:@"month"] longValue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MVPYearRow *row = [self.calendarDataSource rowAtIndexPath:indexPath];
    if(tableView == _yearTableView){
        [self selectYearTableRowAtIndexPath:indexPath.row];
        [_calendarTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }else if (tableView == _calendarTableView) {
        if (!_isMult) {
            //单选 直接返回 不用处理状态
            row.isSelect = row.isSelect?0:1;
            if (row.isSelect) {
                [self.selectIndexArray removeAllObjects];
                [self.selectIndexArray addObject:indexPath];
            }
            [self.calendarTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            [self callBackCalendarModel];
        }else{
            // 多选
            if (self.selectIndexArray.count == 1) {
                NSIndexPath *iPath = [self.selectIndexArray firstObject];
                if (iPath == indexPath) {
                    return;
                }
                MVPYearRow *sRow = [self.calendarDataSource rowAtIndexPath:iPath];
                if (labs(sRow.tagNum - row.tagNum) > _limit) {
                    [self.shadeView setContent:[NSString stringWithFormat:@"最多可选%ld月",_limit]];
                    [self.shadeView momentShowShadeViewWithType:MVPShadeTypeDown bgView:self.view];
                    return;
                }
            }
            
            if (self.selectIndexArray.count >= 2) {
                for (NSIndexPath *iPath in self.tempIndexArray) {
                    MVPYearRow *iRow = [self.calendarDataSource rowAtIndexPath:iPath];
                    iRow.isSelect = 0;
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
                [self getAllIndexs];
                for (NSIndexPath *ip in self.tempIndexArray) {
                    MVPYearRow *row = [self.calendarDataSource rowAtIndexPath:ip];
                    row.isSelect = 1;
                }
                [self.calendarTableView reloadData];
            }
        }
    }
}

- (void)getAllIndexs{
    [self.tempIndexArray removeAllObjects];
    [self transformSelectionArray];
    NSIndexPath *sIndex = [self.selectIndexArray lastObject];
    NSIndexPath *eIndex = [self.selectIndexArray firstObject];
    NSArray *sRows = [self.calendarDataSource rowsInSection:sIndex.section];
    
    if (sIndex.section == eIndex.section) {
        for (long i = sIndex.row;i <= eIndex.row; i++) {
            [self.tempIndexArray addObject:[NSIndexPath indexPathForRow:i inSection:sIndex.section]];
        }
    }else{
        for (long i = sIndex.row;i < sRows.count; i++) {
            [self.tempIndexArray addObject:[NSIndexPath indexPathForRow:i inSection:sIndex.section]];
        }
        for (long i = 0;i<=eIndex.row;i++) {
            [self.tempIndexArray addObject:[NSIndexPath indexPathForRow:i inSection:eIndex.section]];
        }
    }
}

- (void)setMenuData{
    NSIndexPath *fmonthIndexPath;
    long baseMonth;
    
    if (self.selectIndexArray.count >= 2) {
        [self transformSelectionArray];
        fmonthIndexPath = [self.selectIndexArray firstObject];
        baseMonth = fmonthIndexPath.section == 0?_targetMonth:12;
        NSIndexPath *emonthIndexPath = [self.selectIndexArray lastObject];
        long ebaseMonth = emonthIndexPath.section == 0?_targetMonth:12;
        [_menuView setStartDate:[NSString stringWithFormat:@"%ld年%ld月",_targetYear - fmonthIndexPath.section,baseMonth - fmonthIndexPath.row] endDate:[NSString stringWithFormat:@"%ld年%ld月",_targetYear - emonthIndexPath.section,ebaseMonth - emonthIndexPath.row]];
    }else{
        fmonthIndexPath = [self.selectIndexArray firstObject];
        baseMonth = fmonthIndexPath.section == 0?_targetMonth:12;
        [_menuView setStartDate:[NSString stringWithFormat:@"%ld年%ld月",_targetYear - fmonthIndexPath.section,baseMonth - fmonthIndexPath.row] endDate:@""];
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    static CGFloat lastOffsetY = 0;
    UITableView *tableView = (UITableView *) scrollView;
    if (_calendarTableView == tableView)
    {
        _isScrollDown = lastOffsetY < scrollView.contentOffset.y;
        lastOffsetY = scrollView.contentOffset.y;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (tableView == _calendarTableView && _calendarTableView.dragging) {
        [self selectYearTableRowAtIndexPath:_isScrollDown?(section+1):(section-1)];
    }
}

- (void)selectYearTableRowAtIndexPath:(NSInteger)index
{
    MVPYearRow *row = [self.yearSection rowAtIndex:index];
    if (self.selectYearIndexArray > 0) {
        for (NSIndexPath *iPath in self.selectYearIndexArray) {
            MVPYearRow *irow = [self.yearSection rowAtIndex:iPath.row];
            irow.isSelect = 0;
            [self.yearTableView reloadRowsAtIndexPaths:@[iPath] withRowAnimation:UITableViewRowAnimationNone];
        }
        [self.selectYearIndexArray removeAllObjects];
    }
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    row.isSelect = 1;
    [self.selectYearIndexArray addObject:indexPath];
    [self.yearTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)transformSelectionArray{
    if(!_isMult){
        return;
    }
    NSIndexPath *fIndexPath = [self.selectIndexArray firstObject];
    NSIndexPath *eIndexPath = [self.selectIndexArray lastObject];
    if((fIndexPath.section < eIndexPath.section)||((fIndexPath.section == eIndexPath.section)&&(fIndexPath.row < eIndexPath.row))){
        [self.selectIndexArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
    }
}

- (void)callBackCalendarModel {
    [self transformSelectionArray];
    MVPCalendarResultModel *resultModel = [[MVPCalendarResultModel alloc] init];
    MVPCalendarModel *startModel = [[MVPCalendarModel alloc] init];
    MVPCalendarModel *endModel = [[MVPCalendarModel alloc] init];
    
    NSIndexPath *monthIndexPath = [self.selectIndexArray firstObject];
    long baseMonth = monthIndexPath.section == 0?_targetMonth:12;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-01",(_targetYear - monthIndexPath.section),(baseMonth - monthIndexPath.row)]];
    long day = [MVPCommonUtils getMonthCountBy:date];
    
    if (_isMult) {
        NSIndexPath *emonthIndexPath = [self.selectIndexArray lastObject];
        long ebaseMonth = emonthIndexPath.section == 0?_targetMonth:12;
        NSDate *edate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-01",(_targetYear - emonthIndexPath.section),(ebaseMonth - emonthIndexPath.row)]];
        long eday = [MVPCommonUtils getMonthCountBy:edate];
        
        startModel.year = _targetYear - monthIndexPath.section;
        startModel.week = 0;
        startModel.month = baseMonth - monthIndexPath.row;
        startModel.day = 1;
        endModel.year = _targetYear - emonthIndexPath.section;
        endModel.week = 0;
        endModel.month = ebaseMonth - emonthIndexPath.row;
        endModel.day = eday;
    }else{
        startModel.year = _targetYear - monthIndexPath.section;
        startModel.week = 0;
        startModel.month = baseMonth - monthIndexPath.row;
        startModel.day = 1;
        endModel.year = _targetYear - monthIndexPath.section;
        endModel.week = 0;
        endModel.month = baseMonth - monthIndexPath.row;
        endModel.day = day;
    }
    
    resultModel.type = CalendarTypeMonth;
    resultModel.startModel = startModel;
    resultModel.endModel = endModel;
    _resultBlock(resultModel);
}

- (void)dealloc{
    [self.shadeView hideShadeView];
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
