//
//  MVPScheduleModel.h
//  MoviePro
//
//  Created by 风海 on 17/3/8.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MVPScheduleDataModel;
@class MVPCalendarItemModel;
@class MVPCalendarItem;

@protocol MVPCalendarItem
@end
@interface MVPCalendarItem : NSObject
@property (copy, nonatomic) NSString *beginDate;
@property (copy, nonatomic) NSString *endDate;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) long displayOrder;
@property (assign, nonatomic) long type;
@property (assign, nonatomic) long vid;
@property (assign, nonatomic) long year;

@end

@protocol MVPCalendarItemModel
@end
@interface MVPCalendarItemModel : NSObject

@property (strong, nonatomic) NSMutableArray<MVPCalendarItem> *calendarItemList;
@property (assign, nonatomic) long year;

@end

@interface MVPScheduleDataModel : NSObject

@property (copy, nonatomic) NSString *checksum;
@property (strong, nonatomic) NSMutableArray<MVPCalendarItemModel> *list;

@end

@interface MVPScheduleModel : NSObject

@property (strong, nonatomic) MVPScheduleDataModel *data;

@end

