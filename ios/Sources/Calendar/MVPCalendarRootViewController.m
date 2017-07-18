//
//  MVPCalendarRootViewController.m
//  MoviePro
//
//  Created by 风海 on 17/2/21.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPCalendarRootViewController.h"
#import "MVSmoothSegmentControl.h"
#import "MVPCalendarViewController.h"
#import "MVPCalendarWeekViewController.h"
#import "MVPCalendarYearViewController.h"
#import "MVPCalendarMonthViewController.h"
#import "MVPCalendarCustomViewController.h"
#import "MVPCalendarResultModel.h"
#import "MVPCalendarConfigModel.h"
#import "UIColor+SHYUtil.h"
#import "NSArray+SHYUtil.h"
#import "NSDictionary+SHYUtil.h"
#import <Masonry/Masonry.h>

@interface MVPCalendarRootViewController ()<MVSegmentControlDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) MVSmoothSegmentControl *segmentControl;
@property (strong, nonatomic) UIScrollView *rootScrollView;
@property (strong, nonatomic) MVPCalendarViewController *dayController;
@property (strong, nonatomic) MVPCalendarWeekViewController *weekController;
@property (strong, nonatomic) MVPCalendarMonthViewController *monthController;
@property (strong, nonatomic) MVPCalendarYearViewController *yearController;
@property (strong, nonatomic) MVPCalendarCustomViewController *customController;
@property (assign, nonatomic) NSInteger scrollSize;
@property (assign, nonatomic) CGFloat segmentHight;
@property (assign, nonatomic) CGFloat scrollHeight;
@end

@implementation MVPCalendarRootViewController

#pragma mark -- setter method
- (MVSmoothSegmentControl *)segmentControl
{
    if (!_segmentControl) {
        _segmentControl = [[MVSmoothSegmentControl alloc] initWithTitles:nil];
        _segmentControl.delegate = self;
        _segmentControl.titleFontSize = 14;
        _segmentControl.fullFit = YES;
        _segmentControl.fullFitAndScrollable = YES;
        _segmentControl.topSeperatorLine.hidden = YES;
        [_segmentControl addTarget:self action:@selector(segmentControlValueChanged:)
                  forControlEvents:UIControlEventValueChanged];
    }
    return _segmentControl;
}

- (UIScrollView *)rootScrollView{
    if (!_rootScrollView) {
        _rootScrollView = [[UIScrollView alloc] init];
        _rootScrollView.pagingEnabled = YES;
        _rootScrollView.scrollsToTop = NO;
        _rootScrollView.delegate = self;
        _rootScrollView.showsHorizontalScrollIndicator = NO;
        _rootScrollView.showsVerticalScrollIndicator = NO;
        _rootScrollView.frame = CGRectMake(0, _segmentHight+64, [UIScreen mainScreen].bounds.size.width, _scrollHeight);
        _rootScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width * _scrollSize, _scrollHeight);
    }
    return _rootScrollView;
}

- (MVPCalendarWeekViewController *)weekController{
    if (!_weekController) {
        _weekController = [[MVPCalendarWeekViewController alloc] init];
    }
    return _weekController;
}
- (MVPCalendarMonthViewController *)monthController{
    if (!_monthController) {
        _monthController = [[MVPCalendarMonthViewController alloc] init];
    }
    return _monthController;
}

- (MVPCalendarYearViewController *)yearController{
    if (!_yearController) {
        _yearController = [[MVPCalendarYearViewController alloc] init];
    }
    return _yearController;
}

- (MVPCalendarViewController *)dayController{
    if(!_dayController){
        _dayController = [[MVPCalendarViewController alloc] init];
    }
    return _dayController;
}

- (MVPCalendarCustomViewController *)customController{
    if(!_customController){
        _customController = [[MVPCalendarCustomViewController alloc] init];
    }
    return _customController;
}

