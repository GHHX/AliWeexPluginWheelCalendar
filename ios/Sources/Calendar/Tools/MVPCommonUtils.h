//
//  MVPCommonUtils.h
//  WeexPluginCalendar
//
//  Created by 风海 on 2017/7/12.
//  Copyright © 2017年 weexplugin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVPCommonUtils : NSObject

+ (NSDate*)chineseDateWithYear:(int)year month:(int)month day:(int)day;
+ (NSDateComponents*)dateComponensWithDateStr:(NSString*)dateStr;
+ (NSDateComponents*)dateComponensWithDate:(NSDate*)date;
+ (NSUInteger)getDaysBetweenOneDay:(NSDate *)aDate otherDay:(NSDate *)bDate;
+ (NSMutableDictionary *)getDateInfo:(NSDate *)date;
+ (BOOL)isYearFirstDay:(uint64_t)timestamp currentDate:(NSDate *)currentDate;
+ (BOOL)isMonthFirstDay:(uint64_t)timestamp currentDate:(NSDate *)currentDate;
+ (BOOL)isWeekFirstDay:(uint64_t)timestamp currentDate:(NSDate *)currentDate;
+ (NSUInteger)getDaysBetweenDay:(NSString *)aDate otherDay:(NSString *)bDate;
+ (long)getMonthCountBy:(NSDate *)date;
+ (NSInteger)getWeekNumByYear:(NSInteger)year;
+ (NSMutableArray *)getWeeksByLastYear:(NSInteger)year;
+ (NSInteger)getNowWeek;
+ (NSDate*)chineseDateFromPainDateStr:(NSString*)dateStr;
+ (NSDateFormatter*)chineseDateFormater;
+ (NSDate *)getPreDate:(NSDate *)date days:(NSInteger)days;
+ (NSDate *)getNextDate:(NSDate *)date days:(NSInteger)days;

+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2;
+ (BOOL)isLessDay:(NSString*)aDate date2:(NSString*)bDate;

@end
