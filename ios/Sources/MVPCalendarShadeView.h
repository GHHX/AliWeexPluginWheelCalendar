//
//  MVPCalendarShadeView.h
//  MoviePro
//
//  Created by 风海 on 17/3/17.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MVPCalendarShadeType) {
    MVPShadeTypeTop = 0,
    MVPShadeTypeMiddle,
    MVPShadeTypeDown
};

@interface MVPCalendarShadeView : UIView

- (void)setContent:(NSString *)content;
- (void)showShadeViewWithType:(MVPCalendarShadeType)shadeType bgView:(UIView *)view;
- (void)hideShadeView;

- (void)momentShowShadeViewWithType:(MVPCalendarShadeType)shadeType bgView:(UIView *)view;
@end
