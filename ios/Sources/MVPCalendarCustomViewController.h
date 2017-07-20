//
//  MVPCalendarCustomViewController.h
//  MoviePro
//
//  Created by 风海 on 17/3/4.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MVPCalendarResultModel.h"

typedef void (^CustomDayResult)(MVPCalendarResultModel *model);

@interface MVPCalendarCustomViewController : UIViewController
@property (assign, nonatomic) NSUInteger selType;
@property (assign, nonatomic) long limit;

@property (strong, nonatomic) MVPCalendarResultModel *selectionModel;

@property (copy, nonatomic) CustomDayResult resultBlock;

- (void)setBizType:(long)bizType configModel:(MVPCalenarConfigModel *)bizConfigModel;
@end