- (void)refreshConfigDataSource {
    if (self.configDataSource != nil) {
        if (self.configDataSource.configArray.count <= 1) {
            _segmentHight = 0;
        }else{
            _segmentHight = 44;
        }
        _scrollHeight = [UIScreen mainScreen].bounds.size.height - 64 - _segmentHight;
        
         [self.view addSubview:self.segmentControl];
         [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.mas_equalTo(64);
         make.left.right.mas_equalTo(self.view);
         make.height.mas_equalTo(_segmentHight);
         }];
         
         _scrollSize = _configDataSource.configArray.count;
         [self.view addSubview:self.rootScrollView];
        
        NSMutableArray *titleArray = [NSMutableArray array];
        int scrollIndex = 0;
        for (int i = 0 ;i < _configDataSource.configArray.count ; i++) {
            CalendarConfigModel* model = [_configDataSource.configArray objectAtIndex:i];
            NSString *defaultTitle;
            switch (model.type) {
                case CalendarTypeDay:
                    defaultTitle = @"日票房";
                    break;
                case CalendarTypeWeek:
                    defaultTitle = @"周票房";
                    break;
                case CalendarTypeMonth:
                    defaultTitle = @"月票房";
                    break;
                case CalendarTypeYear:
                    defaultTitle = @"年票房";
                    break;
                case CalendarTypeDangQI:
                    defaultTitle = @"档期票房";
                    break;
                case CalendarTypeCustom:
                    defaultTitle = @"自定义";
                    break;
                    
                default:
                    break;
            }
            [titleArray addObject:model.title.length>0?model.title:defaultTitle];
            [self setupCalendarSegment:model index:i];
            if (self.configDataSource.selectType == model.type) {
                scrollIndex = i;
            }
        }
        
        [self.segmentControl setTitleArray:titleArray];
        [self.rootScrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width*scrollIndex, 0) animated:NO];
        [self.segmentControl setSelectedIndex:scrollIndex animated:NO];
    }
}

