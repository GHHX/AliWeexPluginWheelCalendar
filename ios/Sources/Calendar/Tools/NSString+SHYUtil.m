//
//  NSString+SHYUtil.m
//  SHYFramework
//
//  Created by wangzhongbin on 15/1/16.
//  Copyright (c) 2015年 SHYFramework. All rights reserved.
//

#import "NSString+SHYUtil.h"
#import <CommonCrypto/CommonDigest.h>

#define SHY_CONVERT_USING(strtowhat) {\
    char buf[24];\
        if ([self getCString:buf maxLength:24 encoding:NSASCIIStringEncoding]) \
        return strtowhat(buf, NULL, 10);\
    } \
    return strtowhat([self UTF8String], NULL, 10);

@implementation NSString (SHYUtil)

- (char)shy_charValue
{
    const char *str = [self UTF8String];
    return str[0];
}

- (unsigned char)shy_unsignedCharValue
{
    const char *str = [self UTF8String];
    return (unsigned char)str[0];
}

- (BOOL)shy_boolValue
{
    if (([self caseInsensitiveCompare:@"YES"] == NSOrderedSame)
        || ([self caseInsensitiveCompare:@"Y"]  == NSOrderedSame)
        || [self isEqualToString:@"1"]
        || ([self caseInsensitiveCompare:@"true"] == NSOrderedSame)
        || ([self caseInsensitiveCompare:@"t"] == NSOrderedSame)){
        return YES;
    }
    else {
        return NO;
    }
}

- (short)shy_shortValue
{
    int i = [self intValue];
    return (short)i;
}

- (unsigned short)shy_unsignedShortValue
{
    return (unsigned short)[self shy_unsignedLongValue];
}

- (unsigned int)shy_unsignedIntValue
{
    return (unsigned int)[self shy_unsignedLongValue];
}

- (long)shy_longValue
{
    SHY_CONVERT_USING(strtol);
}

- (unsigned long)shy_unsignedLongValue
{
    SHY_CONVERT_USING(strtoul);
}

- (unsigned long long)shy_unsignedLongLongValue
{
    SHY_CONVERT_USING(strtoull);
}

- (NSUInteger)shy_unsignedIntegerValue
{
    return (NSUInteger)[self shy_unsignedLongValue];
}

- (NSNumber *)shy_numberValue
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    return [formatter numberFromString:self];
}

- (NSArray *)shy_arrayValue
{
    return [NSArray arrayWithObject:self];
}

- (NSDictionary *)shy_dictionaryValue
{
    return [self propertyList];
}

- (NSData *)shy_dataValue
{
    return [self dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
}

- (NSDecimal)shy_decimalValue
{
    return [[NSDecimalNumber decimalNumberWithString:self] decimalValue];
}

- (NSDecimalNumber *)shy_decimalNumberValue
{
    return [NSDecimalNumber decimalNumberWithString:self];
}

- (BOOL)shy_isNotEmpty{
    return (self.length > 0);
}

- (BOOL)shy_isEmpty
{
    return (self.length == 0);
}

- (NSString *)shy_trim
{
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

- (NSString *)shy_md5
{
    const char *str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [hash appendFormat:@"%02X", result[i]];
    return hash;
}

- (NSString *)shy_stringByUrlEncoding
{
    return [self shy_stringByUrlEncoding:kCFStringEncodingUTF8];
}

- (NSString *)shy_stringByUrlEncoding:(CFStringEncoding)encoding
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, (__bridge CFStringRef)@"!*'();:@&=+$,/?%#[]", encoding));
}

- (NSString *)shy_stringByUrlDecode
{
    return [self shy_stringByUrlDecode:NSUTF8StringEncoding];
}

- (NSString *)shy_stringByUrlDecode:(NSStringEncoding)encoding
{
    return [self stringByReplacingPercentEscapesUsingEncoding:encoding];
}

- (CGSize)sizeOfStringWithWidth:(float)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *tdic = @{NSFontAttributeName: font};
        size = [self boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:tdic
                                  context:nil].size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    
    return size;
}

+ (CGSize)sizeOfString:(NSString *)text withWidth:(float)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *tdic = @{NSFontAttributeName: font};
        size = [text boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:tdic
                                  context:nil].size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    
    return size;
}

+ (CGSize)sizeOfString:(NSString *)text withHeight:(float)height font:(UIFont *)font {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    
    if (!font) {
        return CGSizeZero;
    }
    
    if ([text respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *tdic = @{NSFontAttributeName: font};
        size = [text boundingRectWithSize:size
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                               attributes:tdic
                                  context:nil].size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        size = [text sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    
    return size;
}


@end
