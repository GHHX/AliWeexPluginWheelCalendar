//
//  MVTableViewCell.m
//  MVCommonUI
//
//  Created by 念纪 on 14/10/31.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import "MVBaseTableViewCell.h"
#import "UIColor+SHYUtil.h"
#import <Masonry/Masonry.h>

typedef NS_ENUM(NSInteger, eMVTableCellLinePosition) {
    eMVTableCellLinePositionTop,
    eMVTableCellLinePositionBottom,
};

@interface MVBaseTableViewCell ()

@end

@implementation MVBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:(UITableViewCellStyle)style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self commontInit];
    }
    return self;
}

- (void)commontInit
{
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = [UIColor shy_colorWithHex:0xf0f0f0];
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    [self commontInit];
}


#pragma mark - 添加cell分割线
- (void)addTopFullLine
{
    [self addLineWithPosition:eMVTableCellLinePositionTop offset:0.f];
}

- (void)addBottomFullLine
{
    [self addLineWithPosition:eMVTableCellLinePositionBottom offset:0.f];
}

- (void)addBottomShortLine
{
    [self addLineWithPosition:eMVTableCellLinePositionBottom offset:16.f];
}

- (void)addLineWithPosition:(eMVTableCellLinePosition)position offset:(CGFloat)offset
{
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:[UIColor shy_colorWithHex:0xe2e2e2]];
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self.mas_trailing);
        make.height.equalTo(@(0.5));
        
        switch (position) {
            case eMVTableCellLinePositionTop: {
                make.top.equalTo(0);
                make.leading.equalTo(self.mas_leading).with.offset(offset);
                break;
            }
            case eMVTableCellLinePositionBottom: {
                make.bottom.equalTo(0);
                make.leading.equalTo(self.mas_leading).with.offset(offset);
                break;
            }
            default: {
                break;
            }
        }
    }];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];
}


@end
