//
//  UIColor+SHYUtil.h
//  SHYFramework
//
//  Created by wangzhongbin on 15/1/16.
//  Copyright (c) 2015年 SHYFramework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define SHY_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a/255.0]

#define SHY_RGB(r, g, b) SHY_RGBA(r, g, b, 255.0)


@interface UIColor (SHYUtil)

/*!
 @method shy_colorWithHex:
 @abstract 把十六进制转成 UIColor，如0x666666(RGB),0xff666666(ARGB)
 @param hex 十六进制颜色值
 @result 返回UIColor对象
 */
+ (UIColor *)shy_colorWithHex:(unsigned int)hex;

/*!
 @method shy_colorWithHex:alpha:
 @abstract 把十六进制转成 UIColor
 @param hex 十六进制颜色值不函透明值
 @param alpha 透明度为0.0~1.0
 @result 返回UIColor对象
 */
+ (UIColor *)shy_colorWithHex:(unsigned int)hex alpha:(CGFloat)alpha;

/*!
 @method shy_colorWithHexString:
 @abstract 把html颜色值转换UIColor,比如:#ff666666,#666666,0X666666,666666
 @param string html颜色值
 @result 返回UIColor对象
 */
+ (UIColor *)shy_colorWithHexString:(NSString *)string;

@end
