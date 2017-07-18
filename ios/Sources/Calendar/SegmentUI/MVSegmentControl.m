//
//  MVSegmentControl.m
//  MVCommonUI
//
//  Created by Chen Zhang on 12/18/14.
//  Copyright (c) 2014 Alipay. All rights reserved.
//

#import "MVSegmentControl.h"
#import "UIColor+SHYUtil.h"
#import "NSArray+SHYUtil.h"

@interface MVSegmentControl ()

@property (nonatomic, strong) UIScrollView *segmentScrollView;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIView *indictorView;
@property (nonatomic, assign) CGFloat segmentWidth;
@property (nonatomic, strong) UIFont *titleFont;
@property (strong, nonatomic) UITapGestureRecognizer *doubleTapRecognizer;

@end

@implementation MVSegmentControl

- (instancetype) initWithTitles:(NSArray *)titles
{
    if (self = [super initWithFrame:CGRectZero]) {
        
        self.titleFontSize = 13;
        
        self.backgroundColor = [UIColor whiteColor];
        self.segmentScrollView = [[UIScrollView alloc] init];
        self.segmentScrollView.backgroundColor = self.backgroundColor;
        self.segmentScrollView.showsVerticalScrollIndicator = NO;
        self.segmentScrollView.showsHorizontalScrollIndicator = NO;
        self.segmentScrollView.scrollsToTop = NO;
        [self addSubview:self.segmentScrollView];
    
        self.buttonArray = [[NSMutableArray alloc] init];
        
        self.indictorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 2)];
        self.indictorView.backgroundColor = [UIColor shy_colorWithHex:0x20a5f2];
        
        [self.segmentScrollView addSubview:self.indictorView];

        self.topSeperatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        self.topSeperatorLine.backgroundColor = [UIColor shy_colorWithHex:0xd7d7d7];

        self.bottomSeperatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0.5)];
        self.bottomSeperatorLine.backgroundColor = [UIColor shy_colorWithHex:0xd7d7d7];
        [self.segmentScrollView addSubview:self.bottomSeperatorLine];
        [self.segmentScrollView addSubview:self.topSeperatorLine];
        [self.topSeperatorLine setHidden:YES];
        
        self.fullFit = NO;
        
        self.titleArray = titles;
    }
    return self;
}

- (void)setTitleFontSize:(CGFloat)titleFontSize {
    _titleFontSize = titleFontSize;
    self.titleFont = [UIFont systemFontOfSize:self.titleFontSize];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.segmentScrollView.backgroundColor = backgroundColor;
}

- (void) setTitleArray:(NSArray *)titles
{
    _titleArray = titles;
    
    //remove previous buttons
    for (UIButton *button in self.buttonArray) {
        [button removeFromSuperview];
    }
    [self.buttonArray removeAllObjects];
    
    self.doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleClick:)];
    self.doubleTapRecognizer.numberOfTapsRequired = 2;
    //add new ones
    [self.titleArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        //add button into segment scrollView
        NSString *title = obj;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.backgroundColor = [UIColor clearColor];
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.text = title;
        button.titleLabel.font = self.titleFont;
        button.tag = idx;
        [button setTitleColor:[UIColor shy_colorWithHex:0x222227] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchUpInside];
        [button addGestureRecognizer:self.doubleTapRecognizer];
        [self.buttonArray addObject:button];
        
        [self.segmentScrollView addSubview:button];
    }];
    
    [self setSelectedIndex:_selectedIndex animated:NO];
    
    [self setNeedsLayout];
}

- (void) setHasIconArray:(NSArray<NSNumber *> *)hasIconArray
{
    _hasIconArray = hasIconArray;
    for (NSUInteger index = 0; index < hasIconArray.count; index ++) {
        NSNumber *number = hasIconArray[index];
        if (index > _buttonArray.count) {
            break;
        }
        
        UIButton *button = [_buttonArray objectAtIndex:index];
        if (number.boolValue) {
            button.titleEdgeInsets = UIEdgeInsetsMake(0, -14, 0, 0);
        }
        else {
            button.titleEdgeInsets = UIEdgeInsetsZero;
        }
    }
    
    [self setNeedsLayout];
}

