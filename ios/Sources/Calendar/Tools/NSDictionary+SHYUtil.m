//
//  NSDictionary+Util.m
//  SHYFramework
//
//  Created by wangzhongbin on 15/1/16.
//  Copyright (c) 2015年 SHYFramework. All rights reserved.
//

#import "NSDictionary+SHYUtil.h"
#import "NSString+SHYUtil.h"

@implementation NSDictionary (SHYUtil)

+ (NSDictionary *)shy_dictionaryWithContentsOfData:(NSData *)data
{
    CFPropertyListRef plist =  CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (__bridge CFDataRef)data, kCFPropertyListImmutable, NULL);
    NSDictionary *result = (__bridge_transfer NSDictionary *)plist;
    if ([result isKindOfClass:[NSDictionary class]]) {
        return result;
    }
    else {
        CFRelease(plist);
        return nil;
    }
}

- (BOOL)shy_isEmpty
{
    return ([self count] == 0);
}

- (id)shy_objectForKeyCheck:(id)aKey
{
    if (aKey == nil) {
        return nil;
    }
    
    id value = [self objectForKey:aKey];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (id)shy_objectForKeyCheck:(id)key class:(__unsafe_unretained Class)aClass
{
    return [self shy_objectForKeyCheck:key class:aClass defaultValue:nil];
}

- (id)shy_objectForKeyCheck:(id)key class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if (![value isKindOfClass:aClass]) {
        return defaultValue;
    }
    return value;
}

- (NSArray *)shy_arrayForKey:(id)key
{
    return [self shy_arrayForKey:key defaultValue:nil];
}

- (NSArray *)shy_arrayForKey:(id)key defaultValue:(NSArray *)defaultValue
{
    return [self shy_objectForKeyCheck:key class:[NSArray class] defaultValue:defaultValue];
}

- (NSMutableArray *)shy_mutableArrayForKey:(id)key
{
    return [self shy_mutableArrayForKey:key defaultValue:nil];
}

- (NSMutableArray *)shy_mutableArrayForKey:(id)key defaultValue:(NSArray *)defaultValue
{
    return [self shy_objectForKeyCheck:key class:[NSMutableArray class] defaultValue:defaultValue];
}

- (NSDictionary *)shy_dictionaryForKey:(id)key
{
    return [self shy_dictionaryForKey:key defaultValue:nil];
}

- (NSDictionary *)shy_dictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue
{
    return [self shy_objectForKeyCheck:key class:[NSDictionary class] defaultValue:defaultValue];
}

- (NSMutableDictionary *)shy_mutableDictionaryForKey:(id)key
{
    return [self shy_mutableDictionaryForKey:key defaultValue:nil];
}

- (NSMutableDictionary *)shy_mutableDictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue
{
    return [self shy_objectForKeyCheck:key class:[NSMutableDictionary class] defaultValue:defaultValue];
}

- (NSData *)shy_dataForKey:(id)key
{
    return [self shy_dataForKey:key defaultValue:nil];
}

- (NSData *)shy_dataForKey:(id)key defaultValue:(NSData *)defaultValue
{
    return [self shy_objectForKeyCheck:key class:[NSData class] defaultValue:defaultValue];
}

- (NSString *)shy_stringForKey:(id)key
{
    return [self shy_stringForKey:key defaultValue:nil];
}

- (NSString *)shy_stringForKeyToString:(id)key
{
    return [self shy_stringForKey:key defaultValue:@""];
}

- (NSString *)shy_stringForKey:(id)key defaultValue:(NSString *)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    if (![value isKindOfClass:[NSString class]]) {
        return defaultValue;
    }
    return value;
}

- (NSNumber *)shy_numberForKey:(id)key
{
    return [self shy_numberForKey:key defaultValue:nil];
}

- (NSNumber *)shy_numberForKey:(id)key defaultValue:(NSNumber *)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    
    if ([value isKindOfClass:[NSString class]]) {
        return [value shy_numberValue];
    }
    
    if (![value isKindOfClass:[NSNumber class]]) {
        return defaultValue;
    }
    
    return value;
}

