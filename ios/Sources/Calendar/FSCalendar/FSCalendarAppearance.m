//
//  FSCalendarAppearance.m
//  Pods
//
//  Created by DingWenchao on 6/29/15.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//
//  https://github.com/WenchaoD
//

#import "FSCalendarAppearance.h"
#import "FSCalendarDynamicHeader.h"
#import "FSCalendarExtensions.h"
#import "UIColor+SHYUtil.h"

@interface FSCalendarAppearance ()

@property (weak  , nonatomic) FSCalendar *calendar;

@property (strong, nonatomic) NSMutableDictionary *backgroundColors;
@property (strong, nonatomic) NSMutableDictionary *titleColors;
@property (strong, nonatomic) NSMutableDictionary *subtitleColors;
@property (strong, nonatomic) NSMutableDictionary *borderColors;

@end

@implementation FSCalendarAppearance

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([UIScreen mainScreen].bounds.size.width <= 320 ) {
            _titleFont = [UIFont boldSystemFontOfSize:14];
        }else{
            _titleFont = [UIFont boldSystemFontOfSize:FSCalendarStandardTitleTextSize];
        }
        _subtitleFont = [UIFont systemFontOfSize:FSCalendarStandardSubtitleTextSize];
        _weekdayFont = [UIFont systemFontOfSize:FSCalendarStandardWeekdayTextSize];
        _headerTitleFont = [UIFont systemFontOfSize:FSCalendarStandardHeaderTextSize];
    //FSCalendarStandardTitleTextColor
        //@hx设置header颜色
        _headerTitleColor = [UIColor shy_colorWithHex:0xa3adb6];
        _headerDateFormat = @"yyyy年MM月";
        _headerMinimumDissolvedAlpha = 0.2;
        _weekdayTextColor = FSCalendarStandardTitleTextColor;
        _caseOptions = FSCalendarCaseOptionsHeaderUsesDefaultCase|FSCalendarCaseOptionsWeekdayUsesDefaultCase;
        
        _backgroundColors = [NSMutableDictionary dictionaryWithCapacity:6];
        _backgroundColors[@(FSCalendarCellStateNormal)]      = [UIColor clearColor];
        _backgroundColors[@(FSCalendarCellStateSelected)]    = FSCalendarStandardSelectionColor;
        _backgroundColors[@(FSCalendarCellStateDisabled)]    = [UIColor clearColor];
        _backgroundColors[@(FSCalendarCellStatePlaceholder)] = [UIColor clearColor];
        //@hx设置今天背景颜色
        _backgroundColors[@(FSCalendarCellStateToday)] = [UIColor clearColor];
        //@hx设置周末背景颜色
        _backgroundColors[@(FSCalendarCellStateWeekend)] = [UIColor clearColor];
        
        _titleColors = [NSMutableDictionary dictionaryWithCapacity:6];
        _titleColors[@(FSCalendarCellStateNormal)]      = [UIColor blackColor];
        _titleColors[@(FSCalendarCellStateSelected)]    = [UIColor shy_colorWithHex:0x20a5f2];
        _titleColors[@(FSCalendarCellStateDisabled)]    = [UIColor grayColor];
        _titleColors[@(FSCalendarCellStatePlaceholder)] = [UIColor lightGrayColor];
        _titleColors[@(FSCalendarCellStateToday)]       = [UIColor shy_colorWithHex:0x20a5f2];
        _titleColors[@(FSCalendarCellStateWeekend)]     = [UIColor shy_colorWithHex:0xfd777c];
        
        _subtitleColors = [NSMutableDictionary dictionaryWithCapacity:5];
        _subtitleColors[@(FSCalendarCellStateNormal)]      = [UIColor shy_colorWithHex:0x20a5f2];
        _subtitleColors[@(FSCalendarCellStateSelected)]    = [UIColor shy_colorWithHex:0x20a5f2];
        _subtitleColors[@(FSCalendarCellStateDisabled)]    = [UIColor shy_colorWithHex:0x20a5f2];
        _subtitleColors[@(FSCalendarCellStatePlaceholder)] = [UIColor shy_colorWithHex:0x20a5f2];
        _subtitleColors[@(FSCalendarCellStateToday)]       = [UIColor shy_colorWithHex:0x20a5f2];
        
        _borderColors[@(FSCalendarCellStateSelected)]      = [UIColor shy_colorWithHex:0x20a5f2];
        _borderColors[@(FSCalendarCellStateNormal)]        = [UIColor shy_colorWithHex:0x20a5f2];
        
        _borderRadius = 1.0;
        _eventDefaultColor = FSCalendarStandardEventDotColor;
        _eventSelectionColor = FSCalendarStandardEventDotColor;
        
        _borderColors = [NSMutableDictionary dictionaryWithCapacity:2];
        
