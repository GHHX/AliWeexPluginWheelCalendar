//
//  MVPCalendarViewController.m
//  MoviePro
//
//  Created by 风海 on 17/2/21.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPCalendarViewController.h"
#import "FSCalendar.h"
#import "MVPCalendarResultModel.h"
#import "MVPCalendarConfigModel.h"
#import "MVPWeekTitleView.h"
#import "MVPCommonUtils.h"
#import "UIColor+SHYUtil.h"
#import "NSArray+SHYUtil.h"
#import <Masonry/Masonry.h>

@interface MVPCalendarViewController ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (weak, nonatomic) FSCalendar *calendar;
@property (strong, nonatomic) NSDate *minimumDate;
@property (strong, nonatomic) NSDate *maximumDate;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateComponents *comps;
@property (strong, nonatomic) MVPWeekTitleView *weekTitleView;

@property (strong, nonatomic) MVPCalenarConfigModel *bizConfigModel;
@property (assign, nonatomic) long baseYear;
@property (assign, nonatomic) long bizType;

@end

@implementation MVPCalendarViewController


- (NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        _dateFormatter.dateFormat = @"yyyy-MM-dd";
    }
    return _dateFormatter;
}

- (NSDateComponents *)comps{
    if (!_comps) {
        _comps = [[NSDateComponents alloc] init];
    }
    return _comps;
}

- (MVPWeekTitleView *)weekTitleView{
    if (!_weekTitleView) {
        _weekTitleView = [[MVPWeekTitleView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 25)];
    }
    return _weekTitleView;
}

- (void)setSelectionModel:(MVPCalendarResultModel *)selectionModel{
    _selectionModel = selectionModel;
    if (_selectionModel && selectionModel.startModel.year >= _baseYear) {
        [self configSelectionUI];
    }
}

//bizType
- (void)setBizType:(long)bizType configModel:(MVPCalenarConfigModel *)bizConfigModel{
    _bizType = bizType;
    MVPCalenarConfigModel *configModel = [[MVPCalenarConfigModel alloc] initWithDefaultData];
    
    if (bizConfigModel) {
        configModel = bizConfigModel;
    }
    //codereview: 如果非法字符转义 检查是否crash
    _baseYear = [[configModel.startDate substringToIndex:4] longLongValue];
    if (_baseYear == 0) {
        _baseYear = 2011;
    }
    self.bizConfigModel = configModel;
    
    [self configUI];
}

- (void)configUI{
    
    NSDateFormatter *dateFormatter = [MVPCommonUtils chineseDateFormater];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    self.minimumDate = [dateFormatter dateFromString:self.bizConfigModel.startDate.length>0?self.bizConfigModel.startDate:@"20110101"];
    
    if (self.bizConfigModel.singleDayDelta < 0) {
        //显示到昨天
        self.maximumDate = [MVPCommonUtils getPreDate:[NSDate date] days:abs(self.bizConfigModel.singleDayDelta)];
        
    }else if(self.bizConfigModel.singleDayDelta > 0){
        self.maximumDate = [MVPCommonUtils getNextDate:[NSDate date] days:self.bizConfigModel.singleDayDelta];
    }else if (self.bizConfigModel.presaleForSingle){
        long presaleDay = self.bizConfigModel.presaleForSingle;
        self.maximumDate = [MVPCommonUtils getNextDate:[NSDate date] days:presaleDay];
    }else{
        self.maximumDate = [NSDate date];
    }
    if ([self.maximumDate compare:self.minimumDate] == NSOrderedAscending) {
        self.minimumDate =[dateFormatter dateFromString:@"20110101"];
    }
    
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    [self configDayCalendar];
    
    self.calendar.accessibilityIdentifier = @"calendar";
}

- (void)configSelectionUI{
    NSString *dateString = [NSString stringWithFormat:@"%ld-%ld-%ld",_selectionModel.startModel.year,_selectionModel.startModel.month,_selectionModel.startModel.day];
    NSDate *tagDate = [self.dateFormatter dateFromString:dateString];
    if ([tagDate compare:self.maximumDate] == NSOrderedDescending || _selType != CalendarTypeDay) {
        return;
    }
    [self.calendar selectDate:tagDate scrollToDate:YES];
}

- (void)configDayCalendar{
    FSCalendar *calendar = [[FSCalendar alloc] init];
    if (self.bizConfigModel.presaleForSingle || self.bizConfigModel.singleDayDelta >0) {
        calendar.isPreSale = YES;
        calendar.preNum = 15;
        if (self.bizConfigModel.singleDayDelta > 0) {
            calendar.preNum = self.bizConfigModel.singleDayDelta;
        }
    }
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.pagingEnabled = NO; // important
    calendar.allowsMultipleSelection = NO;
    calendar.firstWeekday = 1;
    calendar.placeholderType = FSCalendarPlaceholderTypeNone;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesSingleUpperCase|FSCalendarCaseOptionsHeaderUsesUpperCase;
    self.calendar = calendar;
    [self.view addSubview:self.calendar];
    [self.view addSubview:self.weekTitleView];
    [_calendar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.weekTitleView.mas_bottom).offset(-1);
        make.left.right.bottom.equalTo(self.view);
    }];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    [self callBackResult:date];
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{

}

- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date
{
    int limitDay;
    if (self.bizConfigModel.singleDayDelta > 0) {
        limitDay = self.bizConfigModel.singleDayDelta - 1;
    }else{
        limitDay = 14;
    }
    
    if ((self.bizConfigModel.presaleForSingle || self.bizConfigModel.singleDayDelta > 0) && ([date compare:[NSDate date]] == NSOrderedDescending)&&[MVPCommonUtils getDaysBetweenOneDay:date otherDay:[NSDate date]] <= limitDay) {
        return @"预售";
    }
    return nil;
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change page %@",[self.dateFormatter stringFromDate:calendar.currentPage]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)callBackResult:(NSDate *)date{
    
    NSInteger unitFlags = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    self.comps = [_gregorian components:unitFlags fromDate:date];
    NSInteger day = [self.comps day];
    NSInteger month = [self.comps month];
    NSInteger year = [self.comps year];
    
    MVPCalendarResultModel *resultModel = [[MVPCalendarResultModel alloc] init];
    MVPCalendarModel *startModel = [[MVPCalendarModel alloc] init];
    MVPCalendarModel *endModel = [[MVPCalendarModel alloc] init];
    
    startModel.year = year;
    startModel.week = 0;
    startModel.month = month;
    startModel.day = day;
    endModel.year = year;
    endModel.week = 0;
    endModel.month = month;
    endModel.day = day;
    
    resultModel.type = CalendarTypeDay;
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
