//
//  NSArray+SHYUtil.h
//  SHYFramework
//
//  Created by wangzhongbin on 15/1/16.
//  Copyright (c) 2015年 SHYFramework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSArray (SHYUtil)

/*!
 @method shy_anyObject
 @abstract 获取数组里的一个对象，索引号小的优先返回
 @result 返回数组里的一个对象
 */
- (id)shy_anyObject;

/*!
 @method shy_isEmpty
 @abstract 是否没有对象，没有对象也是为YES；
 @result 返回BOOL
 */
- (BOOL)shy_isEmpty;

/*!
 @method shy_objectAtIndexCheck:
 @abstract 检查是否越界和NSNull如果是返回nil
 @result 返回对象
 */
- (id)shy_objectAtIndexCheck:(NSUInteger)index;

/*!
 @method shy_objectAtIndexCheck:class:defaultValue:
 @abstract 获取指定index的对象并检查是否越界和NSNull如果是返回nil
 @param index 索引号
 @param aClass 检查类型
 @result 返回对象
 */
- (id)shy_objectAtIndexCheck:(NSUInteger)index class:(__unsafe_unretained Class)aClass;

/*!
 @method shy_objectAtIndexCheck:class:defaultValue:
 @abstract 获取指定index的对象并检查是否越界和NSNull如果是返回nil,获取失败返回为指定的defaultValue
 @param index 索引号
 @param aClass 检查类型
 @param defaultValue 获取失败要返回的值
 @result 返回对象，获取失败为指定的defaultValue
 */
- (id)shy_objectAtIndexCheck:(NSUInteger)index class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue;

/*!
 @method shy_arrayAtIndex:
 @abstract 获取指定index的NSArray类型值
 @param index 索引号
 @result 返回NSArray，获取失败为nil
 */
- (NSArray *)shy_arrayAtIndex:(NSUInteger)index;

/*!
 @method shy_arrayAtIndex:defaultValue:
 @abstract 获取指定index的NSArray类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSArray，获取失败为指定的defaultValue
 */
- (NSArray *)shy_arrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue;

/*!
 @method shy_mutableArrayAtIndex:
 @abstract 获取指定index的NSMutableArray类型值
 @param index 索引号
 @result 返回NSMutableArray，获取失败为nil
 */
- (NSMutableArray *)shy_mutableArrayAtIndex:(NSUInteger)index;

/*!
 @method shy_mutableArrayAtIndex:defaultValue:
 @abstract 获取指定index的NSMutableArray类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSMutableArray，获取失败为指定的defaultValue
 */
- (NSMutableArray *)shy_mutableArrayAtIndex:(NSUInteger)index defaultValue:(NSArray *)defaultValue;

/*!
 @method shy_dictionaryAtIndex:
 @abstract 获取指定index的NSDictionary类型值
 @param index 索引号
 @result 返回NSDictionary，获取失败为nil
 */
- (NSDictionary *)shy_dictionaryAtIndex:(NSUInteger)index;

/*!
 @method shy_dictionaryAtIndex:defaultValue:
 @abstract 获取指定index的NSDictionary类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSDictionary，获取失败为指定的defaultValue
 */
- (NSDictionary *)shy_dictionaryAtIndex:(NSUInteger)index defaultValue:(NSDictionary *)defaultValue;

/*!
 @method shy_mutableDictionaryAtIndex:
 @abstract 获取指定index的NSMutableDictionary类型值
 @param index 索引号
 @result 返回NSMutableDictionary，获取失败为nil
 */
- (NSMutableDictionary *)shy_mutableDictionaryAtIndex:(NSUInteger)index;

/*!
 @method shy_mutableDictionaryAtIndex:defaultValue:
 @abstract 获取指定index的NSMutableDictionary类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSMutableDictionary，获取失败为指定的defaultValue
 */
- (NSMutableDictionary *)shy_mutableDictionaryAtIndex:(NSUInteger)index defaultValue:(NSMutableDictionary *)defaultValue;

/*!
 @method shy_dataAtIndex:
 @abstract 获取指定index的NSData类型值
 @param index 索引号
 @result 返回NSData，获取失败为nil
 */
- (NSData *)shy_dataAtIndex:(NSUInteger)index;

