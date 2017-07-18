//
//  MVPCalendarRootViewController.h
//  MoviePro
//
//  Created by 风海 on 17/2/21.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MVPCalendarConfigModel;
@class MVPCalendarResultModel;

typedef void(^MVPCalendarResusltBlock)(MVPCalendarResultModel *model);

@interface MVPCalendarRootViewController : UIViewController

@property (copy, nonatomic) MVPCalendarResusltBlock rBlock;
@property (strong, nonatomic) MVPCalendarConfigModel *configDataSource;

@end
