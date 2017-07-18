//
//  MVTableViewDataSource.h
//  MVCommonUI
//
//  Created by 念纪 on 14/11/24.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//
#ifndef _MVTABLEVIEWDATASOURCE_H_
#define _MVTABLEVIEWDATASOURCE_H_

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MVNode.h"

@class MVTableSection;
@class MVTableRow;

NS_ASSUME_NONNULL_BEGIN

@protocol MVTableViewDataSource <NSObject>

/**
 * A convenient utility method for retrieving the row at specified index path.
 *
 * @param indexPath An index path locating a row in data source.
 * @return The row at specified index path.
 */
- (__kindof MVTableRow *)rowAtIndexPath:(NSIndexPath *)indexPath;

- (nullable NSArray *)allSections;

/**
 *  根据已设好的autolayout属性来确定cell的高度
 *  @return 高度
 */
- (CGFloat)autoAdjustedCellHeightAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView;

- (NSArray *)rowsInSection:(NSInteger)section;

@end

#pragma mark - 

@interface MVTableViewDataSource : MVNode <UITableViewDataSource, MVTableViewDataSource>

/**
 * Inserts a given section at the end of the section array.
 *
 * @param section The section object to add to the end of section array. This value MUST NOT be nil.
 */
- (void)addSection:(MVTableSection *)section;
- (void)removeSection:(MVTableSection*)section;
- (void)addSectionsFromArray:(NSArray *)array;
- (void)registerClass:(nonnull Class)cellClass forCellReuseIdentifier:(NSString *)identifier;

- (void)invalidAutoCalculatedCellHeight;

@end

NS_ASSUME_NONNULL_END
#endif
