//
//  MVTableSection.m
//  MVCommonUI
//
//  Created by 念纪 on 14/11/24.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import "MVTableSection.h"
#import "MVTableRow.h"
#import "NSArray+SHYUtil.h"
#import <Masonry/Masonry.h>

typedef enum MVTableSectionContentType
{
    MVTableSectionContentTypeTitle,
    MVTableSectionContentTypeImage,
    MVTableSectionContentTypeCustomView,
} MVTableSectionContentType;

@interface MVTableSection ()

@property(nonatomic, strong) id content;
@property(nonatomic, assign) MVTableSectionContentType contentType;

@end

@implementation MVTableSection

#pragma mark Table view section lifecycle

+ (MVTableSection *)sectionWithTitle:(NSString *)title
{
    return [[MVTableSection alloc] initWithTitle:title];
}

+ (MVTableSection *)sectionWithImage:(UIImage *)image
{
    return [[MVTableSection alloc] initWithImage:image];
}

+ (MVTableSection *)sectionWithCustomView:(UIView *)view reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[MVTableSection alloc] initWithCustomView:view];
}

- (id)initWithTitle:(NSString *)title
{
    self = [super init];
    if (self) {
        [self commonInit];
        self.content = title;
        self.contentType = MVTableSectionContentTypeTitle;
        self.headerHeight = title.length == 0 ? CGFLOAT_MIN : 32.0;
        self.title = title;
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.content = image;
        self.contentType = MVTableSectionContentTypeImage;
        self.headerHeight = image.size.height;
        [self commonInit];
    }
    return self;
}

- (id)initWithCustomView:(UIView *)customView
{
    self = [super init];
    if (self) {
        UITableViewHeaderFooterView *headerView = [[UITableViewHeaderFooterView alloc] init];
        [headerView.contentView addSubview:customView];
        [customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(headerView.contentView);
        }];
        self.content = headerView;
        self.contentType = MVTableSectionContentTypeCustomView;
        self.headerHeight = CGRectGetHeight(customView.frame);
        [self commonInit];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}


- (void)commonInit
{
    self.headerHeight = CGFLOAT_MIN;
    self.footerHeight = CGFLOAT_MIN;
}


- (UITableViewHeaderFooterView *)viewForTableView:(UITableView *)tableView
{
    UITableViewHeaderFooterView *view = nil;
    
    if (self.content) {
        if (self.contentType == MVTableSectionContentTypeCustomView) {
            return self.content;
        }
        NSString *reuseIdentifier = @"";
        if (self.contentType == MVTableSectionContentTypeTitle) {
            reuseIdentifier = @"MVTableSectionTitleIdentifier";
        }
        else if (self.contentType == MVTableSectionContentTypeImage) {
            reuseIdentifier = @"MVTableSectionImageIdentifier";
        }
        view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifier];
        if (view == nil) {
            view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:reuseIdentifier];
        }
        view.textLabel.text = self.content;
    }
    
    return view;
}

- (UITableViewHeaderFooterView *)viewForHeaderInTableView:(UITableView *)tableView section:(NSInteger)section
{
    return [self viewForTableView:tableView];
}


- (UITableViewHeaderFooterView *)viewForFooterInTableView:(UITableView *)tableView section:(NSInteger)section
{
    return nil;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    
}

- (CGFloat)heightForHeaderInTableView:(UITableView *)tableView inSection:(NSInteger)section
{
    return self.headerHeight;
}

- (CGFloat)heightForFooterInTableView:(UITableView *)tableView inSection:(NSInteger)section
{
    return self.footerHeight;
}

#pragma mark - Managing rows

- (NSArray *)allRows
{
    return [self children];
}

- (void)setAllRows:(NSArray *)rows
{
    [self setChildren:rows];
}

- (void)addRow:(MVTableRow *)item
{
    [self addChild:item];
}

- (void)addChild:(MVTableRow *)node {
    if ([node isKindOfClass:[MVTableRow class]]) {
        [node rowWillAddToSection:self];
    }
    [super addChild:node];
    if ([node isKindOfClass:[MVTableRow class]]) {
        [node rowDidAddToSection:self];
    }
}

- (void)insertChild:(MVTableRow *)node atIndex:(NSUInteger)index
{
    if ([node isKindOfClass:[MVTableRow class]]) {
        [node rowWillAddToSection:self];
    }
    [super insertChild:node atIndex:index];
    if ([node isKindOfClass:[MVTableRow class]]) {
        [node rowDidAddToSection:self];
    }
}

- (void)addRowsFromArray:(NSArray *)array
{
    [self addChildFromArray:array];
}

- (MVTableRow *)rowAtIndex:(NSUInteger)index
{
    return [self.children shy_objectAtIndexCheck:index];
}

- (NSUInteger)section {
    
    return [self nodeIndex];
}

- (CGFloat)height
{
    return self.headerHeight;
}

- (void)setHeight:(CGFloat)height
{
    self.headerHeight = height;
}

- (void)removeChildrenWithClass:(Class)childClass
{
    NSArray<MVTableRow *> *array = [self children];
    [array enumerateObjectsUsingBlock:^(MVTableRow * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:childClass]) {
            [obj removeFromParent];
        };
    }];
}

@end

