//
//  MVPCalendarResultModel.m
//  MoviePro
//
//  Created by 风海 on 17/3/5.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPCalendarResultModel.h"
#import "MVPCommonUtils.h"

@implementation MVPCalendarModel

+ (instancetype)createModelWithYear:(long)year month:(long)month week:(long)week day:(long)day{
    MVPCalendarModel *ret = [MVPCalendarModel new];
    ret.year = year;
    ret.month = month;
    ret.week = week;
    ret.day = day;
    
    return ret;
}

- (id)copyWithZone:(NSZone *)zone{
    MVPCalendarModel *copyItem = [MVPCalendarModel new];
    copyItem.year = self.year;
    copyItem.month = self.month;
    copyItem.day = self.day;
    copyItem.week = self.week;
    copyItem.weekYear = self.weekYear;
    copyItem.periodYear = self.periodYear;
    return copyItem;
}

- (NSString*)stringOfCalendar{
    
    
    NSDate *date = [MVPCommonUtils chineseDateWithYear:(int)self.year month:(int)self.month day:(int)self.day];
    NSDateFormatter *formater = [NSDateFormatter new];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formater setDateFormat:@"yyyyMMdd"];
    [formater setTimeZone:timeZone];
    return [formater stringFromDate:date];
}

//datestr 为 @“20170311“格式
+ (instancetype)createModelFromPlainDateString:(NSString*)dateStr{
    MVPCalendarModel *ret = [MVPCalendarModel new];
    NSDateComponents *comps = [MVPCommonUtils dateComponensWithDateStr:dateStr];
    ret.year = comps.year;
    ret.week = comps.weekOfYear;
    ret.month = comps.month;
    ret.day = comps.day;
    return ret;
}

+ (instancetype)createModelWithGregorianDate:(NSDate*)date{
    NSDateComponents *comps = [MVPCommonUtils dateComponensWithDate:date];
    MVPCalendarModel *ret = [MVPCalendarModel new];
    ret.year = comps.year;
    ret.week = comps.weekOfYear;
    ret.month = comps.month;
    ret.day = comps.day;
    return ret;
}


@end

@implementation MVPCalendarResultModel
+ (instancetype)createModelWithType:(CalendarType)type typeName:(NSString*)typeName startModel:(MVPCalendarModel*)start endModel:(MVPCalendarModel*)end{
    MVPCalendarResultModel *ret = [MVPCalendarResultModel new];
    ret.type = type;
    ret.typeName = typeName;
    ret.startModel = start;
    ret.endModel = end;
    return ret;
}

- (BOOL)isEqual:(MVPCalendarResultModel*)object{
    if (self.type == object.type
        && [[self.startModel stringOfCalendar] isEqualToString:[object.startModel stringOfCalendar]]
        && [[self.endModel stringOfCalendar] isEqualToString:[object.endModel stringOfCalendar]]) {
        return YES;
    }
    
    return NO;
}

- (id)copyWithZone:(NSZone *)zone{
    MVPCalendarResultModel *copyItem = [MVPCalendarResultModel new];
    
    copyItem.type = self.type;
    copyItem.bizType = self.bizType;
    copyItem.typeName = self.typeName;
    copyItem.startModel = [self.startModel copy];
    copyItem.endModel = [self.endModel copy];
    copyItem.bizConfigModel = [self.bizConfigModel copy];
    return copyItem;
}

@end
