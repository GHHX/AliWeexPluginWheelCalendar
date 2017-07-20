//
//  MVTableBaseRow.h
//  MVCommonUI
//
//  Created by Chen Zhang on 7/12/16.
//  Copyright © 2016 Alipay. All rights reserved.
//
#ifndef _MVTABLEBASEROW_H_
#define _MVTABLEBASEROW_H_
#import "MVTableRow.h"

@interface MVTableBaseRow : MVTableRow
/* set cellHeight after setting attachedView */
@property (nonatomic, strong) UIView *attachedView;
@property (nonatomic, assign) CGFloat attachedViewHeight;

//if attachedView has intrinsicContentSize, do not set attachedViewHeight or cellHeight later
- (void) setAutoLayoutEnabledAttachedView:(UIView *)view;

@end

#endif
