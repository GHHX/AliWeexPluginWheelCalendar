//
//  MVPCalendarResultModel.h
//  MoviePro
//
//  Created by 风海 on 17/3/5.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVPCalenarConfigModel.h"

typedef NS_ENUM(NSUInteger, CalendarType) {
    CalendarTypeDay = 0,
    CalendarTypeWeek,
    CalendarTypeMonth,
    CalendarTypeSeason,
    CalendarTypeYear,
    CalendarTypeDangQI,
    CalendarTypeCustom
};

typedef NS_ENUM(NSUInteger, MVPCalendarBizType) {
    MVPCalendarBizTypeBoxOffice = 1,
    MVPCalendarBizTypeSchedule = 2,
    MVPCalendarBizTypeCenima = 3,
    MVPCalendarBizTypeFilm = 4
};

@interface MVPCalendarModel : NSObject <NSCopying>

@property (assign, nonatomic) long year;
@property (assign, nonatomic) long month;
@property (assign, nonatomic) long week;
@property (assign, nonatomic) long day;

@property (assign, nonatomic) long weekYear;
@property (assign, nonatomic) long periodYear;

+ (instancetype)createModelWithYear:(long)year month:(long)month week:(long)week day:(long)day;

- (NSString*)stringOfCalendar;
+ (instancetype)createModelFromPlainDateString:(NSString*)dateStr;
+ (instancetype)createModelWithGregorianDate:(NSDate*)date;
@end

@class MVPCalendarModel;
@interface MVPCalendarResultModel : NSObject

@property (assign, nonatomic) MVPCalendarBizType bizType;
@property (strong, nonatomic) MVPCalenarConfigModel *bizConfigModel;
@property (assign, nonatomic) CalendarType type;
@property (copy, nonatomic) NSString *typeName;
@property (strong, nonatomic) MVPCalendarModel *startModel;
@property (strong, nonatomic) MVPCalendarModel *endModel;

@end
