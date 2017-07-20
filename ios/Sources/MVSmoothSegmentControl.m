//
//  MVSmoothSegmentControl.m
//  MVDamai
//
//  Created by Erick Xi on 7/28/16.
//  Copyright © 2016 Alipay. All rights reserved.
//

#import "MVSmoothSegmentControl.h"

@interface MVSegmentControl ()

@property (nonatomic, strong) UIScrollView *segmentScrollView;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIView *indictorView;
@property (nonatomic, assign) CGFloat segmentWidth;
@property (nonatomic, strong) UIFont *titleFont;

- (CGFloat)indicatorWidth;

@end

@implementation MVSmoothSegmentControl

- (void)moveIndicateView:(CGFloat)percent
{
    CGFloat offset = self.fullFit ? 15 : 6;
    CGRect rect = self.indictorView.frame;
    CGRect frame = CGRectMake(offset + percent * ((self.numberOfSegments - 1) * self.segmentWidth) - 2, rect.origin.y, CGRectGetWidth(rect), CGRectGetHeight(rect));
    [self.indictorView setFrame:frame];
}

@end