#if TARGET_INTERFACE_BUILDER
        _fakeEventDots = YES;
#endif
        
    }
    return self;
}

- (void)setTitleFont:(UIFont *)titleFont
{
    if (![_titleFont isEqual:titleFont]) {
        _titleFont = titleFont;
        self.calendar.calculator.titleHeight = -1;
        [self.calendar setNeedsConfigureAppearance];
    }
}

- (void)setSubtitleFont:(UIFont *)subtitleFont
{
    if (![_subtitleFont isEqual:subtitleFont]) {
        _subtitleFont = subtitleFont;
        self.calendar.calculator.subtitleHeight = -1;
        [self.calendar setNeedsConfigureAppearance];
    }
}

- (void)setWeekdayFont:(UIFont *)weekdayFont
{
    if (![_weekdayFont isEqual:weekdayFont]) {
        _weekdayFont = weekdayFont;
        [self.calendar setNeedsConfigureAppearance];
    }
}

- (void)setHeaderTitleFont:(UIFont *)headerTitleFont
{
    if (![_headerTitleFont isEqual:headerTitleFont]) {
        _headerTitleFont = headerTitleFont;
        [self.calendar setNeedsConfigureAppearance];
    }
}

- (void)setTitleOffset:(CGPoint)titleOffset
{
    if (!CGPointEqualToPoint(_titleOffset, titleOffset)) {
        _titleOffset = titleOffset;
        [_calendar.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

- (void)setSubtitleOffset:(CGPoint)subtitleOffset
{
    if (!CGPointEqualToPoint(_subtitleOffset, subtitleOffset)) {
        _subtitleOffset = subtitleOffset;
        [_calendar.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

- (void)setImageOffset:(CGPoint)imageOffset
{
    if (!CGPointEqualToPoint(_imageOffset, imageOffset)) {
        _imageOffset = imageOffset;
        [_calendar.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

- (void)setEventOffset:(CGPoint)eventOffset
{
    if (!CGPointEqualToPoint(_eventOffset, eventOffset)) {
        _eventOffset = eventOffset;
        [_calendar.visibleCells makeObjectsPerformSelector:@selector(setNeedsLayout)];
    }
}

- (void)setTitleDefaultColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarCellStateNormal)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarCellStateNormal)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)titleDefaultColor
{
    return _titleColors[@(FSCalendarCellStateNormal)];
}

- (void)setTitleSelectionColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarCellStateSelected)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarCellStateSelected)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)titleSelectionColor
{
    return _titleColors[@(FSCalendarCellStateSelected)];
}

- (void)setTitleTodayColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarCellStateToday)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarCellStateToday)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)titleTodayColor
{
    return _titleColors[@(FSCalendarCellStateToday)];
}

- (void)setTitlePlaceholderColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarCellStatePlaceholder)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarCellStatePlaceholder)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)titlePlaceholderColor
{
    return _titleColors[@(FSCalendarCellStatePlaceholder)];
}

