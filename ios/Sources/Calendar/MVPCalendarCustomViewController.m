//
//  MVPCalendarCustomViewController.m
//  MoviePro
//
//  Created by 风海 on 17/3/4.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPCalendarCustomViewController.h"
#import "FSCalendar.h"
#import "DIYCalendarCell.h"
#import "MVPConfirmMenuView.h"
#import "MVPCalendarConfigModel.h"
#import "MVPWeekTitleView.h"
#import "MVPCalendarShadeView.h"
#import "MVPCommonUtils.h"
#import "NSArray+SHYUtil.h"
#import "NSDictionary+SHYUtil.h"
#import <Masonry/Masonry.h>

@interface MVPCalendarCustomViewController ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>
@property (weak, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateComponents *comps;
@property (strong, nonatomic) NSMutableArray *intervalArray;
@property (strong, nonatomic) MVPConfirmMenuView *menuView;
@property (strong, nonatomic) MVPWeekTitleView *weekTitleView;
@property (strong, nonatomic) MVPCalendarShadeView *shadeView;

@property (strong, nonatomic) MVPCalenarConfigModel *bizConfigModel;
@property (assign, nonatomic) long baseYear;
@property (assign, nonatomic) long bizType;

@end
static NSString *kDiyCellId = @"diyCellID";
@implementation MVPCalendarCustomViewController
- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

- (MVPWeekTitleView *)weekTitleView{
    if (!_weekTitleView) {
        _weekTitleView = [[MVPWeekTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 25)];
    }
    return _weekTitleView;
}

- (NSDateComponents *)comps{
    if (!_comps) {
        _comps = [[NSDateComponents alloc] init];
    }
    return _comps;
}

- (NSMutableArray *)intervalArray{
    if(!_intervalArray){
        _intervalArray = [NSMutableArray array];
    }
    return _intervalArray;
}

- (MVPCalendarShadeView *)shadeView{
    if (!_shadeView) {
        _shadeView = [[MVPCalendarShadeView alloc] init];
    }
    return _shadeView;
}

- (void)setSelectionModel:(MVPCalendarResultModel *)selectionModel{
    _selectionModel = selectionModel;
    if (_selectionModel && selectionModel.startModel.year >= _baseYear) {
        [self configSelectionUI];
    }else{
        [self.shadeView showShadeViewWithType:MVPShadeTypeDown bgView:self.view];
        [self.shadeView setContent:@"选择开始日期"];
    }
}

//bizType
- (void)setBizType:(long)bizType configModel:(MVPCalenarConfigModel *)bizConfigModel{
    _bizType = bizType;
    MVPCalenarConfigModel *configModel = [[MVPCalenarConfigModel alloc] initWithDefaultData];
    if (bizConfigModel) {
        configModel = bizConfigModel;
    }
    _baseYear = [[configModel.startDate substringToIndex:4] longLongValue];
    if (_baseYear == 0) {
        _baseYear = 2011;
    }
    _limit = configModel.maxDays;
    
    self.bizConfigModel = configModel;
    
    [self configUI];
}

- (void)configUI{
    NSDateFormatter *dateFormatter = [MVPCommonUtils chineseDateFormater];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    self.minimumDate = [dateFormatter dateFromString:self.bizConfigModel.startDate.length>0?self.bizConfigModel.startDate:@"20110101"];
    
    if (self.bizConfigModel.rangeDayDelta < 0) {
        //显示到昨天
        self.maximumDate = [MVPCommonUtils getPreDate:[NSDate date] days:abs(self.bizConfigModel.rangeDayDelta)];
        
    }else if(self.bizConfigModel.rangeDayDelta > 0){
        self.maximumDate = [MVPCommonUtils getNextDate:[NSDate date] days:self.bizConfigModel.rangeDayDelta];
    }else if (self.bizConfigModel.presaleForRange){
        long presaleDay = self.bizConfigModel.presaleForRange;
        self.maximumDate = [MVPCommonUtils getNextDate:[NSDate date] days:presaleDay];
    }else{
        self.maximumDate = [NSDate date];
    }
    
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [self configDayCalendar];
    
    self.calendar.accessibilityIdentifier = @"calendar";
    
    [self.shadeView showShadeViewWithType:MVPShadeTypeDown bgView:self.view];
    [self.shadeView setHidden:YES];
}

- (void)configSelectionUI{
    NSString *sDateString = [NSString stringWithFormat:@"%ld-%ld-%ld",_selectionModel.startModel.year,_selectionModel.startModel.month,_selectionModel.startModel.day];
    NSString *eDateString = [NSString stringWithFormat:@"%ld-%ld-%ld",_selectionModel.endModel.year,_selectionModel.endModel.month,_selectionModel.endModel.day];
    if ([self.maximumDate compare:[self.dateFormatter dateFromString:eDateString]] != NSOrderedDescending || _selType != CalendarTypeCustom) {
        return;
    }
    NSDate *tagDate = [self.dateFormatter dateFromString:sDateString];
    [self.calendar setCurrentPage:tagDate animated:YES];
    if (![sDateString isEqualToString:eDateString]) {
        [self.intervalArray addObject:[self.dateFormatter dateFromString:sDateString]];
        [self.intervalArray addObject:[self.dateFormatter dateFromString:eDateString]];
        
        [self.calendar selectDate:[self.intervalArray firstObject]];
        [self.calendar selectDate:[self.intervalArray lastObject]];
        
        [self setMenuData];
        [self configureVisibleCells];
    }else{
        [self.shadeView showShadeViewWithType:MVPShadeTypeDown bgView:self.view];
        [self.shadeView setContent:@"选择开始日期"];
        [self.shadeView setHidden:NO];
    }
}

- (void)showLimitErrorView{
    MVPCalendarShadeView *shadeView = [[MVPCalendarShadeView alloc] init];
    [shadeView setContent:[NSString stringWithFormat:@"最多可选%ld天",_limit]];
    [shadeView momentShowShadeViewWithType:MVPShadeTypeMiddle bgView:_calendar];
}

- (void)configDayCalendar{
    
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
            NSUInteger days = [MVPCommonUtils getDaysBetweenOneDay:[weakSelf.intervalArray lastObject] otherDay:[weakSelf.intervalArray firstObject]];
            if (days >= _limit) {
                [weakSelf showLimitErrorView];
                return;
            }
        }
        [weakSelf callBackResult];
    };
    
    FSCalendar *calendar = [[FSCalendar alloc] init];
    if (self.bizConfigModel.presaleForRange || self.bizConfigModel.rangeDayDelta > 0) {
        calendar.isPreSale = YES;
        calendar.preNum = 15;
        if(self.bizConfigModel.rangeDayDelta > 0){
            calendar.preNum = self.bizConfigModel.rangeDayDelta;
        }
    }
    calendar.backgroundColor = [UIColor whiteColor];
    [calendar.appearance setTitleSelectionColor:[UIColor whiteColor]];
    [calendar.appearance setSubtitleSelectionColor:[UIColor whiteColor]];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.pagingEnabled = NO; // important
    calendar.allowsMultipleSelection = YES;
    calendar.firstWeekday = 1;
    calendar.today = [NSDate date];
    calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
    [calendar registerClass:[DIYCalendarCell class] forCellReuseIdentifier:kDiyCellId];
    self.calendar = calendar;
    [self.view addSubview:self.calendar];
    [self.view addSubview:self.weekTitleView];
    [_calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weekTitleView.mas_bottom).offset(-1);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(_menuView.mas_top);
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark - FSCalendarDataSource

- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return self.minimumDate;
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return self.maximumDate;
}

#pragma mark - FSCalendarDelegate

- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    return [MVPCommonUtils isSameDay:[NSDate date] date2:date] ? @"今天" : nil;
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};    
}

- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    DIYCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:kDiyCellId forDate:date atMonthPosition:monthPosition];
    return cell;
}

- (void)calendar:(FSCalendar *)calendar willDisplayCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition: (FSCalendarMonthPosition)monthPosition
{
    [self configureCell:cell forDate:date atMonthPosition:monthPosition];
}

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return NO;
    return monthPosition == FSCalendarMonthPositionCurrent;
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{

}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    if ([self.intervalArray containsObject:date]) {
        return;
    }
    
    if(calendar.selectedDates.count > 2){
        for (int i = 0;i < calendar.selectedDates.count;i++) {
            [calendar deselectDate:[calendar.selectedDates firstObject]];
        }
    }
    
    [self.intervalArray removeAllObjects];
    if (calendar.selectedDates.count == 2) {
        if (_limit > 0) {
            NSUInteger days;
            if ([[calendar.selectedDates lastObject] compare:[calendar.selectedDates firstObject]] == NSOrderedDescending) {
                days = [MVPCommonUtils getDaysBetweenOneDay:[calendar.selectedDates lastObject] otherDay:[calendar.selectedDates firstObject]];
            }else{
                days = [MVPCommonUtils getDaysBetweenOneDay:[calendar.selectedDates firstObject] otherDay:[calendar.selectedDates lastObject]];
            }
            
            if (days >= _limit) {
                [self.intervalArray addObject:[calendar.selectedDates firstObject]];
                [calendar deselectDate:[calendar.selectedDates lastObject]];
                [self showLimitErrorView];
                return;
            }
        }
        [self.shadeView setHidden:YES];
        [self transformIntervalDate:calendar.selectedDates];
        
    }else{
        [self.shadeView setHidden:NO];
        [self.intervalArray addObject:date];
        [self.shadeView setContent:@"选择结束日期"];
    }
    [self setMenuData];
    [self configureVisibleCells];
}