/*!
 @method shy_dataAtIndex:defaultValue:
 @abstract 获取指定index的NSData类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSData，获取失败为指定的defaultValue
 */
- (NSData *)shy_dataAtIndex:(NSUInteger)index defaultValue:(NSData *)defaultValue;

/*!
 @method shy_stringAtIndex:
 @abstract 获取指定index的NSString类型值
 @param index 索引号
 @result 返回NSString，获取失败为nil
 */
- (NSString *)shy_stringAtIndex:(NSUInteger)index;

/*!
 @method shy_stringAtIndexToString:
 @abstract 获取指定index的NSString类型值
 @param index 索引号
 @result 返回字NSString，获取失败为@""
 */
- (NSString *)shy_stringAtIndexToString:(NSUInteger)index;

/*!
 @method shy_stringAtIndex:defaultValue:
 @abstract 获取指定index的NSString类型值,获取失败返回为指定的defaultValue
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSString，获取失败为指定的defaultValue
 */
- (NSString *)shy_stringAtIndex:(NSUInteger)index defaultValue:(NSString *)defaultValue;

/*!
 @method shy_numberAtIndex:
 @abstract 获取指定index的NSNumber类型值
 @param index 索引号
 @result 返回NSNumber，获取失败为nil
 */
- (NSNumber *)shy_numberAtIndex:(NSUInteger)index;

/*!
 @method shy_numberAtIndex:defaultValue:
 @abstract 获取指定index的NSNumber类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSNumber，获取失败为指定的defaultValue
 */
- (NSNumber *)shy_numberAtIndex:(NSUInteger)index defaultValue:(NSNumber *)defaultValue;

/*!
 @method shy_charAtIndex:
 @abstract 获取指定index的NSNumber类型值
 @param index 索引号
 @result 返回char
 */
- (char)shy_charAtIndex:(NSUInteger)index;

/*!
 @method shy_unsignedCharAtIndex:
 @abstract 获取指定index的unsigned char类型值
 @param index 索引号
 @result 返回unsigned char
 */
- (unsigned char)shy_unsignedCharAtIndex:(NSUInteger)index;

/*!
 @method shy_shortAtIndex:
 @abstract 获取指定index的short类型值
 @param index 索引号
 @result 返回short，获取失败为0
 */
- (short)shy_shortAtIndex:(NSUInteger)index;

/*!
 @method shy_shortAtIndex:defaultValue:
 @abstract 获取指定index的short类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回short，获取失败为指定的defaultValue
 */
- (short)shy_shortAtIndex:(NSUInteger)index defaultValue:(short)defaultValue;

/*!
 @method shy_unsignedShortAtIndex:
 @abstract 获取指定index的unsigned short类型值
 @param index 索引号
 @result 返回unsigned short，获取失败为0
 */
- (unsigned short)shy_unsignedShortAtIndex:(NSUInteger)index;

/*!
 @method shy_unsignedShortAtIndex:defaultValue:
 @abstract 获取指定index的unsigned short类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned short，获取失败为指定的defaultValue
 */
- (unsigned short)shy_unsignedShortAtIndex:(NSUInteger)index defaultValue:(unsigned short)defaultValue;

/*!
 @method shy_intAtIndex:
 @abstract 获取指定index的int类型值
 @param index 索引号
 @result 返回int，获取失败为0
 */
- (int)shy_intAtIndex:(NSUInteger)index;

/*!
 @method shy_intAtIndex:defaultValue:
 @abstract 获取指定index的int类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回int，获取失败为指定的defaultValue
 */
- (int)shy_intAtIndex:(NSUInteger)index defaultValue:(int)defaultValue;

/*!
 @method shy_unsignedIntAtIndex:
 @abstract 获取指定index的unsigned int类型值
 @param index 索引号
 @result 返回unsigned int，获取失败为0
 */
- (unsigned int)shy_unsignedIntAtIndex:(NSUInteger)index;

/*!
 @method shy_unsignedIntAtIndex:defaultValue:
 @abstract 获取指定index的unsigned int类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned int，获取失败为指定的defaultValue
 */
- (unsigned int)shy_unsignedIntAtIndex:(NSUInteger)index defaultValue:(unsigned int)defaultValue;

/*!
 @method shy_longAtIndex:
 @abstract 获取指定index的long类型值
 @param index 索引号
 @result 返回long，获取失败为0
 */
