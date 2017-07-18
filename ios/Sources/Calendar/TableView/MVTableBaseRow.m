//
//  MVTableBaseRow.m
//  MVCommonUI
//
//  Created by Chen Zhang on 7/12/16.
//  Copyright © 2016 Alipay. All rights reserved.
//

#import "MVTableBaseRow.h"
#import "MVBaseTableViewCell.h"
#import <Masonry/Masonry.h>


@interface MVTableBaseRow ()


@end

@implementation MVTableBaseRow

- (NSString *) reuseIdentifier
{
    return @"MVTableBaseCell";
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[self reuseIdentifier]];
    if (!cell) {
        cell = [self createCellForAutoAdjustedTableViewCell];
    }
    return cell;
}


- (UITableViewCell *) createCellForAutoAdjustedTableViewCell
{
    return [[MVBaseTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[self reuseIdentifier]];
}

#define ATTACHED_VIEW_TAG 0xfeedcafe

- (void)updateCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    UIView *oldDog = [cell.contentView viewWithTag:ATTACHED_VIEW_TAG];
    [oldDog removeFromSuperview];

    if (self.attachedView) {
        [self.attachedView removeFromSuperview];
        [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [cell.contentView addSubview:self.attachedView];
        self.attachedView.tag = ATTACHED_VIEW_TAG;
        [self.attachedView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

- (void) setAttachedView:(UIView *)attachedView
{
    [_attachedView removeFromSuperview];
    _attachedView = attachedView;
}

- (BOOL) autoAdjustCellHeight
{
    return NO;
}

- (void) setCellHeight:(CGFloat)cellHeight
{
    self.attachedViewHeight = cellHeight;
}

- (CGFloat) getPossbileHeight
{
    CGFloat possbileHeight = self.attachedView.frame.size.height;
    if (possbileHeight > 0) {
        return possbileHeight;
    }
    
    possbileHeight = self.attachedView.intrinsicContentSize.height;
    return possbileHeight;
}

- (CGFloat) cellHeight
{
    if (self.attachedViewHeight > 0) {
        return self.attachedViewHeight;
    }
    return [self getPossbileHeight];
}

- (void) setAutoLayoutEnabledAttachedView: (UIView *) view
{
    self.attachedView = view;
    self.attachedViewHeight = view.intrinsicContentSize.height;
}

@end

