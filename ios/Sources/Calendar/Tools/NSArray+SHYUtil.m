//
//  NSArray+SHYUtil.m
//  SHYFramework
//
//  Created by wangzhongbin on 15/1/16.
//  Copyright (c) 2015年 SHYFramework. All rights reserved.
//

#import "NSArray+SHYUtil.h"
#import "NSString+SHYUtil.h"

@implementation NSArray (SHYUtil)

- (id)shy_anyObject
{
    return [self count] > 0 ? [self shy_objectAtIndexCheck:0] : nil;
}

- (BOOL)shy_isEmpty
{
    return ([self count] == 0);
}

- (id)shy_objectAtIndexCheck:(NSUInteger)index
{
    if (index >= [self count]) {
        return nil;
    }
    
    id value = [self objectAtIndex:index];
    if (value == [NSNull null]) {
        return nil;
    }
    return value;
}

- (id)shy_objectAtIndexCheck:(NSUInteger)index class:(__unsafe_unretained Class)aClass
{
    return [self shy_objectAtIndexCheck:index class:aClass defaultValue:nil];
}

- (id)shy_objectAtIndexCheck:(NSUInteger)index class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
    if (![value isKindOfClass:aClass]) {
        return defaultValue;
    }
    return value;
}

- (NSArray *)shy_arrayAtIndex:(NSUInteger)index
{
    return [self shy_arrayAtIndex:index defaultValue:nil];
}

- (NSArray *)shy_arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue
{
    return [self shy_objectAtIndexCheck:index class:[NSArray class] defaultValue:defaultValue];
}

- (NSMutableArray *)shy_mutableArrayAtIndex:(NSUInteger)index
{
    return [self shy_mutableArrayAtIndex:index defaultValue:nil];
}

- (NSMutableArray *)shy_mutableArrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue
{
    return [self shy_objectAtIndexCheck:index class:[NSMutableArray class] defaultValue:defaultValue];
}

- (NSDictionary *)shy_dictionaryAtIndex:(NSUInteger)index
{
    return [self shy_dictionaryAtIndex:index defaultValue:nil];
}

- (NSDictionary *)shy_dictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)defaultValue
{
    return [self shy_objectAtIndexCheck:index class:[NSDictionary class] defaultValue:defaultValue];
}

- (NSMutableDictionary *)shy_mutableDictionaryAtIndex:(NSUInteger)index
{
    return [self shy_mutableDictionaryAtIndex:index defaultValue:nil];
}

- (NSMutableDictionary *)shy_mutableDictionaryAtIndex:(NSUInteger)index defaultValue:(NSMutableDictionary *)defaultValue
{
    return [self shy_objectAtIndexCheck:index class:[NSMutableDictionary class] defaultValue:defaultValue];
}

- (NSData *)shy_dataAtIndex:(NSUInteger)index
{
    return [self shy_dataAtIndex:index defaultValue:nil];
}

- (NSData *)shy_dataAtIndex:(NSUInteger)index defaultValue:(NSData *)defaultValue
{
    return [self shy_objectAtIndexCheck:index class:[NSData class] defaultValue:defaultValue];
}

- (NSString *)shy_stringAtIndex:(NSUInteger)index
{
    return [self shy_stringAtIndex:index defaultValue:nil];
}

- (NSString *)shy_stringAtIndexToString:(NSUInteger)index
{
    return [self shy_stringAtIndex:index defaultValue:@""];
}

- (NSString *)shy_stringAtIndex:(NSUInteger)index defaultValue:(NSString *)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
    
    if ([value isKindOfClass:[NSNumber class]]) {
        return [value stringValue];
    }
    
    if (![value isKindOfClass:[NSString class]]) {
        return defaultValue;
    }
    return value;
}

- (NSNumber *)shy_numberAtIndex:(NSUInteger)index
{
    return [self shy_numberAtIndex:index defaultValue:nil];
}

- (NSNumber *)shy_numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSString class]]) {
        return [value shy_numberValue];
    }
    
    if (![value isKindOfClass:[NSNumber class]]) {
        return defaultValue;
    }
    
    return value;
}

