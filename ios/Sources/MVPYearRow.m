//
//  MVPYearRow.m
//  MoviePro
//
//  Created by 风海 on 17/2/21.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPYearRow.h"
#import "MVPYearCell.h"
#import "UIColor+SHYUtil.h"

@interface MVPYearRow()
@property (strong ,nonatomic) NSString *content;

@end

@implementation MVPYearRow

- (void)setYearContent:(NSString *)year{
    _content = year;
}

- (CGFloat)cellHeight{
    return 44;
}

- (NSString *)reuseIdentifier
{
    static NSString *identifier = @"MVPYearCellRowID";
    return identifier;
}

- (UITableViewCell *)cellForTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath
{
    MVPYearCell *cell = [tableView dequeueReusableCellWithIdentifier:[self reuseIdentifier]];
    if (cell == nil) {
        cell = (MVPYearCell *)[self createCellForAutoAdjustedTableViewCell];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    [cell.topLineView setHidden:YES];
    if (_isSelect) {
        if (_isYear) {
            [cell.topLineView setHidden:NO];
            [cell.lineView setHidden:NO];
            [cell setBackgroundColor:[UIColor whiteColor]];
        }else{
            [cell.contentLabel setTextColor:[UIColor shy_colorWithHex:0x20a5f2]];
            [cell setBackgroundColor:[UIColor shy_colorWithHex:0xebf5ff]];
        }
    }else{
        if (_isYear) {
            [cell.lineView setHidden:YES];
            [cell setBackgroundColor:[UIColor clearColor]];
        }else{
            [cell.contentLabel setTextColor:[UIColor shy_colorWithHex:0x333333]];
            [cell setBackgroundColor:[UIColor whiteColor]];
        }
    }
    
    return cell;
}

- (UITableViewCell *)createCellForAutoAdjustedTableViewCell
{
    MVPYearCell *cell = nil;
    cell = [[MVPYearCell alloc] init];
    return cell;
}

- (void)updateCell:(MVPYearCell *)cell indexPath:(NSIndexPath *)indexPath {
    cell.contentLabel.text = _content;
}

@end
