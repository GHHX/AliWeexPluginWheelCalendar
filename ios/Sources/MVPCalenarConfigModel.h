//
//  MVPCalenarConfigModel.h
//  WeexPluginCalendar
//
//  Created by 风海 on 2017/7/12.
//  Copyright © 2017年 weexplugin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVPCalenarConfigModel : NSObject

@property (assign, nonatomic) long maxDays;
@property (assign, nonatomic) long maxMoths;
@property (assign, nonatomic) long maxWeeks;
@property (assign, nonatomic) long maxYears;
@property (assign, nonatomic) BOOL presaleForRange;
@property (assign, nonatomic) BOOL presaleForSingle;
@property (assign, nonatomic) int singleDayDelta;
@property (assign, nonatomic) int rangeDayDelta;
@property (assign, nonatomic) int weekDelta;
@property (assign, nonatomic) int monthDelta;
@property (assign, nonatomic) int yearDelta;
@property (assign, nonatomic) int periodDelta;
@property (assign, nonatomic) uint64_t currentTs;
@property (assign, nonatomic) NSInteger isSkipFirstDay;
@property (copy, nonatomic) NSString *startDate;

- (instancetype)initWithDefaultData;
- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
