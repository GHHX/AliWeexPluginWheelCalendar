//
//  MVPCalenarConfigModel.m
//  WeexPluginCalendar
//
//  Created by 风海 on 2017/7/12.
//  Copyright © 2017年 weexplugin. All rights reserved.
//

#import "MVPCalenarConfigModel.h"

@implementation MVPCalenarConfigModel
- (instancetype)initWithDefaultData{
    self = [super init];
    if (self) {
        _maxDays = 90;
        _maxMoths = 8;
        _maxWeeks = 8;
        _maxYears = 8;
        _startDate = @"20110101";
        _presaleForRange = YES;
        _presaleForSingle = YES;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _maxDays = [[dic objectForKey:@"maxDays"] longValue];
        _maxMoths = [[dic objectForKey:@"maxMoths"] longValue];
        _maxWeeks = [[dic objectForKey:@"maxWeeks"] longValue];
        _maxYears = [[dic objectForKey:@"maxYears"] longValue];
        _presaleForRange = [[dic objectForKey:@"presaleForRange"] boolValue];
        _presaleForSingle = [[dic objectForKey:@"presaleForSingle"] boolValue];
        _singleDayDelta = [[dic objectForKey:@"singleDayDelta"] intValue];
        _rangeDayDelta = [[dic objectForKey:@"rangeDayDelta"] intValue];
        _weekDelta = [[dic objectForKey:@"weekDelta"] intValue];
        _monthDelta = [[dic objectForKey:@"monthDelta"] intValue];
        _yearDelta = [[dic objectForKey:@"yearDelta"] intValue];
        _periodDelta = [[dic objectForKey:@"periodDelta"] intValue];
        _currentTs = [[dic objectForKey:@"currentTs"] longLongValue];
        _isSkipFirstDay = [[dic objectForKey:@"isSkipFirstDay"] integerValue];
        _startDate = [dic objectForKey:@"startDate"];
    }
    return self;
}

@end
