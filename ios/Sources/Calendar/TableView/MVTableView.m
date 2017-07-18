//
//  MVTableView.m
//  MVCommonUI
//
//  Created by 念纪 on 14/11/24.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import "MVTableView.h"
#import "MVTableViewDelegateProxy.h"
#import "UIColor+SHYUtil.h"

@interface MVTableView ()

@property(nonatomic, strong) MVTableViewDelegateProxy *delegateProxy;

@end

@implementation MVTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorColor = [UIColor shy_colorWithHex:0xE2E2E2];
    }
    return self;
}

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    [super setContentInset:contentInset];
}

- (void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate
{
    if (delegate == nil) {
        [super setDelegate:nil];
        self.delegateProxy = nil;
        return;
    }
    
    if (self.delegateProxy == nil) {
        self.delegateProxy = [MVTableViewDelegateProxy alloc];
    }
    self.delegateProxy.target = delegate;
    [super setDelegate:self.delegateProxy];
}

- (void)addEmptyTableViewFooterView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CGFLOAT_MIN)];
    self.tableFooterView = view;
}

- (void)addEmptyTableViewHeaderView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, CGFLOAT_MIN)];
    self.tableHeaderView = view;
}

@end
