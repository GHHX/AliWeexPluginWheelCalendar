//
//  MVPCalendarViewController.h
//  MoviePro
//
//  Created by 风海 on 17/2/21.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MVPCalenarConfigModel.h"
@class MVPCalendarResultModel;

typedef void (^DayResult)(MVPCalendarResultModel *model);

@interface MVPCalendarViewController : UIViewController
@property (assign, nonatomic) NSUInteger selType;
@property (strong, nonatomic) MVPCalendarResultModel *selectionModel;
@property (copy, nonatomic) DayResult resultBlock;
- (void)setBizType:(long)bizType configModel:(MVPCalenarConfigModel *)bizConfigModel;
@end