- (long)shy_longAtIndex:(NSUInteger)index;

/*!
 @method shy_longAtIndex:defaultValue:
 @abstract 获取指定index的long类型值
 @param defaultValue 获取失败要返回的值
 @result 返回long，获取失败为指定的defaultValue
 */
- (long)shy_longAtIndex:(NSUInteger)index defaultValue:(long)defaultValue;

/*!
 @method shy_unsignedLongAtIndex:
 @abstract 获取指定index的unsigned long类型值
 @param index 索引号
 @result 返回unsigned long，获取失败为0
 */
- (unsigned long)shy_unsignedLongAtIndex:(NSUInteger)index;

/*!
 @method shy_unsignedLongAtIndex:defaultValue:
 @abstract 获取指定index的unsigned long类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned long，获取失败为指定的defaultValue
 */
- (unsigned long)shy_unsignedLongAtIndex:(NSUInteger)index defaultValue:(unsigned long)defaultValue;

/*!
 @method shy_longLongAtIndex:
 @abstract 获取指定index的long long类型值
 @param index 索引号
 @result 返回long long，获取失败为0
 */
- (long long)shy_longLongAtIndex:(NSUInteger)index;

/*!
 @method shy_longLongAtIndex:defaultValue:
 @abstract 获取指定index的long long类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回long long，获取失败为指定的defaultValue
 */
- (long long)shy_longLongAtIndex:(NSUInteger)index defaultValue:(long long)defaultValue;

/*!
 @method shy_unsignedLongLongAtIndex:
 @abstract 获取指定index的unsigned long long类型值
 @param index 索引号
 @result 返回unsigned long long，获取失败为0
 */
- (unsigned long long)shy_unsignedLongLongAtIndex:(NSUInteger)index;

/*!
 @method shy_unsignedLongLongAtIndex:defaultValue:
 @abstract 获取指定index的unsigned long long类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned long long，获取失败为指定的defaultValue
 */
- (unsigned long long)shy_unsignedLongLongAtIndex:(NSUInteger)index defaultValue:(unsigned long long)defaultValue;

/*!
 @method shy_floatAtIndex:
 @abstract 获取指定index的float类型值
 @param index 索引号
 @result 返回float，获取失败为0.0
 */
- (float)shy_floatAtIndex:(NSUInteger)index;

/*!
 @method shy_floatAtIndex:defaultValue:
 @abstract 获取指定index的float类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回float，获取失败为指定的defaultValue
 */
- (float)shy_floatAtIndex:(NSUInteger)index defaultValue:(float)defaultValue;

/*!
 @method shy_doubleAtIndex:
 @abstract 获取指定index的double类型值
 @param index 索引号
 @result 返回double，获取失败为0.0
 */
- (double)shy_doubleAtIndex:(NSUInteger)index;

/*!
 @method shy_doubleAtIndex:defaultValue:
 @abstract 获取指定index的double类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回double，获取失败为指定的defaultValue
 */
- (double)shy_doubleAtIndex:(NSUInteger)index defaultValue:(double)defaultValue;

/*!
 @method shy_boolAtIndex:
 @abstract 获取指定index的BOOL类型值
 @param index 索引号
 @result 返回BOOL，获取失败为NO
 */
- (BOOL)shy_boolAtIndex:(NSUInteger)index;

/*!
 @method shy_boolAtIndex:
 @abstract 获取指定index的BOOL类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回BOOL，获取失败为指定的defaultValue
 */
- (BOOL)shy_boolAtIndex:(NSUInteger)index defaultValue:(BOOL)defaultValue;

/*!
 @method shy_integerAtIndex:
 @abstract 获取指定index的NSInteger类型值
 @param index 索引号
 @result 返回NSInteger，获取失败为0
 */
- (NSInteger)shy_integerAtIndex:(NSUInteger)index;

/*!
 @method shy_integerAtIndex:defaultValue:
 @abstract 获取指定index的NSInteger类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSInteger，获取失败为指定的defaultValue
 */
- (NSInteger)shy_integerAtIndex:(NSUInteger)index defaultValue:(NSInteger)defaultValue;

/*!
 @method shy_unsignedIntegerAtIndex:
 @abstract 获取指定index的NSUInteger类型值
 @param index 索引号
 @result 返回NSUInteger，获取失败为0
 */