- (char)shy_charAtIndex:(NSUInteger)index
{
    id value = [self shy_objectAtIndexCheck:index];
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

- (unsigned char)shy_unsignedCharAtIndex:(NSUInteger)index
{
    id value = [self shy_objectAtIndexCheck:index];
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

- (short)shy_shortAtIndex:(NSUInteger)index
{
    return [self shy_shortAtIndex:index defaultValue:0];
}

- (short)shy_shortAtIndex:(NSUInteger)index defaultValue:(short)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
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

- (unsigned short)shy_unsignedShortAtIndex:(NSUInteger)index
{
    return [self shy_unsignedShortAtIndex:index defaultValue:0];
}

- (unsigned short)shy_unsignedShortAtIndex:(NSUInteger)index defaultValue:(unsigned short)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
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

- (int)shy_intAtIndex:(NSUInteger)index
{
    return [self shy_intAtIndex:index defaultValue:0];
}

- (int)shy_intAtIndex:(NSUInteger)index defaultValue:(int)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value intValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned int)shy_unsignedIntAtIndex:(NSUInteger)index
{
    return [self shy_unsignedIntAtIndex:index defaultValue:0];
}

- (unsigned int)shy_unsignedIntAtIndex:(NSUInteger)index defaultValue:(unsigned int)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
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

- (long)shy_longAtIndex:(NSUInteger)index
{
    return [self shy_longAtIndex:index defaultValue:0];
}

- (long)shy_longAtIndex:(NSUInteger)index defaultValue:(long)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
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

- (unsigned long)shy_unsignedLongAtIndex:(NSUInteger)index
{
    return [self shy_unsignedLongAtIndex:index defaultValue:0];
}

- (unsigned long)shy_unsignedLongAtIndex:(NSUInteger)index defaultValue:(unsigned long)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
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

- (long long)shy_longLongAtIndex:(NSUInteger)index
{
    return [self shy_longLongAtIndex:index defaultValue:0];
}

- (long long)shy_longLongAtIndex:(NSUInteger)index defaultValue:(long long)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value longLongValue];
    }
    else {
        return defaultValue;
    }
}

- (unsigned long long)shy_unsignedLongLongAtIndex:(NSUInteger)index
{
    return [self shy_unsignedLongLongAtIndex:index defaultValue:0];
}

- (unsigned long long)shy_unsignedLongLongAtIndex:(NSUInteger)index defaultValue:(unsigned long long)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
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

- (float)shy_floatAtIndex:(NSUInteger)index
{
    return [self shy_floatAtIndex:index defaultValue:0.0];
}

- (float)shy_floatAtIndex:(NSUInteger)index defaultValue:(float)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        float result = [value floatValue];
        return isnan(result) ? defaultValue : result;
    }
    else {
        return defaultValue;
    }
}

- (double)shy_doubleAtIndex:(NSUInteger)index
{
    return [self shy_doubleAtIndex:index defaultValue:0.0];
}

- (double)shy_doubleAtIndex:(NSUInteger)index defaultValue:(double)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        double result = [value doubleValue];
        return isnan(result) ? defaultValue : result;
    }
    else {
        return defaultValue;
    }
}

- (BOOL)shy_boolAtIndex:(NSUInteger)index
{
    return [self shy_boolAtIndex:index defaultValue:NO];
}

- (BOOL)shy_boolAtIndex:(NSUInteger)index defaultValue:(BOOL)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value boolValue];
    }
    else {
        return defaultValue;
    }
}

- (NSInteger)shy_integerAtIndex:(NSUInteger)index
{
    return [self shy_integerAtIndex:index defaultValue:0];
}

- (NSInteger)shy_integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
    if ([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]]) {
        return [value integerValue];
    }
    else {
        return defaultValue;
    }
}

- (NSUInteger)shy_unsignedIntegerAtIndex:(NSUInteger)index
{
    return [self shy_unsignedIntegerAtIndex:index defaultValue:0];
}

- (NSUInteger)shy_unsignedIntegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
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

- (CGPoint)shy_pointAtIndex:(NSUInteger)index
{
    return [self shy_pointAtIndex:index defaultValue:CGPointZero];
}

- (CGPoint)shy_pointAtIndex:(NSUInteger)index defaultValue:(CGPoint)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
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

- (CGSize)shy_sizeAtIndex:(NSUInteger)index
{
    return [self shy_sizeAtIndex:index defaultValue:CGSizeZero];
}

- (CGSize)shy_sizeAtIndex:(NSUInteger)index defaultValue:(CGSize)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
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

