//
//  MVPConfirmMenuView.m
//  MoviePro
//
//  Created by 风海 on 17/3/2.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPConfirmMenuView.h"
#import "UIColor+SHYUtil.h"
#import <Masonry/Masonry.h>

@interface MVPConfirmMenuView()

@property (strong, nonatomic) UILabel *startLabel;
@property (strong, nonatomic) UILabel *endLabel;
@property (strong, nonatomic) UIButton *confirmBtn;

@property (copy, nonatomic) NSString *sDate;
@property (copy, nonatomic) NSString *eDate;

@end

@implementation MVPConfirmMenuView

- (id)init {
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    
    UIView *bgView = [[UIView alloc] init];
    [bgView setBackgroundColor:[UIColor shy_colorWithHex:0x50505a]];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_confirmBtn setBackgroundColor:[UIColor shy_colorWithHex:0xd6dade]];
    [_confirmBtn setUserInteractionEnabled:NO];
    [_confirmBtn setTitle:@"确认" forState:UIControlStateNormal];
    [_confirmBtn setTitleColor:[UIColor shy_colorWithHex:0xffffff] forState:UIControlStateNormal];
    [_confirmBtn.titleLabel setFont:[UIFont systemFontOfSize:16.0]];
    [_confirmBtn addTarget:self action:@selector(confrom:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:_confirmBtn];
    [_confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bgView.mas_bottom);
        make.right.mas_equalTo(bgView.mas_right);
        make.top.mas_equalTo(bgView.mas_top);
        make.width.equalTo(@(120));
    }];
    
    _startLabel = [[UILabel alloc] init];
    [_startLabel setTextColor:[UIColor shy_colorWithHex:0xffffff]];
    [_startLabel setFont:[UIFont systemFontOfSize:12]];
    [_startLabel setText:@"开始时间: "];
    [bgView addSubview:_startLabel];
    [_startLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bgView.mas_top).offset(10);
        make.left.equalTo(bgView.mas_left).offset(15);
        make.right.equalTo(_confirmBtn.mas_left);
        make.height.equalTo(@(20));
    }];
    
    _endLabel = [[UILabel alloc] init];
    [_endLabel setTextColor:[UIColor shy_colorWithHex:0xffffff]];
    [_endLabel setFont:[UIFont systemFontOfSize:12]];
    [_endLabel setText:@"结束时间: "];
    [bgView addSubview:_endLabel];
    [_endLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_startLabel.mas_bottom);
        make.left.equalTo(bgView.mas_left).offset(15);
        make.right.equalTo(_confirmBtn.mas_left);
        make.height.equalTo(@(20));
    }];
}

- (void)setStartDate:(NSString *)startDate endDate:(NSString *)endDate{
    _sDate = startDate;
    _eDate = endDate;
    [_startLabel setText:[NSString stringWithFormat:@"开始时间: %@",startDate]];
    [_endLabel setText:[NSString stringWithFormat:@"结束时间: %@",endDate]];
    if (endDate.length > 0) {
        [_confirmBtn setBackgroundColor:[UIColor shy_colorWithHex:0x20a5f2]];
        [_confirmBtn setUserInteractionEnabled:YES];
    }else{
        [_confirmBtn setBackgroundColor:[UIColor shy_colorWithHex:0xd6dade]];
        [_confirmBtn setUserInteractionEnabled:NO];
    }
}


- (void)confrom:(id)selector{
    if (_resultBlock) {
        _resultBlock(_sDate,_eDate);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
