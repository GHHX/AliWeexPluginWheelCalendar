//
//  MVPWeekTitleView.m
//  MoviePro
//
//  Created by 风海 on 17/3/15.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPWeekTitleView.h"
#import "UIColor+SHYUtil.h"
#import "NSArray+SHYUtil.h"

@interface MVPWeekTitleView()
@property (strong, nonatomic) NSArray *titleArray;
@end

@implementation MVPWeekTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor shy_colorWithHex:0xf5f5f5]];
        [self configUI];
    }
    return self;
}

- (void)configUI {
    CGFloat titleW = [UIScreen mainScreen].bounds.size.width/self.titleArray.count;
    for (int i=0;i<self.titleArray.count;i++) {
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleW*i, 0,titleW,25)];
        [self addSubview:titleLabel];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [titleLabel setTextColor:[UIColor shy_colorWithHex:0xa3adb6]];
        [titleLabel setText:[self.titleArray shy_objectAtIndexCheck:i]];
        [titleLabel setFont:[UIFont systemFontOfSize:12]];
    }
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"日", @"一",@"二",@"三",@"四",@"五",@"六",nil];
    }
    return _titleArray;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
