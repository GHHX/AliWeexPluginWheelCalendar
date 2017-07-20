//
//  MVPCalendarConfigModel.h
//  MoviePro
//
//  Created by 风海 on 17/3/5.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MVPCalendarResultModel.h"

@interface CalendarConfigModel : NSObject

@property (assign, nonatomic) CalendarType type;
@property (copy, nonatomic) NSString *title;
@property (assign, nonatomic) int isMult;
@property (assign, nonatomic) int maxUnit;

@end
@class MVPCalenarConfigModel;

@interface MVPCalendarConfigModel : NSObject

@property (assign, nonatomic) MVPCalendarBizType bizType;
@property (assign, nonatomic) CalendarType selectType;
@property (strong, nonatomic) MVPCalenarConfigModel *bizConfigModel;
@property (strong, nonatomic) MVPCalendarResultModel *selModel;
@property (strong, nonatomic) NSMutableArray<CalendarConfigModel *> *configArray;

@end