- (NSUInteger)shy_unsignedIntegerAtIndex:(NSUInteger)index;

/*!
 @method shy_unsignedIntegerAtIndex:defaultValue:
 @abstract 获取指定index的NSUInteger类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回NSUInteger，获取失败为指定的defaultValue
 */
- (NSUInteger)shy_unsignedIntegerAtIndex:(NSUInteger)index defaultValue:(NSUInteger)defaultValue;

/*!
 @method shy_pointAtIndex:
 @abstract 获取指定index的CGPoint类型值
 @param index 索引号
 @result 返回CGPoint，获取失败为CGPointZero
 */
- (CGPoint)shy_pointAtIndex:(NSUInteger)index;

/*!
 @method shy_pointAtIndex:defaultValue:
 @abstract 获取指定index的CGPoint类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回CGPoint，获取失败为指定的defaultValue
 */
- (CGPoint)shy_pointAtIndex:(NSUInteger)index defaultValue:(CGPoint)defaultValue;

/*!
 @method shy_sizeAtIndex:
 @abstract 获取指定index的CGSize类型值
 @param index 索引号
 @result 返回CGPoint，获取失败为CGSizeZero
 */
- (CGSize)shy_sizeAtIndex:(NSUInteger)index;

/*!
 @method shy_sizeAtIndex:defaultValue:
 @abstract 获取指定index的CGSize类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回CGSize，获取失败为指定的defaultValue
 */
- (CGSize)shy_sizeAtIndex:(NSUInteger)index defaultValue:(CGSize)defaultValue;

/*!
 @method shy_rectAtIndex:
 @abstract 获取指定index的CGRect类型值
 @param index 索引号
 @result 返回CGPoint，获取失败为CGRectZero
 */
- (CGRect)shy_rectAtIndex:(NSUInteger)index;

/*!
 @method shy_rectAtIndex:
 @abstract 获取指定index的CGRect类型值
 @param index 索引号
 @param defaultValue 获取失败要返回的值
 @result 返回CGRect，获取失败为指定的defaultValue
 */
- (CGRect)shy_rectAtIndex:(NSUInteger)index defaultValue:(CGRect)defaultValue;

@end

@interface NSMutableArray (SHYUtil)

/*!
 @method shy_addObjects:
 @abstract 把多个对象添加到数组里
 @param objects 要添加对象
 */
- (void)shy_addObjects:(id)objects, ... NS_REQUIRES_NIL_TERMINATION;

/*!
 @method shy_addObjectCheck:
 @abstract 检查对象是不是为 nil ;不是则添加
 @param anObject 要添加对象
 */
- (void)shy_addObjectCheck:(id)anObject;

/*!
 @method shy_addChar:
 @abstract 添加char类型值，到数组里
 @param value 值
 */
- (void)shy_addChar:(char)value;

/*!
 @method shy_addUnsignedChar:
 @abstract 添加unsigned char类型值，到数组里
 @param value 值
 */
- (void)shy_addUnsignedChar:(unsigned char)value;

/*!
 @method shy_addShort:
 @abstract 添加short类型值，到数组里
 @param value 值
 */
- (void)shy_addShort:(short)value;

/*!
 @method shy_addUnsignedShort:
 @abstract 添加unsigned short类型值，到数组里
 @param value 值
 */
- (void)shy_addUnsignedShort:(unsigned short)value;

/*!
 @method shy_addInt:
 @abstract 添加int类型值，到数组里
 @param value 值
 */
- (void)shy_addInt:(int)value;

/*!
 @method shy_addUnsignedInt:
 @abstract 添加unsigned int类型值，到数组里
 @param value 值
 */
- (void)shy_addUnsignedInt:(unsigned int)value;

/*!
 @method shy_addLong:
 @abstract 添加long类型值，到数组里
 @param value 值
 */
- (void)shy_addLong:(long)value;

/*!
 @method shy_addUnsignedLong:
 @abstract 添加unsigned long类型值，到数组里
 @param value 值
 */
- (void)shy_addUnsignedLong:(unsigned long)value;

/*!
 @method shy_addLongLong:
 @abstract 添加long long类型值，到数组里
 @param value 值
 */
- (void)shy_addLongLong:(long long)value;

