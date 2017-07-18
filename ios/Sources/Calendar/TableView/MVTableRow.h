//
//  MVTableRow.h
//  MVCommonUI
//
//  Created by 念纪 on 14/11/24.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//
#ifndef _MVTABLEROW_H_
#define _MVTABLEROW_H_

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MVNode.h"

@class MVTableSection;

NS_ASSUME_NONNULL_BEGIN

@class MVTableView;

typedef void (^MVTableRowClickedBlock)(MVTableView *tableView, NSIndexPath *indexPath);

@interface MVTableRow : MVNode

@property (nonatomic, copy) MVTableRowClickedBlock clickedBlock;

@property(nonatomic, assign, readwrite) CGFloat cellHeight;


/**
 *  是否根据内容自动适应cell的高度，子类重载，不要同时重载cellHeight方法
 *  @return bool
 */
- (BOOL)autoAdjustCellHeight;

- (__kindof UITableViewCell *) cellForTableViewAutoAdjust;

/**
 * 如果要自动适应 cell 的高度，必须实现此方法返回重用标记
 */
- (NSString *) reuseIdentifier;

/**
 * 如果要自动适应 cell 的高度，必须实现此方法创建实例
 */
- (__kindof UITableViewCell *) createCellForAutoAdjustedTableViewCell;

/**
 *  配合`- (BOOL)autoAdjustCellHeight`，当已自动计算过的cell的constraint发生变化后，调用该方法
 *  @warning 已经显示的Cell不会自动调整高度，需要在调用此方法后手动reload对应row
 *  @see autoAdjustCellHeight
 */
- (void)invalidateAutoCellHeight;

/**
 *  Creates a new cell that the table view row manages.
 *
 *  @return The newly created cell that the row manages.
 */
- (__kindof UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

- (void)updateCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath;

- (nullable NSIndexPath *)indexPath;

/**
 * 如果不需要对整个 cell 做 autolayout，可以返回替代的 view，默认返回空
 */
- (nullable UIView *) autoLayoutView;

/**
 * optional, 可以在 row 中处理 cell 的 willDisplayCell 方法
 */
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 * optional, 可以在 row 中处理 cell 的 endDisplayCell 方法
 */
- (void) tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

- (CGFloat) estimatedHeight;

- (CGFloat)tableView:(UITableView*)tableView cellHeightAtIndexPath:(NSIndexPath*)indexPath;
/**
 * Override point, row被加到section前后以后会调用以下方法，默认实现为空
 */
- (void) rowWillAddToSection:(MVTableSection *)section NS_REQUIRES_SUPER;
- (void) rowDidAddToSection:(MVTableSection *)section NS_REQUIRES_SUPER;


@end


NS_ASSUME_NONNULL_END
#endif
