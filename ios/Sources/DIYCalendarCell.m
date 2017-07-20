//
//  DIYCalendarCell.m
//  FSCalendar
//
//  Created by dingwenchao on 02/11/2016.
//  Copyright © 2016 Wenchao Ding. All rights reserved.
//

#import "DIYCalendarCell.h"
#import "FSCalendarExtensions.h"
#import "UIColor+SHYUtil.h"

@interface DIYCalendarCell()
@end

@implementation DIYCalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CAShapeLayer *selectionLayer = [[CAShapeLayer alloc] init];
        selectionLayer.fillColor = [UIColor shy_colorWithHex:0x20a5f2].CGColor;
        selectionLayer.actions = @{@"hidden":[NSNull null]}; 
        [self.contentView.layer insertSublayer:selectionLayer below:self.titleLabel.layer];
        self.selectionLayer = selectionLayer;
        self.shapeLayer.hidden = YES;
        
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.backgroundView.frame = CGRectInset(self.bounds, 0, 0);
    CGRect layerRect = self.bounds;
    layerRect.size.height = layerRect.size.height - 5;
    self.selectionLayer.frame = layerRect;
    if (self.selectionType == SelectionTypeMiddle) {
        self.selectionLayer.fillColor = [UIColor shy_colorWithHex:0xebf5ff].CGColor;
        self.selectionLayer.path = [UIBezierPath bezierPathWithRect:self.selectionLayer.bounds].CGPath;
    } else if (self.selectionType == SelectionTypeLeftBorder) {
        self.selectionLayer.fillColor = [UIColor shy_colorWithHex:0x20a5f2].CGColor;
        self.selectionLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.selectionLayer.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(self.selectionLayer.fs_width/15, self.selectionLayer.fs_width/15)].CGPath;
        //[self.titleLabel setTextColor:[UIColor whiteColor]];
    } else if (self.selectionType == SelectionTypeRightBorder) {
        self.selectionLayer.fillColor = [UIColor shy_colorWithHex:0x20a5f2].CGColor;
        self.selectionLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.selectionLayer.bounds byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii:CGSizeMake(self.selectionLayer.fs_width/15, self.selectionLayer.fs_width/15)].CGPath;
        //[self.titleLabel setTextColor:[UIColor whiteColor]];
    } else if (self.selectionType == SelectionTypeSingle){
        //
        self.selectionLayer.fillColor = [UIColor shy_colorWithHex:0xff91f1].CGColor;
        CGFloat diameter = MIN(self.selectionLayer.fs_height, self.selectionLayer.fs_width);
        self.selectionLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(self.contentView.fs_width/2-diameter/2, self.contentView.fs_height/2-diameter/2, diameter, diameter)].CGPath;
    }
}

- (void)configureAppearance
{
    [super configureAppearance];
    // Override the build-in appearance configuration
    if (self.isPlaceholder) {
        self.titleLabel.textColor = [UIColor lightGrayColor];
        //self.eventIndicator.hidden = YES;
    }
}

- (void)setSelectionType:(SelectionType)selectionType
{
    if (_selectionType != selectionType) {
        _selectionType = selectionType;
        [self setNeedsLayout];
    }
}

@end