- (void)setTitleWeekendColor:(UIColor *)color
{
    if (color) {
        _titleColors[@(FSCalendarCellStateWeekend)] = color;
    } else {
        [_titleColors removeObjectForKey:@(FSCalendarCellStateWeekend)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)titleWeekendColor
{
    return _titleColors[@(FSCalendarCellStateWeekend)];
}

- (void)setSubtitleDefaultColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(FSCalendarCellStateNormal)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(FSCalendarCellStateNormal)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

-(UIColor *)subtitleDefaultColor
{
    return _subtitleColors[@(FSCalendarCellStateNormal)];
}

- (void)setSubtitleSelectionColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(FSCalendarCellStateSelected)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(FSCalendarCellStateSelected)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)subtitleSelectionColor
{
    return _subtitleColors[@(FSCalendarCellStateSelected)];
}

- (void)setSubtitleTodayColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(FSCalendarCellStateToday)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(FSCalendarCellStateToday)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)subtitleTodayColor
{
    return _subtitleColors[@(FSCalendarCellStateToday)];
}

- (void)setSubtitlePlaceholderColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(FSCalendarCellStatePlaceholder)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(FSCalendarCellStatePlaceholder)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)subtitlePlaceholderColor
{
    return _subtitleColors[@(FSCalendarCellStatePlaceholder)];
}

