//
//  MVTableViewDelegateProxy.m
//  MVCommonUI
//
//  Created by 念纪 on 14/11/24.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import "MVTableViewDelegateProxy.h"
#import "MVTableViewDataSource.h"
#import "MVTableRow.h"
#import "MVTableSection.h"
#import "MVTableView.h"

@interface MVTableViewDelegateProxy ()

@property (nonatomic, assign) id oriTarget;

@end

@implementation MVTableViewDelegateProxy

- (void)setTarget:(id)target
{
    _target = target;
    self.oriTarget = target;
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    if (self.target) {
        [invocation invokeWithTarget:self.target];
    }
    else {
        [invocation invokeWithTarget:self.oriTarget];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    NSMethodSignature *ms = nil;
    if (self.target) {
        ms = [self.target methodSignatureForSelector:sel];
    }
    else {
        ms = [self.oriTarget methodSignatureForSelector:sel];
    }
    return ms;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL ret = NO;
    SEL selectors[] = {
        @selector(tableView:heightForRowAtIndexPath:),
        @selector(tableView:didSelectRowAtIndexPath:),
        @selector(tableView:viewForHeaderInSection:),
        @selector(tableView:viewForFooterInSection:),
        @selector(tableView:willDisplayHeaderView:forSection:),
        @selector(tableView:willDisplayFooterView:forSection:),
        @selector(tableView:heightForHeaderInSection:),
        @selector(tableView:heightForFooterInSection:),
        @selector(tableView:didEndDisplayingCell:forRowAtIndexPath:),
        @selector(tableView:willDisplayCell:forRowAtIndexPath:),
        @selector(tableView:estimatedHeightForRowAtIndexPath:),
        NULL
    };
    
    if (![self.target respondsToSelector:@selector(supportEstimatedHeight)]) {
        selectors[10] = NULL;
    }
    
    for (SEL *p = selectors; *p != NULL; ++p) {
        if (aSelector == *p) {
            ret = YES;
            break;
        }
    }
    if (!ret) {
        ret = [self.target respondsToSelector:aSelector];
    }
    
    return ret;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([tableView isKindOfClass:[MVTableView class]]) {
        MVTableView *theTableView = (MVTableView *)tableView;
        if ([theTableView.dataSource isKindOfClass:[MVTableViewDataSource class]]) {
            MVTableViewDataSource *theDataSource = (MVTableViewDataSource *)theTableView.dataSource;
            MVTableRow *row = [theDataSource rowAtIndexPath:indexPath];
            if (row.clickedBlock) {
                row.clickedBlock(theTableView, indexPath);
            }
        }
    }
    
    if ([self.target respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.target tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL rowHandle = NO;
    if ([tableView.dataSource conformsToProtocol:@protocol(MVTableViewDataSource)]) {
        id<MVTableViewDataSource> dataSource = (id)tableView.dataSource;
        MVTableRow *row = [dataSource rowAtIndexPath:indexPath];
        if (row && [row respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
            [row tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
            rowHandle = YES;
        }
    }
    
    if (rowHandle && self.target && [self.target respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.target tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void) tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL rowHandle = NO;
    if ([tableView.dataSource conformsToProtocol:@protocol(MVTableViewDataSource)]) {
        id<MVTableViewDataSource> dataSource = (id)tableView.dataSource;
        MVTableRow *row = [dataSource rowAtIndexPath:indexPath];
        if (row && [row respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
            [row tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
            rowHandle = YES;
        }
    }
    
    if (rowHandle && self.target && [self.target respondsToSelector:@selector(tableView:didEndDisplayingCell:forRowAtIndexPath:)]) {
        [self.target tableView:tableView didEndDisplayingCell:cell forRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 44.0;
    if (self.target && [self.target respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        height = [self.target tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    else if ([tableView.dataSource conformsToProtocol:@protocol(MVTableViewDataSource)]) {
        id<MVTableViewDataSource> dataSource = (id)tableView.dataSource;
        MVTableRow *row = [dataSource rowAtIndexPath:indexPath];
        if (row.autoAdjustCellHeight) {
            height = [dataSource autoAdjustedCellHeightAtIndexPath:indexPath inTableView:tableView];
        } else {
            height = [[dataSource rowAtIndexPath:indexPath] tableView:tableView cellHeightAtIndexPath:indexPath];
            if (height<=0) {
                height = [[dataSource rowAtIndexPath:indexPath] cellHeight];
            }
        }
    }
    if (height < 0) {
        height = 0; //如果返回是负数，会crashc
    }
    return height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (self.target && [self.target respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.target tableView:tableView viewForHeaderInSection:section];
    }
    if ([tableView.dataSource conformsToProtocol:@protocol(MVTableViewDataSource)]) {
        id<MVTableViewDataSource> dataSource = (id)tableView.dataSource;
        MVTableSection *tableSection = [[dataSource allSections] objectAtIndex:section];
        return [tableSection viewForHeaderInTableView:tableView section:section];
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (self.target && [self.target respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.target tableView:tableView viewForFooterInSection:section];
    }
    if ([tableView.dataSource conformsToProtocol:@protocol(MVTableViewDataSource)]) {
        id<MVTableViewDataSource> dataSource = (id)tableView.dataSource;
        MVTableSection *tableSection = [[dataSource allSections] objectAtIndex:section];
        return [tableSection viewForFooterInTableView:tableView section:section];
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    CGFloat height = 0.0;
    if (self.target && [self.target respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        height = [self.target tableView:tableView heightForHeaderInSection:section];
    }
    else if ([tableView.dataSource conformsToProtocol:@protocol(MVTableViewDataSource)]) {
        id<MVTableViewDataSource> dataSource = (id)tableView.dataSource;
        MVTableSection *tableSection = [[dataSource allSections] objectAtIndex:section];
        height = [tableSection heightForHeaderInTableView:tableView inSection:section];
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    CGFloat height = 0;
    if (self.target && [self.target respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        height = [self.target tableView:tableView heightForFooterInSection:section];
    }
    else if ([tableView.dataSource conformsToProtocol:@protocol(MVTableViewDataSource)]) {
        id<MVTableViewDataSource> dataSource = (id)tableView.dataSource;
        MVTableSection *tableSection = [[dataSource allSections] objectAtIndex:section];
        height = [tableSection heightForFooterInTableView:tableView inSection:section];
    }
    return height;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    CGFloat height = 0;
    if (self.target && [self.target respondsToSelector:@selector(tableView:estimatedHeightForRowAtIndexPath:)]) {
        height = [self.target tableView:tableView estimatedHeightForRowAtIndexPath:indexPath];
    }
    else if ([tableView.dataSource conformsToProtocol:@protocol(MVTableViewDataSource)]) {
        id<MVTableViewDataSource> dataSource = (id)tableView.dataSource;
        MVTableRow *row = [dataSource rowAtIndexPath:indexPath];
        if ([row respondsToSelector:@selector(estimatedHeight)]) {
            height = [row estimatedHeight];
        }
        if (height <= 0.0f) {
            height = row.cellHeight;
        }
    }
    return height;
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    if (self.target && [self.target respondsToSelector:@selector(tableView:willDisplayHeaderView:forSection:)]) {
        [self.target tableView:tableView willDisplayHeaderView:view forSection:section];
    } else if ([tableView.dataSource conformsToProtocol:@protocol(MVTableViewDataSource)]) {
        id<MVTableViewDataSource> dataSource = (id)tableView.dataSource;
        MVTableSection *tableSection = [[dataSource allSections] objectAtIndex:section];
        [tableSection tableView:tableView willDisplayHeaderView:view forSection:section];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    if (self.target && [self.target respondsToSelector:@selector(tableView:willDisplayFooterView:forSection:)]) {
        [self.target tableView:tableView willDisplayFooterView:view forSection:section];
    } else if ([tableView.dataSource conformsToProtocol:@protocol(MVTableViewDataSource)]) {
        id<MVTableViewDataSource> dataSource = (id)tableView.dataSource;
        MVTableSection *tableSection = [[dataSource allSections] objectAtIndex:section];
        [tableSection tableView:tableView willDisplayFooterView:view forSection:section];
    }
}

@end
