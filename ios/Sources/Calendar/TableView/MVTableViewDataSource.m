//
//  MVTableViewDataSource.m
//  MVCommonUI
//
//  Created by 念纪 on 14/11/24.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import "MVTableViewDataSource.h"
#import "MVTableSection.h"
#import "MVTableRow.h"
#import "NSArray+SHYUtil.h"

@interface MVTableViewDataSource ()
{
    NSMutableDictionary *_classMap;
}

@end

@implementation MVTableViewDataSource


+ (MVTableViewDataSource *)dataSourceFromPlist:(NSString *)path
{
    return nil;
}

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier
{
    if (_classMap == nil) {
        _classMap = [NSMutableDictionary dictionary];
    }
    [_classMap setObject:cellClass forKey:identifier];
}

- (NSArray *)allSections
{
    return [self children];
}

- (NSArray *)sections {
    return [self children];
}

- (void)setSections:(NSArray *)sections {
    [self setChildren:sections];
}

- (void)addSection:(MVTableSection *)section
{
    if (section == nil && ![section isKindOfClass:[MVTableSection class]]) {
        [NSException raise:NSInvalidArgumentException format:@"The section MUST NOT be nil or empty."];
    }
    [self addChild:section];
}

- (void)removeSection:(MVTableSection*)section{
    [self removeChild:section];
}

- (void)addSectionsFromArray:(NSArray *)array
{
    [self addChildFromArray:array];
}

- (NSArray *)rowsInSection:(NSInteger)section
{
    NSArray *rows = nil;
    do {
        rows = [[[self children] shy_objectAtIndexCheck:section] allRows];
        if (![rows isKindOfClass:[NSArray class]]) {
            rows = nil;
            break;
        }
    } while (0);
    return rows;
}

- (MVTableRow *)rowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *rows = [self rowsInSection:indexPath.section];
    return [rows shy_objectAtIndexCheck:indexPath.row];
}

/**
 *  @see http://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights
 */
- (CGFloat)autoAdjustedCellHeightAtIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView {
    
    MVTableRow *row = [self rowAtIndexPath:indexPath];
    if ([row cellHeight] > 0) {
        return [row cellHeight];
    } else {
        UIView *layoutGuideView = [row autoLayoutView];
        if (!layoutGuideView) {
            UITableViewCell *cell = [row cellForTableViewAutoAdjust];
            [row updateCell:cell indexPath:indexPath];
            layoutGuideView = cell;
        }
        
        
        [layoutGuideView setNeedsUpdateConstraints];
        [layoutGuideView updateConstraintsIfNeeded];
        
        layoutGuideView.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(tableView.bounds), CGRectGetHeight(layoutGuideView.bounds));
        
        // Do the layout pass on the cell, which will calculate the frames for all the views based on the constraints.
        // (Note that you must set the preferredMaxLayoutWidth on multi-line UILabels inside the -[layoutSubviews] method
        // of the UITableViewCell subclass, or do it manually at this point before the below 2 lines!)
        [layoutGuideView setNeedsLayout];
        [layoutGuideView layoutIfNeeded];
//        if ([UIView mv_needFixLayoutsubViews]) {
//            [layoutGuideView mvlabel_fixLayoutsubViews];
//        }
        
        // Get the actual height required for the cell's contentView
        CGFloat height;
        if ([layoutGuideView isKindOfClass:[UITableViewCell class]]) {
            height = [[(UITableViewCell *)layoutGuideView contentView] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        }
        else {
            height = [layoutGuideView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        }
        
        // Add an extra point to the height to account for the cell separator, which is added between the bottom
        // of the cell's contentView and the bottom of the table view cell.
        height += 1.0f;
        //计算完后保存，避免多次重复计算
        row.cellHeight = height;
        return height;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self allSections].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    MVTableSection *tableSection = [[self allSections] shy_objectAtIndexCheck:section];
    if (tableSection.folded) { //if folded, no rows here
        return 0;
    }
    return [self rowsInSection:section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MVTableSection *section = [[self allSections] shy_objectAtIndexCheck:indexPath.section];
    MVTableRow *row = [[section allRows] shy_objectAtIndexCheck:indexPath.row];
    UITableViewCell *cell = [row cellForTableView:tableView indexPath:indexPath];
    [row updateCell:cell indexPath:indexPath];
    return cell;
}

- (void)invalidAutoCalculatedCellHeight {
    NSArray *sections = [self allSections];
    for (MVTableSection *section in sections) {
        for (MVTableRow *row in section) {
            if ([row autoAdjustCellHeight]) {
                row.cellHeight = 0;
            }
        }
    }
}


@end