/*!
 @method shy_addUnsignedLongLong:
 @abstract 添加unsigned long long类型值，到数组里
 @param value 值
 */
- (void)shy_addUnsignedLongLong:(unsigned long long)value;

/*!
 @method shy_addFloat:
 @abstract 添加float类型值，到数组里
 @param value 值
 */
- (void)shy_addFloat:(float)value;

/*!
 @method shy_addDouble:
 @abstract 添加double类型值，到数组里
 @param value 值
 */
- (void)shy_addDouble:(double)value;

/*!
 @method shy_addBool:
 @abstract 添加BOOL类型值，到数组里
 @param value 值
 */
- (void)shy_addBool:(BOOL)value;

/*!
 @method shy_addInteger:
 @abstract 添加NSInteger类型值，到数组里
 @param value 值
 */
- (void)shy_addInteger:(NSInteger)value;

/*!
 @method shy_addUnsignedInteger:
 @abstract 添加NSUInteger类型值，到数组里
 @param value 值
 */
- (void)shy_addUnsignedInteger:(NSUInteger)value;

/*!
 @method shy_addPointValue:
 @abstract 添加CGPoint类型值，到数组里
 @param value 值
 */
- (void)shy_addPointValue:(CGPoint)value;

/*!
 @method shy_addSizeValue:
 @abstract 添加CGSize类型值，到数组里
 @param value 值
 */
- (void)shy_addSizeValue:(CGSize)value;

/*!
 @method shy_addRectValue:
 @abstract 添加CGRect类型值，到数组里
 @param value 值
 */
- (void)shy_addRectValue:(CGRect)value;

/*!
 @method shy_insertObjectCheck:atIndex:
 @abstract 检查插入指定索引号的对象是不是为nil和越界，不是则插入
 @param index 插入到的索引号
 */
- (void)shy_insertObjectCheck:(id)anObject atIndex:(NSUInteger)index;

/*!
 @method shy_insertChar:atIndex:
 @abstract 插入指定索引号的char类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertChar:(char)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertUnsignedChar:atIndex:
 @abstract 插入指定索引号的unsigned char类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertUnsignedChar:(unsigned char)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertShort:atIndex:
 @abstract 插入指定索引号的short类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertShort:(short)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertUnsignedShort:atIndex:
 @abstract 插入指定索引号的unsigned short类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertUnsignedShort:(unsigned short)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertInt:atIndex:
 @abstract 插入指定索引号的int类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertInt:(int)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertUnsignedInt:atIndex:
 @abstract 插入指定索引号的unsigned int类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertUnsignedInt:(unsigned int)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertLong:atIndex:
 @abstract 插入指定索引号的long类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertLong:(long)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertUnsignedLong:atIndex:
 @abstract 插入指定索引号的unsigned long类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertUnsignedLong:(unsigned long)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertLongLong:atIndex:
 @abstract 插入指定索引号的long long类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertLongLong:(long long)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertUnsignedLongLong:atIndex:
 @abstract 插入指定索引号的unsigned long long类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertUnsignedLongLong:(unsigned long long)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertFloat:atIndex:
 @abstract 插入指定索引号的float类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertFloat:(float)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertDouble:atIndex:
 @abstract 插入指定索引号的double类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertDouble:(double)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertBool:atIndex:
 @abstract 插入指定索引号的BOOL类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertBool:(BOOL)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertInteger:atIndex:
 @abstract 插入指定索引号的NSInteger类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertInteger:(NSInteger)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertUnsignedInteger:atIndex:
 @abstract 插入指定索引号的NSUInteger类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertUnsignedInteger:(NSUInteger)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertPointValue:atIndex:
 @abstract 插入指定索引号的CGPoint类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertPointValue:(CGPoint)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertSizeValue:atIndex:
 @abstract 插入指定索引号的CGSize类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertSizeValue:(CGSize)value atIndex:(NSUInteger)index;

/*!
 @method shy_insertRectValue:atIndex:
 @abstract 插入指定索引号的CGRect类型值，到数组里
 @param value 值
 @param index 插入到的索引号
 */
- (void)shy_insertRectValue:(CGRect)value atIndex:(NSUInteger)index;

