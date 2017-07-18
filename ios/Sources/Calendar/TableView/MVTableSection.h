//
//  MVTableSection.h
//  MVCommonUI
//
//  Created by 念纪 on 14/11/24.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//
#ifndef _MVTABLESECTION_H_
#define _MVTABLESECTION_H_

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MVNode.h"

NS_ASSUME_NONNULL_BEGIN

@class MVTableRow;
@interface MVTableSection : MVNode


@property (nonatomic, assign) CGFloat height DEPRECATED_MSG_ATTRIBUTE("deprecated, please use headerHeight/footerHeight instead");


@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;

/*
 * when section folds, all rows belong to the cell are hidden
 */
@property (nonatomic, assign) BOOL folded;
@property (nonatomic, copy, nullable) void (^onClickBlock)(MVTableSection* section);
@property (nonatomic, copy, nullable) NSString *title;

+ (MVTableSection *)sectionWithTitle:(NSString *)title;
+ (MVTableSection *)sectionWithImage:(UIImage *)image;

- (id)initWithTitle:(NSString *)title;
- (id)initWithImage:(UIImage *)image;
- (id)initWithCustomView:(UIView *)customView;

- (UITableViewHeaderFooterView *)viewForTableView:(UITableView *)tableView;

- (UITableViewHeaderFooterView *)viewForHeaderInTableView:(UITableView *)tableView section:(NSInteger)section;
- (UITableViewHeaderFooterView *)viewForFooterInTableView:(UITableView *)tableView section:(NSInteger)section;
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section;
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(nonnull UIView *)view forSection:(NSInteger)section;

- (CGFloat)heightForHeaderInTableView:(UITableView *)tableView inSection:(NSInteger)section;
- (CGFloat)heightForFooterInTableView:(UITableView *)tableView inSection:(NSInteger)section;

- (nullable NSArray *)allRows;
- (void)setAllRows:(nullable NSArray *)rows;

- (nullable __kindof MVTableRow *)rowAtIndex:(NSUInteger)index;

- (void)addRow:(nullable MVTableRow *)row;
- (void)addRowsFromArray:(nullable NSArray *)array;

- (void)removeChildrenWithClass:(Class)childClass;

- (NSUInteger)section;

@end

NS_ASSUME_NONNULL_END

#endif
