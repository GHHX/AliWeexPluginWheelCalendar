//
//  MVPYearCell.m
//  MoviePro
//
//  Created by 风海 on 17/2/21.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPYearCell.h"
#import "UIColor+SHYUtil.h"
#import <Masonry/Masonry.h>

@implementation MVPYearCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
}

- (void)configUI{
    [self addSubview:self.contentLabel];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(15);
        make.top.equalTo(self.mas_top);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.bottom.equalTo(self.mas_bottom);
        make.height.equalTo(@(0.5));
    }];
    
    [self addSubview:self.topLineView];
    [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.equalTo(@(0.5));
    }];
}
- (id)init{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}


- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        [_contentLabel setFont:[UIFont systemFontOfSize:15]];
        [_contentLabel setTextColor:[UIColor shy_colorWithHex:0x333333]];
        [_contentLabel setNumberOfLines:1];
    }
    return _contentLabel;
}

- (UIView *)lineView{
    if(!_lineView){
        _lineView = [[UIView alloc] init];
        [_lineView setBackgroundColor:[UIColor shy_colorWithHex:0xd6dade]];
    }
    return _lineView;
}

- (UIView *)topLineView{
    if(!_topLineView){
        _topLineView = [[UIView alloc] init];
        [_topLineView setHidden:YES];
        [_topLineView setBackgroundColor:[UIColor shy_colorWithHex:0xd6dade]];
    }
    return _topLineView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
