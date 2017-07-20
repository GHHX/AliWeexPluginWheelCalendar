//
//  MVTableRow.m
//  MVCommonUI
//
//  Created by 念纪 on 14/11/24.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import "MVTableRow.h"
#import "MVTableSection.h"

@implementation MVTableRow

- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    [NSException raise:NSInvalidArgumentException format:@"The %s MUST be implemented by subclass", __FUNCTION__];
    return Nil;
}

- (UITableViewCell *) cellForTableViewAutoAdjust
{
    static NSDictionary *templateCellDict = nil;
    if (!templateCellDict) {
        templateCellDict = [NSMutableDictionary dictionaryWithCapacity:3];
    }
    
    NSString *identifier = [self reuseIdentifier];
    
    UITableViewCell *cell = [templateCellDict objectForKey:identifier];
    if (!cell) {
        cell = [self createCellForAutoAdjustedTableViewCell];
        [templateCellDict setValue:cell forKey:identifier];
    }
    return cell;
}

- (NSString *) reuseIdentifier
{
    return NSStringFromClass([self class]);
}

- (UITableViewCell *) createCellForAutoAdjustedTableViewCell
{
    [NSException raise:NSInvalidArgumentException format:@"The %s MUST be implemented by subclass", __FUNCTION__];
    return nil;
}

- (CGFloat)cellHeight
{
    return _cellHeight;
}

- (CGFloat)tableView:(UITableView*)tableView cellHeightAtIndexPath:(NSIndexPath*)indexPath{
    return 0;
}

- (void)updateCell:(UITableViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
}

- (BOOL)autoAdjustCellHeight {
    
    return NO;
}

- (void)invalidateAutoCellHeight
{
    self.cellHeight = 0;
}

- (NSIndexPath *)indexPath {
    
    NSUInteger section = [self.parent nodeIndex];
    NSUInteger row = [self nodeIndex];
    
    if (section != NSNotFound && row != NSNotFound) {
        
        return [NSIndexPath indexPathForRow:row inSection:section];
    } else {
        
        return nil;
    }
}

- (UIView *) autoLayoutView
{
    return nil;
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void) tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (void)rowDidAddToSection:(MVTableSection *)section {
    
}

- (void)rowWillAddToSection:(MVTableSection *)section {
    
}

@end
