//
//  MVXibBasedTableRow.m
//  MVCommonUI
//
//  Created by Erick Xi on 15/9/10.
//  Copyright © 2015年 Alipay. All rights reserved.
//

#import "MVXibBasedTableRow.h"
//#import "MVResourceManager.h"
//#import "UIView+MVCommonUI.h"

@implementation MVXibBasedTableRowCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //
}

@end


@interface MVXibBasedTableRow ()

@end

@implementation MVXibBasedTableRow

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (NSString *)xibName {
    return [self reuseIdentifier];
}

- (UITableViewCell *)createCellForAutoAdjustedTableViewCell {
    NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:self.xibName owner:self options:nil];
    return (UITableViewCell *)nibs[0];
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    MVXibBasedTableRowCell *cell = [tableView dequeueReusableCellWithIdentifier:self.reuseIdentifier];
    if (cell == nil) {
        cell = [self createCellForAutoAdjustedTableViewCell];
    }
    return cell;
}

- (void)updateCell:(MVXibBasedTableRowCell *)cell indexPath:(NSIndexPath *)indexPath {
    [super updateCell:cell indexPath:indexPath];
}

- (BOOL)autoAdjustCellHeight {
    return YES;
}

@end
