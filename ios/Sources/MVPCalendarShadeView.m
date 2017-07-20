//
//  MVPCalendarShadeView.m
//  MoviePro
//
//  Created by 风海 on 17/3/17.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPCalendarShadeView.h"
#import "UIColor+SHYUtil.h"
#import <Masonry/Masonry.h>
@interface MVPCalendarShadeView()

@property (strong, nonatomic) UILabel *contentLabel;

@end


@implementation MVPCalendarShadeView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor shy_colorWithHex:0x657786 alpha:0.9]];
        [self.layer setCornerRadius:6];
        [self configUI];
    }
    return self;
}

- (void)configUI{
    
    _contentLabel = [[UILabel alloc] init];
    [_contentLabel setTextColor:[UIColor shy_colorWithHex:0xffffff]];
    [_contentLabel setFont:[UIFont systemFontOfSize:12]];
    [_contentLabel setTextAlignment:NSTextAlignmentCenter];
    [self addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

}

- (void)showShadeViewWithType:(MVPCalendarShadeType)shadeType bgView:(UIView *)view{
    [view addSubview:self];
    if (shadeType == MVPShadeTypeMiddle) {
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.mas_centerX);
            make.centerY.equalTo(view.mas_centerY);
            make.width.equalTo(@(120));
            make.height.equalTo(@(40));
        }];
    }else if (shadeType == MVPShadeTypeDown){
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view.mas_centerX);
            make.bottom.equalTo(view.mas_bottom).offset(-90);
            make.width.equalTo(@(120));
            make.height.equalTo(@(40));
        }];
    }
}
- (void)momentShowShadeViewWithType:(MVPCalendarShadeType)shadeType bgView:(UIView *)view{
    [self showShadeViewWithType:shadeType bgView:view];
    [self performSelector:@selector(hideShadeView) withObject:nil afterDelay:0.8];
}

- (void)setContent:(NSString *)content{
    [_contentLabel setText:content];
}

- (void)hideShadeView{
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