- (void)setSubtitleWeekendColor:(UIColor *)color
{
    if (color) {
        _subtitleColors[@(FSCalendarCellStateWeekend)] = color;
    } else {
        [_subtitleColors removeObjectForKey:@(FSCalendarCellStateWeekend)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)subtitleWeekendColor
{
    return _subtitleColors[@(FSCalendarCellStateWeekend)];
}

- (void)setSelectionColor:(UIColor *)color
{
    if (color) {
        _backgroundColors[@(FSCalendarCellStateSelected)] = color;
    } else {
        [_backgroundColors removeObjectForKey:@(FSCalendarCellStateSelected)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)selectionColor
{
    return _backgroundColors[@(FSCalendarCellStateSelected)];
}

- (void)setTodayColor:(UIColor *)todayColor
{
    if (todayColor) {
        _backgroundColors[@(FSCalendarCellStateToday)] = todayColor;
    } else {
        [_backgroundColors removeObjectForKey:@(FSCalendarCellStateToday)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)todayColor
{
    return _backgroundColors[@(FSCalendarCellStateToday)];
}

- (void)setTodaySelectionColor:(UIColor *)todaySelectionColor
{
    if (todaySelectionColor) {
        _backgroundColors[@(FSCalendarCellStateToday|FSCalendarCellStateSelected)] = todaySelectionColor;
    } else {
        [_backgroundColors removeObjectForKey:@(FSCalendarCellStateToday|FSCalendarCellStateSelected)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)todaySelectionColor
{
    return _backgroundColors[@(FSCalendarCellStateToday|FSCalendarCellStateSelected)];
}

- (void)setEventDefaultColor:(UIColor *)eventDefaultColor
{
    if (![_eventDefaultColor isEqual:eventDefaultColor]) {
        _eventDefaultColor = eventDefaultColor;
        [self.calendar setNeedsConfigureAppearance];
    }
}

- (void)setBorderDefaultColor:(UIColor *)color
{
    if (color) {
        _borderColors[@(FSCalendarCellStateNormal)] = color;
    } else {
        [_borderColors removeObjectForKey:@(FSCalendarCellStateNormal)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)borderDefaultColor
{
    return _borderColors[@(FSCalendarCellStateNormal)];
}

- (void)setBorderSelectionColor:(UIColor *)color
{
    if (color) {
        _borderColors[@(FSCalendarCellStateSelected)] = color;
    } else {
        [_borderColors removeObjectForKey:@(FSCalendarCellStateSelected)];
    }
    [self.calendar setNeedsConfigureAppearance];
}

- (UIColor *)borderSelectionColor
{
    return [UIColor shy_colorWithHex:0x20a5f2];
}

- (void)setBorderRadius:(CGFloat)borderRadius
{
    borderRadius = MAX(0.0, borderRadius);
    borderRadius = MIN(1.0, borderRadius);
    if (_borderRadius != borderRadius) {
        _borderRadius = borderRadius;
        [self.calendar setNeedsConfigureAppearance];
    }
}

- (void)setWeekdayTextColor:(UIColor *)weekdayTextColor
{
    if (![_weekdayTextColor isEqual:weekdayTextColor]) {
        _weekdayTextColor = weekdayTextColor;
        [self.calendar setNeedsConfigureAppearance];
    }
}

- (void)setHeaderTitleColor:(UIColor *)color
{
    if (![_headerTitleColor isEqual:color]) {
        _headerTitleColor = color;
        [self.calendar setNeedsConfigureAppearance];
    }
}

- (void)setHeaderMinimumDissolvedAlpha:(CGFloat)headerMinimumDissolvedAlpha
{
    if (_headerMinimumDissolvedAlpha != headerMinimumDissolvedAlpha) {
        _headerMinimumDissolvedAlpha = headerMinimumDissolvedAlpha;
        [self.calendar setNeedsConfigureAppearance];
    }
}

- (void)setHeaderDateFormat:(NSString *)headerDateFormat
{
    if (![_headerDateFormat isEqual:headerDateFormat]) {
        _headerDateFormat = headerDateFormat;
        [self.calendar setNeedsConfigureAppearance];
    }
}

- (void)setCaseOptions:(FSCalendarCaseOptions)caseOptions
{
    if (_caseOptions != caseOptions) {
        _caseOptions = caseOptions;
        [self.calendar setNeedsConfigureAppearance];
    }
}

- (void)setSeparators:(FSCalendarSeparators)separators
{
    if (_separators != separators) {
        _separators = separators;
        [_calendar.collectionView.collectionViewLayout invalidateLayout];
    }
}

@end


@implementation FSCalendarAppearance (Deprecated)

- (void)setUseVeryShortWeekdaySymbols:(BOOL)useVeryShortWeekdaySymbols
{
    _caseOptions &= 15;
    self.caseOptions |= (useVeryShortWeekdaySymbols*FSCalendarCaseOptionsWeekdayUsesSingleUpperCase);
}

- (BOOL)useVeryShortWeekdaySymbols
{
    return (_caseOptions & (15<<4) ) == FSCalendarCaseOptionsWeekdayUsesSingleUpperCase;
}

- (void)setTitleVerticalOffset:(CGFloat)titleVerticalOffset
{
    self.titleOffset = CGPointMake(0, titleVerticalOffset);
}

- (CGFloat)titleVerticalOffset
{
    return self.titleOffset.y;
}

- (void)setSubtitleVerticalOffset:(CGFloat)subtitleVerticalOffset
{
    self.subtitleOffset = CGPointMake(0, subtitleVerticalOffset);
}

- (CGFloat)subtitleVerticalOffset
{
    return self.subtitleOffset.y;
}

- (void)setEventColor:(UIColor *)eventColor
{
    self.eventDefaultColor = eventColor;
}

- (UIColor *)eventColor
{
    return self.eventDefaultColor;
}

- (void)setCellShape:(FSCalendarCellShape)cellShape
{
    self.borderRadius = 1-cellShape;
}

- (FSCalendarCellShape)cellShape
{
    return self.borderRadius==1.0?FSCalendarCellShapeCircle:FSCalendarCellShapeRectangle;
}

- (void)setTitleTextSize:(CGFloat)titleTextSize
{
    self.titleFont = [UIFont fontWithName:self.titleFont.fontName size:titleTextSize];
}

- (void)setSubtitleTextSize:(CGFloat)subtitleTextSize
{
    self.subtitleFont = [UIFont fontWithName:self.subtitleFont.fontName size:subtitleTextSize];
}

- (void)setWeekdayTextSize:(CGFloat)weekdayTextSize
{
    self.weekdayFont = [UIFont fontWithName:self.weekdayFont.fontName size:weekdayTextSize];
}

- (void)setHeaderTitleTextSize:(CGFloat)headerTitleTextSize
{
    self.headerTitleFont = [UIFont fontWithName:self.headerTitleFont.fontName size:headerTitleTextSize];
}

- (void)invalidateAppearance
{
    [self.calendar setNeedsConfigureAppearance];
}

- (void)setAdjustsFontSizeToFitContentSize:(BOOL)adjustsFontSizeToFitContentSize {}
- (BOOL)adjustsFontSizeToFitContentSize { return YES; }

@end


