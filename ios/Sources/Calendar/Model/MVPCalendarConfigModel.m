//
//  MVPCalendarConfigModel.m
//  MoviePro
//
//  Created by 风海 on 17/3/5.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPCalendarConfigModel.h"

@implementation CalendarConfigModel

+ (instancetype)createModelWithType:(CalendarType)type title:(NSString*)title isMult:(int)isMult maxUnit:(int)maxUnit selModel:(MVPCalendarResultModel*)selModel{
    CalendarConfigModel *ret = [CalendarConfigModel new];
    ret.type = type;
    ret.title = title;
    ret.isMult = isMult;
    ret.maxUnit = maxUnit;
    return ret;
}

@end

@implementation MVPCalendarConfigModel

- (instancetype)copyWithZone:(NSZone *)zone{
    MVPCalendarConfigModel *ret = [MVPCalendarConfigModel new];
    ret.selectType = self.selectType;
    ret.bizType = self.bizType;
    ret.bizConfigModel = self.bizConfigModel;
    ret.configArray = [self.configArray mutableCopy];
    
    return ret;
}

- (CalendarConfigModel*)currcentCalendarModel{
    return [self calendarModelByType:self.selectType];
}

- (CalendarConfigModel*)calendarModelByType:(CalendarType)type{
    for (CalendarConfigModel *item in self.configArray) {
        if (item.type == self.selectType) {
            return item;
        }
    }
    
    return nil;
}

@end