- (CGRect)shy_rectAtIndex:(NSUInteger)index
{
    return [self shy_rectAtIndex:index defaultValue:CGRectZero];
}

- (CGRect)shy_rectAtIndex:(NSUInteger)index defaultValue:(CGRect)defaultValue
{
    id value = [self shy_objectAtIndexCheck:index];
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

@implementation NSMutableArray (SHYUtil)

- (void)shy_addObjects:(id)objects, ...
{
    if (objects == nil)
        return;
    
    [self shy_addObjectCheck:objects];
    
    id next;
    va_list list;
    
    va_start(list, objects);
    while ((next = va_arg(list, id)) != nil)
    {
        [self shy_addObjectCheck:next];
    }
    va_end(list);
}

- (void)shy_addObjectCheck:(id)anObject
{
    if (anObject == nil) {
        return;
    }
    [self addObject:anObject];
}

- (void)shy_addChar:(char)value
{
    [self shy_addObjectCheck:[NSNumber numberWithChar:value]];
}

- (void)shy_addUnsignedChar:(unsigned char)value
{
    [self shy_addObjectCheck:[NSNumber numberWithUnsignedChar:value]];
}

- (void)shy_addShort:(short)value
{
    [self shy_addObjectCheck:[NSNumber numberWithShort:value]];
}

- (void)shy_addUnsignedShort:(unsigned short)value
{
    [self shy_addObjectCheck:[NSNumber numberWithUnsignedShort:value]];
}

- (void)shy_addInt:(int)value
{
    [self shy_addObjectCheck:[NSNumber numberWithInt:value]];
}

- (void)shy_addUnsignedInt:(unsigned int)value
{
    [self shy_addObjectCheck:[NSNumber numberWithUnsignedInt:value]];
}

- (void)shy_addLong:(long)value
{
    [self shy_addObjectCheck:[NSNumber numberWithLong:value]];
}

- (void)shy_addUnsignedLong:(unsigned long)value
{
    [self shy_addObjectCheck:[NSNumber numberWithUnsignedLong:value]];
}

- (void)shy_addLongLong:(long long)value
{
    [self shy_addObjectCheck:[NSNumber numberWithLongLong:value]];
}

- (void)shy_addUnsignedLongLong:(unsigned long long)value
{
    [self shy_addObjectCheck:[NSNumber numberWithUnsignedLongLong:value]];
}

- (void)shy_addFloat:(float)value
{
    [self shy_addObjectCheck:[NSNumber numberWithFloat:value]];
}

- (void)shy_addDouble:(double)value
{
    [self shy_addObjectCheck:[NSNumber numberWithDouble:value]];
}

- (void)shy_addBool:(BOOL)value
{
    [self shy_addObjectCheck:[NSNumber numberWithBool:value]];
}

- (void)shy_addInteger:(NSInteger)value
{
    [self shy_addObjectCheck:[NSNumber numberWithInteger:value]];
}

- (void)shy_addUnsignedInteger:(NSUInteger)value
{
    [self shy_addObjectCheck:[NSNumber numberWithUnsignedInteger:value]];
}

- (void)shy_addPointValue:(CGPoint)value
{
    [self shy_addObjectCheck:[NSValue valueWithCGPoint:value]];
}

- (void)shy_addSizeValue:(CGSize)value
{
    [self shy_addObjectCheck:[NSValue valueWithCGSize:value]];
}

- (void)shy_addRectValue:(CGRect)value
{
    [self shy_addObjectCheck:[NSValue valueWithCGRect:value]];
}

- (void)shy_insertObjectCheck:(id)anObject atIndex:(NSUInteger)index
{
    if (anObject == nil) {
        return;
    }
    if (index > [self count]) {
        return;
    }
    [self insertObject:anObject atIndex:index];
}

- (void)shy_insertChar:(char)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithChar:value] atIndex:index];
}

- (void)shy_insertUnsignedChar:(unsigned char)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithUnsignedChar:value] atIndex:index];
}

- (void)shy_insertShort:(short)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithShort:value] atIndex:index];
}

- (void)shy_insertUnsignedShort:(unsigned short)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithUnsignedShort:value] atIndex:index];
}

- (void)shy_insertInt:(int)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithInt:value] atIndex:index];
}

