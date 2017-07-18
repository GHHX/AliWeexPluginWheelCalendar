//
//  MVPConfirmMenuView.h
//  MoviePro
//
//  Created by 风海 on 17/3/2.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^ResultBlock)(NSString *startDate, NSString *endDate);

@interface MVPConfirmMenuView : UIView

@property (copy, nonatomic) ResultBlock resultBlock;

- (void)setStartDate:(NSString *)startDate endDate:(NSString *)endDate;
@end