- (char)shy_charForKey:(id)key
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value charValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value shy_charValue];
    }
    else {
        return 0x0;
    }
}

- (unsigned char)shy_unsignedCharForKey:(id)key
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedCharValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value shy_unsignedCharValue];
    }
    else {
        return 0x0;
    }
}

- (short)shy_shortForKey:(id)key
{
    return [self shy_shortForKey:key defaultValue:0];
}

- (short)shy_shortForKey:(id)key defaultValue:(short)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value shortValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value shy_shortValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned short)shy_unsignedShortForKey:(id)key
{
    return [self shy_unsignedShortForKey:key defaultValue:0];
}

- (unsigned short)shy_unsignedShortForKey:(id)key defaultValue:(unsigned short)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedShortValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value shy_unsignedShortValue];
    }
    else {
        return defaultValue;
    }
}

- (int)shy_intForKey:(id)key
{
    return [self shy_intForKey:key defaultValue:0];
}

- (int)shy_intForKey:(id)key defaultValue:(int)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned int)shy_unsignedIntForKey:(id)key
{
    return [self shy_unsignedIntForKey:key defaultValue:0];
}

- (unsigned int)shy_unsignedIntForKey:(id)key defaultValue:(unsigned int)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value shy_unsignedIntValue];
    }
    else {
        return defaultValue;
    }
}

- (long)shy_longForKey:(id)key
{
    return [self shy_longForKey:key defaultValue:0];
}

- (long)shy_longForKey:(id)key defaultValue:(long)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value longValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value shy_longValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned long)shy_unsignedLongForKey:(id)key
{
    return [self shy_unsignedLongForKey:key defaultValue:0];
}

- (unsigned long)shy_unsignedLongForKey:(id)key defaultValue:(unsigned long)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value shy_unsignedLongValue];
    }
    else {
        return defaultValue;
    }
}

- (long long)shy_longLongForKey:(id)key
{
    return [self shy_longLongForKey:key defaultValue:0];
}

- (long long)shy_longLongForKey:(id)key defaultValue:(long long)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned long long)shy_unsignedLongLongForKey:(id)key
{
    return [self shy_unsignedLongLongForKey:key defaultValue:0];
}

- (unsigned long long)shy_unsignedLongLongForKey:(id)key defaultValue:(unsigned long long)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedLongLongValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value shy_unsignedLongLongValue];
    }
    else {
        return defaultValue;
    }
}

- (float)shy_floatForKey:(id)key
{
    return [self shy_floatForKey:key defaultValue:0.0];
}

- (float)shy_floatForKey:(id)key defaultValue:(float)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        float result = [value floatValue];
        return isnan(result) ? defaultValue : result;
    }
    else {
        return defaultValue;
    }
}

- (double)shy_doubleForKey:(id)key
{
    return [self shy_doubleForKey:key defaultValue:0.0];
}

- (double)shy_doubleForKey:(id)key defaultValue:(double)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        double result = [value doubleValue];
        return isnan(result) ? defaultValue : result;
    }
    else {
        return defaultValue;
    }
}

- (BOOL)shy_boolForKey:(id)key
{
    return [self shy_boolForKey:key defaultValue:NO];
}

- (BOOL)shy_boolForKey:(id)key defaultValue:(BOOL)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    else {
        return defaultValue;
    }
}

- (NSInteger)shy_integerForKey:(id)key
{
    return [self shy_integerForKey:key defaultValue:0];
}

- (NSInteger)shy_integerForKey:(id)key defaultValue:(NSInteger)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value integerValue];
    }
    else {
        return defaultValue;
    }
}

- (NSUInteger)shy_unsignedIntegerForKey:(id)key
{
    return [self shy_unsignedIntegerForKey:key defaultValue:0];
}

- (NSUInteger)shy_unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value unsignedIntegerValue];
    }
    else if ([value isKindOfClass:[NSString class]]) {
        return [value shy_unsignedIntegerValue];
    }
    else {
        return defaultValue;
    }
}

