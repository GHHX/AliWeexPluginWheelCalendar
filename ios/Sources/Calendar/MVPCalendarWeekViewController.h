//
//  MVPCalendarWeekViewController.h
//  MoviePro
//
//  Created by 风海 on 17/3/4.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MVPCalenarConfigModel.h"
@class MVPCalendarResultModel;

typedef void (^WeekResult)(MVPCalendarResultModel *model);

@interface MVPCalendarWeekViewController : UIViewController

@property (assign, nonatomic) NSUInteger selType;
@property (assign, nonatomic) long targetYear;
@property (assign, nonatomic) long targetWeek;
@property (assign, nonatomic) BOOL isMult;
@property (assign, nonatomic) long limit;

@property (strong, nonatomic) MVPCalendarResultModel *selectionModel;

@property (copy, nonatomic) WeekResult resultBlock;

- (void)setBizType:(long)bizType configModel:(MVPCalenarConfigModel *)bizConfigModel;
@end