- (void)shy_insertUnsignedInt:(unsigned int)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithUnsignedInt:value] atIndex:index];
}

- (void)shy_insertLong:(long)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithLong:value] atIndex:index];
}

- (void)shy_insertUnsignedLong:(unsigned long)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithUnsignedLong:value] atIndex:index];
}

- (void)shy_insertLongLong:(long long)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithLongLong:value] atIndex:index];
}

- (void)shy_insertUnsignedLongLong:(unsigned long long)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithUnsignedLongLong:value] atIndex:index];
}

- (void)shy_insertFloat:(float)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithFloat:value] atIndex:index];
}

- (void)shy_insertDouble:(double)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithDouble:value] atIndex:index];
}

- (void)shy_insertBool:(BOOL)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithBool:value] atIndex:index];
}

- (void)shy_insertInteger:(NSInteger)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithInteger:value] atIndex:index];
}

- (void)shy_insertUnsignedInteger:(NSUInteger)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSNumber numberWithUnsignedInteger:value] atIndex:index];
}

- (void)shy_insertPointValue:(CGPoint)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSValue valueWithCGPoint:value] atIndex:index];
}

- (void)shy_insertSizeValue:(CGSize)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSValue valueWithCGSize:value] atIndex:index];
}

- (void)shy_insertRectValue:(CGRect)value atIndex:(NSUInteger)index
{
    [self shy_insertObjectCheck:[NSValue valueWithCGRect:value] atIndex:index];
}

- (void)shy_replaceObjectCheckAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (anObject == nil) {
        return;
    }
    
    if (index >= [self count]) {
        return;
    }
    
    [self replaceObjectAtIndex:index withObject:anObject];
}

- (void)shy_replaceCharAtIndex:(NSUInteger)index withChar:(char)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithChar:value]];
}

- (void)shy_replaceUnsignedCharAtIndex:(NSUInteger)index withUnsignedChar:(unsigned char)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedChar:value]];
}

- (void)shy_replaceShortAtIndex:(NSUInteger)index withShort:(short)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithShort:value]];
}

- (void)shy_replaceUnsignedShortAtIndex:(NSUInteger)index withUnsignedShort:(unsigned short)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedShort:value]];
}

- (void)shy_replaceIntAtIndex:(NSUInteger)index withInt:(int)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithInt:value]];
}

- (void)shy_replaceUnsignedIntAtIndex:(NSUInteger)index withUnsignedInt:(unsigned int)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedInt:value]];
}

- (void)shy_replaceLongAtIndex:(NSUInteger)index withLong:(long)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithLong:value]];
}

- (void)shy_replaceUnsignedLongAtIndex:(NSUInteger)index withUnsignedLong:(unsigned long)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedLong:value]];
}

- (void)shy_replaceLongLongAtIndex:(NSUInteger)index withLongLong:(long long)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithLongLong:value]];
}

- (void)shy_replaceUnsignedLongLongAtIndex:(NSUInteger)index withUnsignedLongLong:(unsigned long long)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedLongLong:value]];
}

- (void)shy_replaceFloatAtIndex:(NSUInteger)index withFloat:(float)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithFloat:value]];
}

- (void)shy_replaceDoubleAtIndex:(NSUInteger)index withDouble:(double)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithDouble:value]];
}

- (void)shy_replaceBoolAtIndex:(NSUInteger)index withBool:(BOOL)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithBool:value]];
}

- (void)shy_replaceIntegerAtIndex:(NSUInteger)index withInteger:(NSInteger)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithInteger:value]];
}

- (void)shy_replaceUnsignedIntegerAtIndex:(NSUInteger)index withUnsignedInteger:(NSUInteger)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSNumber numberWithUnsignedInteger:value]];
}

- (void)shy_replacePointValueAtIndex:(NSUInteger)index withPointValue:(CGPoint)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSValue valueWithCGPoint:value]];
}

- (void)shy_replaceSizeValueAtIndex:(NSUInteger)index withSizeValue:(CGSize)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSValue valueWithCGSize:value]];
}

- (void)shy_replaceRectValueAtIndex:(NSUInteger)index withRectValue:(CGRect)value
{
    [self shy_replaceObjectCheckAtIndex:index withObject:[NSValue valueWithCGRect:value]];
}

@end