- (CGPoint)shy_pointForKey:(id)key
{
    return [self shy_pointForKey:key defaultValue:CGPointZero];
}

- (CGPoint)shy_pointForKey:(id)key defaultValue:(CGPoint)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSString class]] && ![value shy_isEmpty]) {
        return CGPointFromString(value);
    }
    else if ([value isKindOfClass:[NSValue class]]) {
        return [value CGPointValue];
    }
    else {
        return defaultValue;
    }
}

- (CGSize)shy_sizeForKey:(id)key
{
    return [self shy_sizeForKey:key defaultValue:CGSizeZero];
}

- (CGSize)shy_sizeForKey:(id)key defaultValue:(CGSize)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSString class]] && ![value shy_isEmpty]) {
        return CGSizeFromString(value);
    }
    else if ([value isKindOfClass:[NSValue class]]) {
        return [value CGSizeValue];
    }
    else {
        return defaultValue;
    }
}

- (CGRect)shy_rectForKey:(id)key
{
    return [self shy_rectForKey:key defaultValue:CGRectZero];
}

- (CGRect)shy_rectForKey:(id)key defaultValue:(CGRect)defaultValue
{
    id value = [self shy_objectForKeyCheck:key];
    if ([value isKindOfClass:[NSString class]] && ![value shy_isEmpty]) {
        return CGRectFromString(value);
    }
    else if ([value isKindOfClass:[NSValue class]]) {
        return [value CGRectValue];
    }
    else {
        return defaultValue;
    }
}

@end

@implementation NSMutableDictionary (SHYUtil)

- (void)shy_setObjectCheck:(id)anObject forKey:(id <NSCopying>)aKey
{
    if (aKey == nil) {
        return;
    }
    
    if (anObject == nil) {
        return;
    }
    
    [self setObject:anObject forKey:aKey];
}

- (void)shy_removeObjectForKeyCheck:(id)aKey
{
    if (aKey == nil) {
        return;
    }
    
    [self removeObjectForKey:aKey];
}

- (void)shy_setChar:(char)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithChar:value] forKey:key];
}

- (void)shy_setUnsignedChar:(unsigned char)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithUnsignedChar:value] forKey:key];
}

- (void)shy_setShort:(short)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithShort:value] forKey:key];
}

- (void)shy_setUnsignedShort:(unsigned short)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithUnsignedShort:value] forKey:key];
}

- (void)shy_setInt:(int)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithInt:value] forKey:key];
}

- (void)shy_setUnsignedInt:(unsigned int)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithUnsignedInt:value] forKey:key];
}

- (void)shy_setLong:(long)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithLong:value] forKey:key];
}

- (void)shy_setUnsignedLong:(unsigned long)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithUnsignedLong:value] forKey:key];
}

- (void)shy_setLongLong:(long long)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithLongLong:value] forKey:key];
}

- (void)shy_setUnsignedLongLong:(unsigned long long)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithUnsignedLongLong:value] forKey:key];
}

- (void)shy_setFloat:(float)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithFloat:value] forKey:key];
}

- (void)shy_setDouble:(double)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithDouble:value] forKey:key];
}

- (void)shy_setBool:(BOOL)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithBool:value] forKey:key];
}

- (void)shy_setInteger:(NSInteger)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithInteger:value] forKey:key];
}

- (void)shy_setUnsignedInteger:(NSUInteger)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSNumber numberWithUnsignedInteger:value] forKey:key];
}

- (void)shy_setPointValue:(CGPoint)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSValue valueWithCGPoint:value] forKey:key];
}

- (void)shy_setSizeValue:(CGSize)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSValue valueWithCGSize:value] forKey:key];
}

- (void)shy_setRectValue:(CGRect)value forKey:(id<NSCopying>)key
{
    [self shy_setObjectCheck:[NSValue valueWithCGRect:value] forKey:key];
}

@end
