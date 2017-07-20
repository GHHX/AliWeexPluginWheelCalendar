//
//  MVSegmentControl.h
//  MVCommonUI
//
//  Created by Chen Zhang on 12/18/14.
//  Copyright (c) 2014 Alipay. All rights reserved.
//
#ifndef _MVSEGMENTCONTROL_H_
#define _MVSEGMENTCONTROL_H_

#import <UIKit/UIKit.h>

@class MVSegmentControl;

/**
 * delegate for segment control.
 * used for some special case.
 */
@protocol MVSegmentControlDelegate <NSObject>

@optional
/**
 * return YES if you want delegate to take control of tap event on the specified button
 * return NO will cause the control itself to respond to the tap event
 */
- (BOOL)segmentControl:(MVSegmentControl *)segmentControl shouldResponseButtonAtIndex:(NSInteger)index;

- (void)segmentControl:(MVSegmentControl *)segmentControl doubleClickedAtIndex:(NSInteger)index;

@required
/**
 * actions the delegate will take when button tapped
 */
- (void)segmentControl:(MVSegmentControl *)segmentControl didSelectButtonAtIndex:(NSInteger)index;

@end

/**
 * flatten style of segment control. 
 * If it exceeds bounds of screen, user can scroll it.
 */

@interface MVSegmentControl : UIControl

- (instancetype) initWithTitles: (NSArray *) titles;

@property (nonatomic, weak) id<MVSegmentControlDelegate> delegate;
@property (nonatomic, readonly) NSUInteger numberOfSegments;
@property (nonatomic, assign)   NSInteger selectedIndex;
@property (nonatomic, assign)   CGFloat titleFontSize;

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray<NSNumber *> *hasIconArray; //array of NSNumber boolValue?

@property (nonatomic, assign) BOOL fullFit;
@property (nonatomic, assign) BOOL fullFitAndScrollable;        // 至少满屏，tab多时可滚动

@property (nonatomic, strong) UIView *topSeperatorLine;
@property (nonatomic, strong) UIView *bottomSeperatorLine;

- (void)sendButtonActionAtIndex:(NSInteger)index;
- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated;

@end

#endif