- (CGFloat)indicatorWidth {
    
    CGFloat offset = self.fullFit ? 13 : 6;
    CGFloat indictorWidth = self.segmentWidth - 2 * offset;
    NSNumber *hasIcon = [self.hasIconArray shy_objectAtIndexCheck:_selectedIndex];
    if ([hasIcon boolValue]) {
        indictorWidth = self.segmentWidth - offset;
    }
    
    return indictorWidth;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    BOOL biggerPhone = [UIScreen mainScreen].bounds.size.width > 320;
    NSInteger segmentCount = self.titleArray.count;
    NSInteger optimalSegmentCount = biggerPhone ? 4 : 3;
    
    if (segmentCount <= 0) {
        return;
    }
    
    CGFloat segmentWidth = 0;
    if (self.fullFitAndScrollable) {
        if (85 * segmentCount < CGRectGetWidth(self.frame)) {
            segmentWidth = CGRectGetWidth(self.frame) / segmentCount;
            self.segmentScrollView.contentSize = self.frame.size;
        } else {
            segmentWidth = 85;
            self.segmentScrollView.contentSize = CGSizeMake(segmentWidth * segmentCount, self.frame.size.height);
        }
    } else {

        if (!self.fullFit) {
            segmentWidth = 96; //fit as many as possible;
            if (self.hasIconArray.count > 0) {
                segmentWidth = 102;
            }
            self.segmentScrollView.contentSize = CGSizeMake(segmentWidth * segmentCount, self.frame.size.height);
        }
        else {
            optimalSegmentCount = self.titleArray.count;
            segmentWidth = CGRectGetWidth(self.frame) / optimalSegmentCount;
            self.segmentScrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
        }
    }
    
    self.segmentWidth = segmentWidth;
    self.segmentScrollView.frame = self.bounds;
    for (UIButton *segment in self.buttonArray) {
        segment.frame = CGRectMake([self.buttonArray indexOfObject:segment] * segmentWidth, 0, segmentWidth, self.frame.size.height);
    }
    
    CGFloat offset = self.fullFit ? 13 : 6;
    CGFloat indictorWidth = [self indicatorWidth];
    self.indictorView.frame = CGRectMake(offset + self.selectedIndex * segmentWidth,
                                         self.segmentScrollView.frame.size.height - self.indictorView.frame.size.height,
                                         indictorWidth,
                                         self.indictorView.frame.size.height);
    self.bottomSeperatorLine.hidden = YES;
    self.bottomSeperatorLine.frame = CGRectMake(- self.frame.size.width, self.frame.size.height - self.bottomSeperatorLine.frame.size.height, self.segmentScrollView.contentSize.width + 2 * self.frame.size.width, self.bottomSeperatorLine.frame.size.height);
    self.topSeperatorLine.frame = CGRectMake(- self.frame.size.width, 0, self.segmentScrollView.contentSize.width + 2 * self.frame.size.width, self.bottomSeperatorLine.frame.size.height);
    
    [self.segmentScrollView bringSubviewToFront:self.bottomSeperatorLine];
    [self.segmentScrollView bringSubviewToFront:self.indictorView];
    
    [self setSelectedIndex:_selectedIndex animated:NO];
    //with side effects
}

- (void) setSelectedIndex:(NSInteger)selectedIndex
{
    [self setSelectedIndex:selectedIndex animated:YES];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex animated:(BOOL)animated
{
    if (selectedIndex < 0 || (selectedIndex > ((int)self.buttonArray.count - 1)) || (selectedIndex > ((int)self.titleArray.count - 1))) {
        return; //safety check
    }
    _selectedIndex = selectedIndex;
    //do selection animation
    [self.segmentScrollView bringSubviewToFront:self.indictorView];

    [self.buttonArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = obj;
        if (idx == self.selectedIndex) {
            [button setTitleColor:[UIColor shy_colorWithHex:0x20a5f2] forState:UIControlStateNormal];
        } else {
            [button setTitleColor:[UIColor shy_colorWithHex:0x657786] forState:UIControlStateNormal];
        }
        button.titleLabel.font = self.titleFont;
    }];
    
    __weak __typeof(&*self)weakSelf = self;
    [UIView animateWithDuration:animated?0.3:0 animations:^{
        
        CGFloat offset = weakSelf.fullFit ? 13 : 6;
        CGFloat indictorWidth = [weakSelf indicatorWidth];
        weakSelf.indictorView.frame = CGRectMake(offset + weakSelf.selectedIndex * weakSelf.segmentWidth,
                                             weakSelf.segmentScrollView.frame.size.height - weakSelf.indictorView.frame.size.height,
                                             indictorWidth,
                                             weakSelf.indictorView.frame.size.height);

        //set scrollView contentOffset
        UIButton *selectedButton = weakSelf.buttonArray[selectedIndex];
        if (weakSelf.segmentScrollView.contentSize.width > weakSelf.segmentScrollView.frame.size.width) {
            //try to center buttonFrame
            CGPoint intendedOffset = CGPointMake(selectedButton.center.x - weakSelf.segmentScrollView.frame.size.width / 2, 0);
            if (intendedOffset.x <= 0) {
                weakSelf.segmentScrollView.contentOffset = CGPointZero;
            }
            else if (intendedOffset.x + weakSelf.segmentScrollView.frame.size.width > weakSelf.segmentScrollView.contentSize.width) {
                weakSelf.segmentScrollView.contentOffset = CGPointMake(weakSelf.segmentScrollView.contentSize.width - weakSelf.segmentScrollView.frame.size.width, 0);
            }
            else {
                weakSelf.segmentScrollView.contentOffset = intendedOffset;
            }
        }
    }];
    
}

- (void)handleDoubleClick:(UITapGestureRecognizer*)sender{
    NSInteger index = sender.view.tag;
    if (self.delegate && [self.delegate respondsToSelector:@selector(segmentControl:doubleClickedAtIndex:)]) {
        [self.delegate segmentControl:self doubleClickedAtIndex:index];
    }
}

- (void)didClick: (id) sender
{
    NSInteger index = [(UIView *)sender tag];
    if ([self.delegate respondsToSelector:@selector(segmentControl:shouldResponseButtonAtIndex:)]) {
        if ([self.delegate segmentControl:self shouldResponseButtonAtIndex:index]) {
            [self.delegate segmentControl:self didSelectButtonAtIndex:index];
            return;
        }
    }
    self.selectedIndex = index;
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
- (void)sendButtonActionAtIndex:(NSInteger)index{
    if(self.buttonArray && self.buttonArray.count > index){
        UIButton *btn = self.buttonArray[index];
        [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}
- (NSUInteger)numberOfSegments
{
    return self.titleArray.count;
}

@end