/*!
 @method shy_replaceObjectCheckAtIndex:withChar:
 @abstract 检查指定索引号,的对象是不是为nil和越界，不是则替换
 @param index 替换的索引号
 */
- (void)shy_replaceObjectCheckAtIndex:(NSUInteger)index withObject:(id)anObject;

/*!
 @method shy_replaceCharAtIndex:withChar:
 @abstract 指定索引号,替换char类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceCharAtIndex:(NSUInteger)index withChar:(char)value;

/*!
 @method shy_replaceUnsignedCharAtIndex:withUnsignedChar:
 @abstract 指定索引号,替换unsigned char类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceUnsignedCharAtIndex:(NSUInteger)index withUnsignedChar:(unsigned char)value;

/*!
 @method shy_replaceShortAtIndex:withShort:
 @abstract 指定索引号,替换short类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceShortAtIndex:(NSUInteger)index withShort:(short)value;

/*!
 @method shy_replaceUnsignedShortAtIndex:withUnsignedShort:
 @abstract 指定索引号,替换unsigned short类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceUnsignedShortAtIndex:(NSUInteger)index withUnsignedShort:(unsigned short)value;

/*!
 @method shy_replaceIntAtIndex:withInt:
 @abstract 指定索引号,替换int类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceIntAtIndex:(NSUInteger)index withInt:(int)value;

/*!
 @method shy_replaceUnsignedIntAtIndex:withUnsignedInt:
 @abstract 指定索引号,替换unsigned int类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceUnsignedIntAtIndex:(NSUInteger)index withUnsignedInt:(unsigned int)value;

/*!
 @method shy_replaceLongAtIndex:withLong:
 @abstract 指定索引号,替换long类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceLongAtIndex:(NSUInteger)index withLong:(long)value;

/*!
 @method shy_replaceUnsignedLongAtIndex:withUnsignedLong:
 @abstract 指定索引号,替换unsigned long类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceUnsignedLongAtIndex:(NSUInteger)index withUnsignedLong:(unsigned long)value;

/*!
 @method shy_replaceLongLongAtIndex:withLongLong:
 @abstract 指定索引号,替换long long类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceLongLongAtIndex:(NSUInteger)index withLongLong:(long long)value;

/*!
 @method shy_replaceUnsignedLongLongAtIndex:withUnsignedLongLong:
 @abstract 指定索引号,替换unsigned long long类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceUnsignedLongLongAtIndex:(NSUInteger)index withUnsignedLongLong:(unsigned long long)value;

/*!
 @method shy_replaceFloatAtIndex:withFloat:
 @abstract 指定索引号,替换float类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceFloatAtIndex:(NSUInteger)index withFloat:(float)value;

/*!
 @method shy_replaceDoubleAtIndex:withDouble:
 @abstract 指定索引号,替换double类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceDoubleAtIndex:(NSUInteger)index withDouble:(double)value;

/*!
 @method shy_replaceBoolAtIndex:withBool:
 @abstract 指定索引号,替换BOOL类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceBoolAtIndex:(NSUInteger)index withBool:(BOOL)value;

/*!
 @method shy_replaceIntegerAtIndex:withInteger:
 @abstract 指定索引号,替换NSInteger类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceIntegerAtIndex:(NSUInteger)index withInteger:(NSInteger)value;

/*!
 @method shy_replaceUnsignedIntegerAtIndex:withUnsignedInteger:
 @abstract 指定索引号,替换NSUInteger类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceUnsignedIntegerAtIndex:(NSUInteger)index withUnsignedInteger:(NSUInteger)value;

/*!
 @method shy_replacePointValueAtIndex:withPointValue:
 @abstract 指定索引号,替换CGPoint类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replacePointValueAtIndex:(NSUInteger)index withPointValue:(CGPoint)value;

/*!
 @method shy_replaceSizeValueAtIndex:withSizeValue:
 @abstract 指定索引号,替换CGSize类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceSizeValueAtIndex:(NSUInteger)index withSizeValue:(CGSize)value;

/*!
 @method shy_replaceRectValueAtIndex:withRectValue:
 @abstract 指定索引号,替换CGRect类型值
 @param index 替换的索引号
 @param value 值
 */
- (void)shy_replaceRectValueAtIndex:(NSUInteger)index withRectValue:(CGRect)value;

@end
