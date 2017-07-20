//
//  MVPCommonUtils.m
//  WeexPluginCalendar
//
//  Created by 风海 on 2017/7/12.
//  Copyright © 2017年 weexplugin. All rights reserved.
//

#import "MVPCommonUtils.h"

static NSCalendar *calendar;
static NSDateFormatter *chineseDateFormater;

@implementation MVPCommonUtils

+ (NSCalendar *)configCurrentCalendar{
    if(!calendar){
        calendar = [NSCalendar autoupdatingCurrentCalendar];
        //验证设置是否成功
        [calendar setFirstWeekday:2];
        [calendar setMinimumDaysInFirstWeek:7];
    }
    return calendar;
}

+ (NSDate*)chineseDateWithYear:(int)year month:(int)month day:(int)day{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    cal.firstWeekday = 2;
    cal.minimumDaysInFirstWeek = 7;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = year;
    comps.month = month;
    comps.day = day;
    
    NSDate *date = [cal dateFromComponents:comps];
    date = [self chineseDateFromGregorianDate:date];
    return date;
}

+ (NSDate*)chineseDateFromGregorianDate:(NSDate*)date{
    return [NSDate dateWithTimeInterval:3600 * 8 sinceDate:date];
}

+ (NSDateComponents*)dateComponensWithDateStr:(NSString*)dateStr{
    NSDateFormatter *formater = [NSDateFormatter new];
    [formater setDateFormat:@"yyyyMMdd"];
    NSDate *date = [formater dateFromString:dateStr];
    
    return [self dateComponensWithDate:date];
}

+ (NSDateComponents*)dateComponensWithDate:(NSDate*)date{
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    cal.firstWeekday = 2;
    cal.minimumDaysInFirstWeek = 7;
    NSInteger unitFlags = NSCalendarUnitWeekday | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear;
    NSDateComponents *comps = [cal components:unitFlags fromDate:date];
    return comps;
}

+ (NSUInteger)getDaysBetweenOneDay:(NSDate *)aDate otherDay:(NSDate *)bDate{
    NSTimeInterval timeInterval = [aDate timeIntervalSinceDate:bDate];
    NSUInteger days;
    days = ((NSUInteger)timeInterval)/(3600*24);
    return days;
}