- (void)setupCalendarSegment:(CalendarConfigModel *)model index:(int)index{
    __weak __typeof(&*self)weakSelf = self;
    if (model.type == CalendarTypeDay) {
        self.dayController.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.width*index, [UIScreen mainScreen].bounds.size.width, _scrollHeight);
        self.dayController.selType = self.configDataSource.selectType;
        [self.dayController setBizType:_configDataSource.bizType configModel:_configDataSource.bizConfigModel];
        self.dayController.selectionModel = _configDataSource.selModel;
        [self.rootScrollView addSubview:self.dayController.view];
        self.dayController.resultBlock = ^(MVPCalendarResultModel *model){
            if (weakSelf.rBlock) {
                weakSelf.rBlock(model);
            }
            [weakSelf quitViewController];
        };
    }else if(model.type == CalendarTypeWeek){
        self.weekController.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*index, 0, [UIScreen mainScreen].bounds.size.width, _scrollHeight);
        self.weekController.selType = self.configDataSource.selectType;
        [self.weekController setBizType:_configDataSource.bizType configModel:_configDataSource.bizConfigModel];
        self.weekController.isMult = model.isMult;
        self.weekController.selectionModel = _configDataSource.selModel;
        [self.rootScrollView addSubview:self.weekController.view];
        self.weekController.resultBlock = ^(MVPCalendarResultModel *model){
            if (weakSelf.rBlock) {
                weakSelf.rBlock(model);
            }
            [weakSelf quitViewController];
        };
    }else if(model.type == CalendarTypeMonth){
        self.monthController.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*index, 0, [UIScreen mainScreen].bounds.size.width, _scrollHeight);
        self.monthController.selType = self.configDataSource.selectType;
        [self.monthController setBizType:_configDataSource.bizType configModel:_configDataSource.bizConfigModel];
        self.monthController.isMult = model.isMult;
        self.monthController.selectionModel = _configDataSource.selModel;
        [self.rootScrollView addSubview:self.monthController.view];
        self.monthController.resultBlock = ^(MVPCalendarResultModel *model){
            if (weakSelf.rBlock) {
                weakSelf.rBlock(model);
            }
            [weakSelf quitViewController];
        };
    }else if(model.type == CalendarTypeYear){
        self.yearController.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*index, 0, [UIScreen mainScreen].bounds.size.width, _scrollHeight);
        self.yearController.selType = self.configDataSource.selectType;
        [self.yearController setBizType:_configDataSource.bizType configModel:_configDataSource.bizConfigModel];
        self.yearController.isMult = model.isMult;
        self.yearController.selectionModel = _configDataSource.selModel;
        [self.rootScrollView addSubview:self.yearController.view];
        self.yearController.resultBlock = ^(MVPCalendarResultModel *model){
            if (weakSelf.rBlock) {
                weakSelf.rBlock(model);
            }
            [weakSelf quitViewController];
        };
    }else if(model.type == CalendarTypeCustom){
        self.customController.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width*index, 0, [UIScreen mainScreen].bounds.size.width, _scrollHeight);
        self.customController.selType = self.configDataSource.selectType;
        [self.customController setBizType:_configDataSource.bizType configModel:_configDataSource.bizConfigModel];
        self.customController.selectionModel = _configDataSource.selModel;
        [self.rootScrollView addSubview:self.customController.view];
        self.customController.resultBlock = ^(MVPCalendarResultModel *model){
            if (weakSelf.rBlock) {
                weakSelf.rBlock(model);
            }
            [weakSelf quitViewController];
        };
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self refreshConfigDataSource];
    // ----> 改
    /*
     *
     self.titlebarView.defaultTitle = @"选择日期";
     MVPTitleBarItemView *leftBtn = [[MVPTitleBarItemView alloc] init];
     leftBtn.titleBarTag = @"close";
     [leftBtn setTitle:@"关闭" forState:UIControlStateNormal];
     leftBtn.titleLabel.font = UIPingfangFontWithSize(15);
     [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
     [leftBtn setTitleColor:[UIColor shy_colorWithHex:0x333333] forState:UIControlStateNormal];
     self.titlebarView.leftBarItems = @[leftBtn];
     */
    /// <-----
    
    UIView *titleView = [[UIView alloc] init];
    [titleView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@(64));
    }];
    
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:[UIColor shy_colorWithHex:0xd6dade]];
    [titleView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(titleView.mas_bottom);
        make.left.equalTo(titleView.mas_left);
        make.right.equalTo(titleView.mas_right);
        make.height.equalTo(@(0.5));
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:[UIFont systemFontOfSize:18]];
    [titleLabel setText:@"日历选择"];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView.mas_top);
        make.bottom.equalTo(titleView.mas_bottom);
        make.left.equalTo(titleView.mas_left).offset(100);
        make.right.equalTo(titleView.mas_right).offset(-100);
    }];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setTitle:@"关闭" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [leftBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [leftBtn setTitleColor:[UIColor shy_colorWithHex:0x333333] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(quitViewController) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(titleView.mas_centerY);
        make.left.equalTo(titleView.mas_left);
        make.height.equalTo(@(40));
        make.width.equalTo(@(50));
    }];
}



- (void)quitViewController{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark -- MVSegmentControlDelegate
- (void)segmentControlValueChanged:(MVSmoothSegmentControl *)segmentControl
{
    [self.rootScrollView setContentOffset:CGPointMake([UIScreen mainScreen].bounds.size.width*self.segmentControl.selectedIndex, 0) animated:NO];
}

- (void)segmentControl:(MVSegmentControl *)segmentControl didSelectButtonAtIndex:(NSInteger)index
{

}

#pragma mark - scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.rootScrollView) {
        CGFloat xOffset = scrollView.contentOffset.x;
        CGFloat percent = xOffset / ([UIScreen mainScreen].bounds.size.width * MAX(1, (self.segmentControl.titleArray.count - 1)));
        [self.segmentControl moveIndicateView:percent];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == self.rootScrollView) {
        CGFloat xOffset = scrollView.contentOffset.x;
        CGFloat percent = xOffset / ([UIScreen mainScreen].bounds.size.width * MAX(1, (self.segmentControl.titleArray.count - 1)));
        [self.segmentControl setSelectedIndex:percent * (self.segmentControl.numberOfSegments - 1)];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
