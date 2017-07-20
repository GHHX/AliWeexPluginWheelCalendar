//
//  MVPCalendarYearViewController.h
//  MoviePro
//
//  Created by 风海 on 17/3/3.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MVPCalenarConfigModel.h"

@class MVPCalendarResultModel;

typedef void (^YearResult)(MVPCalendarResultModel *model);

@interface MVPCalendarYearViewController : UIViewController
@property (assign, nonatomic) NSUInteger selType;
@property (assign, nonatomic) long targetYear;
@property (assign, nonatomic) BOOL isMult;
@property (assign, nonatomic) long limit;
@property (strong, nonatomic) MVPCalendarResultModel *selectionModel;
@property (copy, nonatomic) YearResult resultBlock;

- (void)setBizType:(long)bizType configModel:(MVPCalenarConfigModel *)bizConfigModel;
@end
