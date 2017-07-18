//
//  MVPYearSection.m
//  MoviePro
//
//  Created by 风海 on 17/2/21.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPYearSection.h"
#import "UIColor+SHYUtil.h"
#import <Masonry/Masonry.h>

@interface MVPYearHeaderView : UITableViewHeaderFooterView

@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation MVPYearHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:13.0];
        _titleLabel.textColor = [UIColor blackColor];
        [self addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.mas_leading).offset(16);
            make.top.equalTo(self.mas_top);
            make.bottom.equalTo(self.mas_bottom);
            make.trailing.equalTo(self.mas_trailing);
        }];
    }
    
    return self;
}

@end

@implementation MVPYearSection

- (UITableViewHeaderFooterView *)viewForHeaderInTableView:(UITableView *)tableView section:(NSInteger)section
{
    NSString *reuseIdentifier = @"MVPYearHeaderViewIdentifier";
    MVPYearHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
    
    if (!view) {
        view = [[MVPYearHeaderView alloc] initWithReuseIdentifier:reuseIdentifier];
        view.contentView.backgroundColor = [UIColor shy_colorWithHex:0xf5f5f5];
        view.titleLabel.textColor = [UIColor shy_colorWithHex:0xa3adb6];
        [view.titleLabel setFont:[UIFont systemFontOfSize:14]];
    }
    
    view.titleLabel.text = self.title;
    
    return view;
}

- (CGFloat)heightForHeaderInTableView:(UITableView *)tableView inSection:(NSInteger)section
{
    return 25;
}

@end