- (void)setMenuData{
    self.comps = [_gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[self.intervalArray firstObject]];
    NSInteger fday = [self.comps day];
    NSInteger fmonth = [self.comps month];
    NSInteger fyear = [self.comps year];
    
    if (self.intervalArray.count >= 2) {
        
        self.comps = [_gregorian components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[self.intervalArray lastObject]];
        NSInteger eday = [self.comps day];
        NSInteger emonth = [self.comps month];
        NSInteger eyear = [self.comps year];
        
        [_menuView setStartDate:[NSString stringWithFormat:@"%ld年%ld月%ld日",(long)fyear,(long)fmonth,(long)fday] endDate:[NSString stringWithFormat:@"%ld年%ld月%ld日",(long)eyear,(long)emonth,(long)eday]];
    }else{
        [_menuView setStartDate:[NSString stringWithFormat:@"%ld年%ld月%ld日",(long)fyear,(long)fmonth,(long)fday] endDate:@""];
    }
}

- (void)transformIntervalDate:(NSArray *)sArr{
    NSDate *fDate = sArr.firstObject;
    NSDate *eDate = sArr.lastObject;
    if ([fDate compare:eDate] == NSOrderedDescending) {
        [self.intervalArray addObject:eDate];
        [self.intervalArray addObject:fDate];
    }else{
        [self.intervalArray addObjectsFromArray:sArr];
    }
}

#pragma mark - Private methods

- (void)configureVisibleCells
{
    [self.calendar.visibleCells enumerateObjectsUsingBlock:^(__kindof FSCalendarCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDate *date = [self.calendar dateForCell:obj];
        FSCalendarMonthPosition position = [self.calendar monthPositionForCell:obj];
        [self configureCell:obj forDate:date atMonthPosition:position];
    }];
    [self.calendar reloadData];
}

- (void)configureCell:(FSCalendarCell *)cell forDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    DIYCalendarCell *diyCell = (DIYCalendarCell *)cell;
    // Configure selection layer
    if (monthPosition == FSCalendarMonthPositionCurrent) {
    
        SelectionType selectionType = SelectionTypeNone;
        if ([self.intervalArray containsObject:date]) {
            if(self.intervalArray.firstObject == date){
                selectionType = SelectionTypeLeftBorder;
            }else if(self.intervalArray.lastObject == date){
                selectionType = SelectionTypeRightBorder;
            }
        }else if(self.intervalArray.count == 2 && [date compare:self.intervalArray.firstObject] == NSOrderedDescending && [date compare:self.intervalArray.lastObject] == NSOrderedAscending){
            selectionType = SelectionTypeMiddle;
        } else {
            selectionType = SelectionTypeNone;
        }
        
        if (selectionType == SelectionTypeNone) {
            diyCell.selectionLayer.hidden = YES;
            diyCell.selectionType = selectionType;
            return;
        }
        diyCell.selectionLayer.hidden = NO;
        diyCell.selectionType = selectionType;
    }
}


- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    int limitDay;
    if (self.bizConfigModel.rangeDayDelta > 0) {
        limitDay = self.bizConfigModel.rangeDayDelta - 1;
    }else{
        limitDay = 14;
    }

    if ((self.bizConfigModel.presaleForRange || self.bizConfigModel.rangeDayDelta > 0) && ([date compare:[NSDate date]] == NSOrderedDescending)&&[MVPCommonUtils getDaysBetweenOneDay:date otherDay:[NSDate date]] <= limitDay) {
        return @"预售";
    }
    return nil;
}

- (void)callBackResult{
    NSInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    MVPCalendarResultModel *resultModel = [[MVPCalendarResultModel alloc] init];
    MVPCalendarModel *startModel = [[MVPCalendarModel alloc] init];
    MVPCalendarModel *endModel = [[MVPCalendarModel alloc] init];
    
    self.comps = [_gregorian components:unitFlags fromDate:[self.intervalArray firstObject]];
    NSInteger fday = [self.comps day];
    NSInteger fmonth = [self.comps month];
    NSInteger fyear = [self.comps year];
    
    startModel.year = fyear;
    startModel.week = 0;
    startModel.month = fmonth;
    startModel.day = fday;
    
    self.comps = [_gregorian components:unitFlags fromDate:[self.intervalArray lastObject]];
    NSInteger eday = [self.comps day];
    NSInteger emonth = [self.comps month];
    NSInteger eyear = [self.comps year];
    endModel.year = eyear;
    endModel.week = 0;
    endModel.month = emonth;
    endModel.day = eday;
    
    resultModel.type = CalendarTypeCustom;
    resultModel.startModel = startModel;
    resultModel.endModel = endModel;
    _resultBlock(resultModel);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
