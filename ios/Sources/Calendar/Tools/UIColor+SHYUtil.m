//
//  UIColor+SHYUtil.m
//  SHYFramework
//
//  Created by wangzhongbin on 15/1/16.
//  Copyright (c) 2015年 SHYFramework. All rights reserved.
//

#import "UIColor+SHYUtil.h"

@implementation UIColor (SHYUtil)

+ (UIColor *)shy_colorWithHex:(unsigned int)hex
{
    int a = (hex & 0xFF000000) ? (hex & 0xFF000000) >> 24 : 255.0;
    int r = (hex & 0x00FF0000) >> 16;
    int g = (hex & 0x0000FF00) >> 8;
    int b = (hex & 0x000000FF);
    return SHY_RGBA(r, g, b, a);
}

+ (UIColor *)shy_colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha
{
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alpha];
}

@end
