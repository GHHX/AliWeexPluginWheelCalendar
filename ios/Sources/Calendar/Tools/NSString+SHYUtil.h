//
//  NSString+SHYUtil.h
//  SHYFramework
//
//  Created by wangzhongbin on 15/1/16.
//  Copyright (c) 2015年 SHYFramework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (SHYUtil)

/*!
 @method shy_charValue
 @abstract 把字符串转为char类型
 @result 返回char
 */
- (char)shy_charValue;

/*!
 @method shy_unsignedCharValue
 @abstract 把字符串转为unsigned char类型
 @result 返回unsigned char
 */
- (unsigned char)shy_unsignedCharValue;

/*!
 @method shy_boolValue
 @abstract 把字符串转为BOOL类型
 @result 返回BOOL
 */
- (BOOL)shy_boolValue;

/*!
 @method shy_shortValue
 @abstract 把字符串转为short类型
 @result 返回short
 */
- (short)shy_shortValue;

/*!
 @method shy_unsignedShortValue
 @abstract 把字符串转为unsigned short类型
 @result 返回unsigned short
 */
- (unsigned short)shy_unsignedShortValue;

/*!
 @method shy_unsignedIntValue
 @abstract 把字符串转为unsigned int类型
 @result 返回unsigned int
 */
- (unsigned int)shy_unsignedIntValue;

/*!
 @method shy_longValue
 @abstract 把字符串转为long类型
 @result 返回long
 */
- (long)shy_longValue;

/*!
 @method shy_unsignedLongValue
 @abstract 把字符串转为unsigned long类型
 @result 返回unsigned long
 */
- (unsigned long)shy_unsignedLongValue;

/*!
 @method shy_unsignedLongLongValue
 @abstract 把字符串转为unsigned long long类型
 @result 返回unsigned long long
 */
- (unsigned long long)shy_unsignedLongLongValue;

/*!
 @method shy_unsignedIntegerValue
 @abstract 把字符串转为NSUInteger类型
 @result 返回NSUInteger
 */
- (NSUInteger)shy_unsignedIntegerValue;

/*!
 @method shy_numberValue
 @abstract 把字符串转为NSNumber类型
 @result 返回NSNumber
 */
- (NSNumber *)shy_numberValue;

/*!
 @method shy_arrayValue
 @abstract 把字符串转为NSArray类型
 @result 返回NSArray
 */
- (NSArray *)shy_arrayValue;

/*!
 @method shy_dictionaryValue
 @abstract 把字符串转为NSDictionary类型
 @result 返回NSDictionary
 */
- (NSDictionary *)shy_dictionaryValue;

/*!
 @method shy_dataValue
 @abstract 把字符串转为NSData类型，只支持UTF-8有损转换；排UTF-8编码的请用 dataUsingEncoding: 方法转
 @result 返回NSData
 */
- (NSData *)shy_dataValue;

/*!
 @method shy_decimalValue
 @abstract 把字符串转为NSDecimal类型
 @result 返回NSDecimal
 */
- (NSDecimal)shy_decimalValue;

/*!
 @method shy_decimalNumberValue
 @abstract 把字符串转为NSDecimalNumber类型
 @result 返回NSDecimalNumber
 */
- (NSDecimalNumber *)shy_decimalNumberValue;

/*!
 @method shy_isEmpty
 @abstract 是否没有字符串；没有字符串为YES;
 @result 返回BOOL
 */
- (BOOL)shy_isEmpty;

/*!
 @method shy_isNotEmpty
 @abstract 非空返回YES;
 @result 返回BOOL
 */
- (BOOL)shy_isNotEmpty;

/*!
 @method shy_trim
 @abstract 去除两端的空字符
 @result 返回去除两端的空字符的字符串
 */
- (NSString *)shy_trim;

/*!
 @method shy_md5
 @abstract 把字符串加密成md5
 @result 返回md5加密字符串
 */
- (NSString *)shy_md5;

/*!
 @method shy_stringByUrlEncoding
 @abstract 转义合法的URL字符串，默认编码为kCFStringEncodingUTF8，与stringByUrlDecode方法相反
 @result 返回URL字符串
 */
- (NSString *)shy_stringByUrlEncoding;

/*!
 @method shy_stringByUrlEncoding:
 @abstract 转义合法的URL字符串，与stringByUrlDecode方法相反
 @param encoding 编码
 @result 返回URL字符串
 */
- (NSString *)shy_stringByUrlEncoding:(CFStringEncoding)encoding;

/*!
 @method shy_stringByUrlDecode
 @abstract 把URL转义成正常字符串，默认编码为NSUTF8StringEncoding，与stringByUrlEncoding方法相反
 @result 返回字符串
 */
- (NSString *)shy_stringByUrlDecode;

/*!
 @method shy_stringByUrlDecode:
 @abstract 把URL转义成正常字符串，与stringByUrlEncoding方法相反
 @param encoding 编码
 @result 返回字符串
 */
- (NSString *)shy_stringByUrlDecode:(NSStringEncoding)encoding;

+ (CGSize)sizeOfString:(NSString *)text withWidth:(float)width font:(UIFont *)font;
+ (CGSize)sizeOfString:(NSString *)text withHeight:(float)height font:(UIFont *)font;

@end