+ (NSMutableDictionary *)getDateInfo:(NSDate *)date{
    [self configCurrentCalendar];
    NSMutableDictionary *infoDate = [NSMutableDictionary dictionary];
    NSDateComponents *dateComps = [calendar components:(NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                              fromDate:date];
    [infoDate setObject:@([dateComps year]) forKey:@"year"];
    [infoDate setObject:@([dateComps month]) forKey:@"month"];
    [infoDate setObject:@([dateComps day]) forKey:@"day"];
    
    return infoDate;
}

+ (NSString*)chinesePlainDateStringForDate:(NSDate*)date{
    NSDateFormatter *formater = [self chineseDateFormater];
    [formater setDateFormat:@"yyyyMMdd"];
    return [formater stringFromDate:date];
}

+ (NSDateFormatter*)chineseDateFormater{
    if (!chineseDateFormater) {
        chineseDateFormater = [NSDateFormatter new];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
        [chineseDateFormater setTimeZone:timeZone];
    }
    [chineseDateFormater setDateFormat:@"yyyyMd"];
    return chineseDateFormater;
}

+ (NSUInteger)getDaysBetweenDay:(NSString *)aDate otherDay:(NSString *)bDate{
    
    NSDateFormatter *formater = [self chineseDateFormater];
    [formater setDateFormat:@"yyyyMMdd"];
    NSDate *sdate = [formater dateFromString:aDate];
    NSDate *edate = [formater dateFromString:bDate];
    NSTimeInterval timeInterval = [edate timeIntervalSinceDate:sdate];
    NSUInteger days;
    days = ((NSUInteger)timeInterval)/(3600*24);
    return days;
}

+ (BOOL)isYearFirstDay:(uint64_t)timestamp currentDate:(NSDate *)currentDate{
    if (!currentDate) {
        currentDate = [NSDate date];
    }
    [self configCurrentCalendar];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    [formatter setDateFormat:@"yyyy"];
    NSString *dateStr = [formatter stringFromDate:currentDate];
    dateStr = [dateStr stringByAppendingString:@"-02-14"];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    
    
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitYear startDate:&firstDay interval:nil forDate:currentDate];
    
    NSDate *date;
    if (timestamp > 0) {
        date = [[NSDate alloc] initWithTimeIntervalSince1970:timestamp/1000.0];
    }else{
        date = currentDate;
    }
    
    if ([[self chinesePlainDateStringForDate:date] isEqualToString:[self chinesePlainDateStringForDate:firstDay]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isMonthFirstDay:(uint64_t)timestamp currentDate:(NSDate *)currentDate{
    if (!currentDate) {
        currentDate = [NSDate date];
    }
    [self configCurrentCalendar];
    NSDate *firstDay;
    [calendar rangeOfUnit:NSCalendarUnitMonth startDate:&firstDay interval:nil forDate:currentDate];
    NSDate *date;
    if (timestamp > 0) {
        date = [[NSDate alloc] initWithTimeIntervalSince1970:timestamp/1000.0];
    }else{
        date = currentDate;
    }
    if ([[self chinesePlainDateStringForDate:date] isEqualToString:[self chinesePlainDateStringForDate:firstDay]]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isWeekFirstDay:(uint64_t)timestamp currentDate:(NSDate *)currentDate{
    if (!currentDate) {
        currentDate = [NSDate date];
    }
    [self configCurrentCalendar];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:currentDate];
    NSInteger weekday = [dateComponents weekday];
    NSInteger firstDiff;
    if (weekday == 1) {
        firstDiff = -6;
    }else {
        firstDiff = -weekday + 2;
    }
    NSInteger day = [dateComponents day];
    NSDateComponents *firstComponents = [calendar components:NSCalendarUnitWeekday | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:currentDate];
    [firstComponents setDay:day + firstDiff];
    NSDate *firstDay = [calendar dateFromComponents:firstComponents];
    NSDate *date;
    if (timestamp > 0) {
        date = [[NSDate alloc] initWithTimeIntervalSince1970:timestamp/1000.0];
    }else{
        date = currentDate;
    }
    if ([[self chinesePlainDateStringForDate:date] isEqualToString:[self chinesePlainDateStringForDate:firstDay]]) {
        return YES;
    }
    return NO;
}


+ (long)getMonthCountBy:(NSDate *)date{
    [self configCurrentCalendar];
    NSRange days = [calendar rangeOfUnit:NSCalendarUnitDay
                                  inUnit:NSCalendarUnitMonth
                                 forDate:date];
    return days.length;
}

+ (NSInteger)getWeekNumByYear:(NSInteger)year{
    [self configCurrentCalendar];
    NSString *timeAxis = [NSString stringWithFormat:@"%ld-12-31 12:00:00",(long)year];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:timeAxis];
    NSInteger length = [calendar ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitYear forDate:date];
    return length;
}

+ (NSMutableArray *)getWeeksByLastYear:(NSInteger)year{
    NSMutableArray *weeks = [NSMutableArray array];
    if (year >= 2011 & year <= 9999) {
        NSInteger weekNum = [self getWeekNumByYear:year];
        for (NSInteger j = weekNum;j > 0;j--) {
            NSMutableDictionary *weekDic = [self dateInfoConversionYear:year WeakOfYear:j];
            NSString *weekInfo = [weekDic objectForKey:@"weekDate"];
            NSString *result = [NSString stringWithFormat:@"第%ld周 (%@)",j,weekInfo];
            [weekDic setObject:result forKey:@"result"];
            [weekDic setObject:@(j) forKey:@"weekNum"];
            [weeks addObject:weekDic];
        }
    }
    return weeks;
}

+ (NSMutableDictionary *)dateInfoConversionYear:(NSInteger)year WeakOfYear:(NSInteger)weekofYear {
    [self configCurrentCalendar];
    NSString *weekDate = @"";
    NSString *timeAxis = [NSString stringWithFormat:@"%ld-06-01 12:00:00",(long)year];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:timeAxis];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                          fromDate:date];
    NSInteger todayIsWeek = [comps weekOfYear];
    NSInteger todayIsWeekDay = [comps weekday];
    long firstDiff,lastDiff;
    if (todayIsWeekDay == 1) {
        firstDiff = -6;
        lastDiff = 0;
    }else
    {
        firstDiff = [calendar firstWeekday] - todayIsWeekDay;
        lastDiff = 8 - todayIsWeekDay;
    }
    NSDate *firstDayOfWeek = [NSDate dateWithTimeInterval:24*60*60*firstDiff sinceDate:date];
    NSDate *lastDayOfWeek = [NSDate dateWithTimeInterval:24*60*60*lastDiff sinceDate:date];
    long weekdifference = weekofYear - todayIsWeek;
    firstDayOfWeek = [NSDate dateWithTimeInterval:24*60*60*7*weekdifference sinceDate:firstDayOfWeek];
    lastDayOfWeek = [NSDate dateWithTimeInterval:24*60*60*7*weekdifference sinceDate:lastDayOfWeek];
    NSDateComponents *firstDayOfWeekcomps = [calendar components:(NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                        fromDate:firstDayOfWeek];
    NSDateComponents *lastDayOfWeekcomps = [calendar components:(NSCalendarUnitWeekOfYear | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay)
                                                       fromDate:lastDayOfWeek];
    NSInteger startMonth = [firstDayOfWeekcomps month];
    NSInteger startDay = [firstDayOfWeekcomps day];
    NSInteger startyear = [firstDayOfWeekcomps year];
    
    NSInteger endmonth = [lastDayOfWeekcomps month];
    NSInteger endday = [lastDayOfWeekcomps day];
    NSInteger endyear = [lastDayOfWeekcomps year];
    
    weekDate = [NSString stringWithFormat:@"%ld月%ld日-%ld月%ld日",(long)startMonth,(long)startDay,(long)endmonth,(long)endday];
    
    NSMutableDictionary *weekDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:weekDate,@"weekDate",@(startMonth),@"startMonth",@(startDay),@"startDay",@(endmonth),@"endmonth",@(endday),@"endday",@(startyear),@"startyear",@(endyear),@"endyear", nil];
    
    return weekDic;
}

+ (NSInteger)getNowWeek{
    [self configCurrentCalendar];
    NSDateComponents *comps = [calendar components:(NSCalendarUnitWeekOfYear|NSCalendarUnitWeekday) fromDate:[self chineseNowDateFromGregorianDate]];
    return [comps weekOfYear];
}

+ (NSDate*)chineseNowDateFromGregorianDate{
    NSDate *today = [NSDate date];
    return [NSDate dateWithTimeInterval:3600 * 8 sinceDate:today];
}

+ (NSDate*)chineseDateFromPainDateStr:(NSString*)dateStr{
    NSDateFormatter *formater = [self chineseDateFormater];
    [formater setDateFormat:@"yyyyMMdd"];
    return [formater dateFromString:dateStr];
}

+(NSDate *)getPreDate:(NSDate *)date days:(NSInteger)days{
    NSDate *preDay = [NSDate dateWithTimeInterval:-24*60*60*days sinceDate:date];
    return preDay;
}

+(NSDate *)getNextDate:(NSDate *)date days:(NSInteger)days{
    NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60*days sinceDate:date];
    return nextDay;
}

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    [self configCurrentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]==[comp2 day]&&[comp1 month]==[comp2 month]&&[comp1 year]==[comp2 year];
}

+ (BOOL)isLessDay:(NSString*)aDate date2:(NSString*)bDate{
    NSDateFormatter *formater = [self chineseDateFormater];
    [formater setDateFormat:@"yyyyMMdd"];
    NSDate *sdate = [formater dateFromString:aDate];
    NSDate *edate = [formater dateFromString:bDate];
    if ([sdate compare:edate] == NSOrderedAscending){
        return YES;
    }
    return NO;
}

@end
