//
//  MVPCalenarConfigModel.m
//  WeexPluginCalendar
//
//  Created by 风海 on 2017/7/12.
//  Copyright © 2017年 weexplugin. All rights reserved.
//

#import "MVPCalenarConfigModel.h"
#import "NSDictionary+SHYUtil.h"

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
        _maxDays = [dic shy_longForKey:@"maxDays"];
        _maxMoths = [dic shy_longForKey:@"maxMoths"];
        _maxWeeks = [dic shy_longForKey:@"maxWeeks"];
        _maxYears = [dic shy_longForKey:@"maxYears"];
        _presaleForRange = [dic shy_boolForKey:@"presaleForRange"];
        _presaleForSingle = [dic shy_boolForKey:@"presaleForSingle"];
        _singleDayDelta = [dic shy_intForKey:@"singleDayDelta"];
        _rangeDayDelta = [dic shy_intForKey:@"rangeDayDelta"];
        _weekDelta = [dic shy_intForKey:@"weekDelta"];
        _monthDelta = [dic shy_intForKey:@"monthDelta"];
        _yearDelta = [dic shy_intForKey:@"yearDelta"];
        _periodDelta = [dic shy_intForKey:@"periodDelta"];
        _currentTs = [dic shy_longLongForKey:@"currentTs"];
        _isSkipFirstDay = [dic shy_integerForKey:@"isSkipFirstDay"];
        _startDate = [dic shy_stringForKey:@"startDate"];
    }
    return self;
}

@end
