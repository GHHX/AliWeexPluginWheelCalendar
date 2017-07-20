//
//  NSDictionary+SHYUtil.h
//  SHYFramework
//
//  Created by wangzhongbin on 15/1/16.
//  Copyright (c) 2015年 SHYFramework. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface NSDictionary (SHYUtil)

/*!
 @method shy_dictionaryWithContentsOfData:
 @abstract 把NSData数据转成NSDictionary
 @result 返回NSDictionary
 */
+ (NSDictionary *)shy_dictionaryWithContentsOfData:(NSData *)data;

/*!
 @method shy_isEmpty
 @abstract 是否空,字典里没有对象也是为YES；
 @result 返回bool
 */
- (BOOL)shy_isEmpty;

/*!
 @method shy_objectForKeyCheck
 @abstract 检查是否aKey为nil 和 NSNull null如果是返回nil
 @result 返回对象
 */
- (id)shy_objectForKeyCheck:(id)aKey;

/*!
 @method shy_objectForKeyCheck:class:
 @abstract 获取指定key的对象
 @param key 键
 @param aClass 检查类型
 @result 返回对象
 */
- (id)shy_objectForKeyCheck:(id)key class:(__unsafe_unretained Class)aClass;

/*!
 @method shy_objectForKeyCheck:class:defaultValue:
 @abstract 获取指定key的对象
 @param key 键
 @param aClass 检查类型
 @param defaultValue 获取失败要返回的值
 @result 返回对象，获取失败为指定的defaultValue
 */
- (id)shy_objectForKeyCheck:(id)key class:(__unsafe_unretained Class)aClass defaultValue:(id)defaultValue;

/*!
 @method shy_arrayForKey:
 @abstract 获取指定key的NSArray类型值
 @param key 键
 @result 返回NSArray，获取失败为nil
 */
- (NSArray *)shy_arrayForKey:(id)key;

/*!
 @method shy_arrayForKey:defaultValue:
 @abstract 获取指定key的NSArray类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回NSArray，获取失败为指定的defaultValue
 */
- (NSArray *)shy_arrayForKey:(id)key defaultValue:(NSArray *)defaultValue;

/*!
 @method shy_mutableArrayForKey:
 @abstract 获取指定key的NSMutableArray类型值
 @param key 键
 @result 返回NSMutableArray，获取失败为nil
 */
- (NSMutableArray *)shy_mutableArrayForKey:(id)key;

/*!
 @method shy_mutableArrayForKey:defaultValue:
 @abstract 获取指定key的NSMutableArray类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回NSMutableArray，获取失败为指定的defaultValue
 */
- (NSMutableArray *)shy_mutableArrayForKey:(id)key defaultValue:(NSArray *)defaultValue;

/*!
 @method shy_dictionaryForKey:
 @abstract 获取指定key的NSDictionary类型值
 @param key 键
 @result 返回NSDictionary，获取失败为nil
 */
- (NSDictionary *)shy_dictionaryForKey:(id)key;

/*!
 @method shy_dictionaryForKey:defaultValue:
 @abstract 获取指定key的NSDictionary类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回NSDictionary，获取失败为指定的defaultValue
 */
- (NSDictionary *)shy_dictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue;

/*!
 @method shy_mutableDictionaryForKey:
 @abstract 获取指定key的NSMutableDictionary类型值
 @param key 键
 @result 返回NSMutableDictionary，获取失败为nil
 */
- (NSMutableDictionary *)shy_mutableDictionaryForKey:(id)key;

/*!
 @method shy_mutableDictionaryForKey:defaultValue:
 @abstract 获取指定key的NSMutableDictionary类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回NSMutableDictionary，获取失败为指定的defaultValue
 */
- (NSMutableDictionary *)shy_mutableDictionaryForKey:(id)key defaultValue:(NSDictionary *)defaultValue;

/*!
 @method shy_dataForKey:
 @abstract 获取指定key的NSData类型值
 @param key 键
 @result 返回NSData，获取失败为nil
 */
- (NSData *)shy_dataForKey:(id)key;

/*!
 @method shy_dataForKey:defaultValue:
 @abstract 获取指定key的NSData类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回NSData，获取失败为指定的defaultValue
 */
- (NSData *)shy_dataForKey:(id)key defaultValue:(NSData *)defaultValue;

/*!
 @method shy_stringForKey:
 @abstract 获取指定key的NSString类型值
 @param key 键
 @result 返回NSString，获取失败为nil
 */
- (NSString *)shy_stringForKey:(id)key;

/*!
 @method shy_stringForKeyToString:
 @abstract 获取指定key的NSString类型值
 @param key 键
 @result 返回字NSString，获取失败为@""
 */
- (NSString *)shy_stringForKeyToString:(id)key;

/*!
 @method shy_stringForKey:defaultValue:
 @abstract 获取指定key的NSString类型值,获取失败返回为指定的defaultValue
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回NSString，获取失败为指定的defaultValue
 */
- (NSString *)shy_stringForKey:(id)key defaultValue:(NSString *)defaultValue;

/*!
 @method shy_numberForKey:
 @abstract 获取指定key的NSNumber类型值
 @param key 键
 @result 返回NSNumber，获取失败为nil
 */
- (NSNumber *)shy_numberForKey:(id)key;

/*!
 @method shy_numberForKey:defaultValue:
 @abstract 获取指定key的NSNumber类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回NSNumber，获取失败为指定的defaultValue
 */
- (NSNumber *)shy_numberForKey:(id)key defaultValue:(NSNumber *)defaultValue;

/*!
 @method shy_charForKey:
 @abstract 获取指定key的NSNumber类型值
 @param key 键
 @result 返回char
 */
- (char)shy_charForKey:(id)key;

/*!
 @method shy_unsignedCharForKey:
 @abstract 获取指定key的unsigned char类型值
 @param key 键
 @result 返回unsigned char
 */
- (unsigned char)shy_unsignedCharForKey:(id)key;

/*!
 @method shy_shortForKey:
 @abstract 获取指定key的short类型值
 @param key 键
 @result 返回short，获取失败为0
 */
- (short)shy_shortForKey:(id)key;

/*!
 @method shy_shortForKey:defaultValue:
 @abstract 获取指定key的short类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回short，获取失败为指定的defaultValue
 */
- (short)shy_shortForKey:(id)key defaultValue:(short)defaultValue;

/*!
 @method shy_unsignedShortForKey:
 @abstract 获取指定key的unsigned short类型值
 @param key 键
 @result 返回unsigned short，获取失败为0
 */
- (unsigned short)shy_unsignedShortForKey:(id)key;

/*!
 @method shy_unsignedShortForKey:defaultValue:
 @abstract 获取指定key的unsigned short类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned short，获取失败为指定的defaultValue
 */
- (unsigned short)shy_unsignedShortForKey:(id)key defaultValue:(unsigned short)defaultValue;

/*!
 @method shy_intForKey:
 @abstract 获取指定key的int类型值
 @param key 键
 @result 返回int，获取失败为0
 */
- (int)shy_intForKey:(id)key;

/*!
 @method shy_intForKey:defaultValue:
 @abstract 获取指定key的int类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回int，获取失败为指定的defaultValue
 */
- (int)shy_intForKey:(id)key defaultValue:(int)defaultValue;

/*!
 @method shy_unsignedIntForKey:
 @abstract 获取指定key的unsigned int类型值
 @param key 键
 @result 返回unsigned int，获取失败为0
 */
- (unsigned int)shy_unsignedIntForKey:(id)key;

/*!
 @method shy_unsignedIntForKey:defaultValue:
 @abstract 获取指定key的unsigned int类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned int，获取失败为指定的defaultValue
 */
- (unsigned int)shy_unsignedIntForKey:(id)key defaultValue:(unsigned int)defaultValue;

/*!
 @method shy_longForKey:
 @abstract 获取指定key的long类型值
 @param key 键
 @result 返回long，获取失败为0
 */
- (long)shy_longForKey:(id)key;

/*!
 @method shy_longForKey:defaultValue:
 @abstract 获取指定key的long类型值
 @param defaultValue 获取失败要返回的值
 @result 返回long，获取失败为指定的defaultValue
 */
- (long)shy_longForKey:(id)key defaultValue:(long)defaultValue;

/*!
 @method shy_unsignedLongForKey:
 @abstract 获取指定key的unsigned long类型值
 @param key 键
 @result 返回unsigned long，获取失败为0
 */
- (unsigned long)shy_unsignedLongForKey:(id)key;

/*!
 @method shy_unsignedLongForKey:defaultValue:
 @abstract 获取指定key的unsigned long类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned long，获取失败为指定的defaultValue
 */
- (unsigned long)shy_unsignedLongForKey:(id)key defaultValue:(unsigned long)defaultValue;

/*!
 @method shy_longLongForKey:
 @abstract 获取指定key的long long类型值
 @param key 键
 @result 返回long long，获取失败为0
 */
- (long long)shy_longLongForKey:(id)key;

/*!
 @method shy_longLongForKey:defaultValue:
 @abstract 获取指定key的long long类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回long long，获取失败为指定的defaultValue
 */
- (long long)shy_longLongForKey:(id)key defaultValue:(long long)defaultValue;

/*!
 @method shy_unsignedLongLongForKey:
 @abstract 获取指定key的unsigned long long类型值
 @param key 键
 @result 返回unsigned long long，获取失败为0
 */
- (unsigned long long)shy_unsignedLongLongForKey:(id)key;

/*!
 @method shy_unsignedLongLongForKey:defaultValue:
 @abstract 获取指定key的unsigned long long类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回unsigned long long，获取失败为指定的defaultValue
 */
- (unsigned long long)shy_unsignedLongLongForKey:(id)key defaultValue:(unsigned long long)defaultValue;

/*!
 @method shy_floatForKey:
 @abstract 获取指定key的float类型值
 @param key 键
 @result 返回float，获取失败为0.0
 */
- (float)shy_floatForKey:(id)key;

/*!
 @method shy_floatForKey:defaultValue:
 @abstract 获取指定key的float类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回float，获取失败为指定的defaultValue
 */
- (float)shy_floatForKey:(id)key defaultValue:(float)defaultValue;

/*!
 @method shy_doubleForKey:
 @abstract 获取指定key的double类型值
 @param key 键
 @result 返回double，获取失败为0.0
 */
- (double)shy_doubleForKey:(id)key;

/*!
 @method shy_doubleForKey:defaultValue:
 @abstract 获取指定key的double类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回double，获取失败为指定的defaultValue
 */
- (double)shy_doubleForKey:(id)key defaultValue:(double)defaultValue;

/*!
 @method shy_boolForKey:
 @abstract 获取指定key的BOOL类型值
 @param key 键
 @result 返回BOOL，获取失败为NO
 */
- (BOOL)shy_boolForKey:(id)key;

/*!
 @method shy_boolForKey:
 @abstract 获取指定key的BOOL类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回BOOL，获取失败为指定的defaultValue
 */
- (BOOL)shy_boolForKey:(id)key defaultValue:(BOOL)defaultValue;

/*!
 @method shy_integerForKey:
 @abstract 获取指定key的NSInteger类型值
 @param key 键
 @result 返回NSInteger，获取失败为0
 */
- (NSInteger)shy_integerForKey:(id)key;

/*!
 @method shy_integerForKey:defaultValue:
 @abstract 获取指定key的NSInteger类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回NSInteger，获取失败为指定的defaultValue
 */
- (NSInteger)shy_integerForKey:(id)key defaultValue:(NSInteger)defaultValue;

/*!
 @method shy_unsignedIntegerForKey:
 @abstract 获取指定key的NSUInteger类型值
 @param key 键
 @result 返回NSUInteger，获取失败为0
 */
- (NSUInteger)shy_unsignedIntegerForKey:(id)key;

/*!
 @method shy_unsignedIntegerForKey:defaultValue:
 @abstract 获取指定key的NSUInteger类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回NSUInteger，获取失败为指定的defaultValue
 */
- (NSUInteger)shy_unsignedIntegerForKey:(id)key defaultValue:(NSUInteger)defaultValue;

/*!
 @method shy_pointForKey:
 @abstract 获取指定key的CGPoint类型值
 @param key 键
 @result 返回CGPoint，获取失败为CGPointZero
 */
- (CGPoint)shy_pointForKey:(id)key;

/*!
 @method shy_pointForKey:defaultValue:
 @abstract 获取指定key的CGPoint类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回CGPoint，获取失败为指定的defaultValue
 */
- (CGPoint)shy_pointForKey:(id)key defaultValue:(CGPoint)defaultValue;

/*!
 @method shy_sizeForKey:
 @abstract 获取指定key的CGSize类型值
 @param key 键
 @result 返回CGPoint，获取失败为CGSizeZero
 */
- (CGSize)shy_sizeForKey:(id)key;

/*!
 @method shy_sizeForKey:defaultValue:
 @abstract 获取指定key的CGSize类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回CGSize，获取失败为指定的defaultValue
 */
- (CGSize)shy_sizeForKey:(id)key defaultValue:(CGSize)defaultValue;

/*!
 @method shy_rectForKey:
 @abstract 获取指定key的CGRect类型值
 @param key 键
 @result 返回CGPoint，获取失败为CGRectZero
 */
- (CGRect)shy_rectForKey:(id)key;

/*!
 @method shy_rectForKey:defaultValue:
 @abstract 获取指定key的CGRect类型值
 @param key 键
 @param defaultValue 获取失败要返回的值
 @result 返回CGRect，获取失败为指定的defaultValue
 */
- (CGRect)shy_rectForKey:(id)key defaultValue:(CGRect)defaultValue;

@end

@interface NSMutableDictionary (SHYUtil)

/*!
 @method shy_setObjectCheck:forKey:
 @abstract 检查设置指定key和anObject是不是为nil;不是则设置

 */
- (void)shy_setObjectCheck:(id)anObject forKey:(id <NSCopying>)aKey;

/*!
 @method shy_removeObjectForKeyCheck:
 @abstract 检查移除的key是不是为nil;不是则移除
 @param aKey 键
 */
- (void)shy_removeObjectForKeyCheck:(id)aKey;

/*!
 @method shy_setChar:forKey:
 @abstract 设置指定key的char类型值
 @param value 值
 @param key 键
 */
- (void)shy_setChar:(char)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setUnsignedChar:forKey:
 @abstract 设置指定key的unsigned char类型值
 @param value 值
 @param key 键
 */
- (void)shy_setUnsignedChar:(unsigned char)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setShort:forKey:
 @abstract 设置指定key的short类型值
 @param value 值
 @param key 键
 */
- (void)shy_setShort:(short)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setUnsignedShort:forKey:
 @abstract 设置指定key的unsigned short类型值
 @param value 值
 @param key 键
 */
- (void)shy_setUnsignedShort:(unsigned short)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setInt:forKey:
 @abstract 设置指定key的int类型值
 @param value 值
 @param key 键
 */
- (void)shy_setInt:(int)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setUnsignedInt:forKey:
 @abstract 设置指定key的unsigned int类型值
 @param value 值
 @param key 键
 */
- (void)shy_setUnsignedInt:(unsigned int)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setLong:forKey:
 @abstract 设置指定key的long类型值
 @param value 值
 @param key 键
 */
- (void)shy_setLong:(long)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setUnsignedLong:forKey:
 @abstract 设置指定key的unsigned long类型值
 @param value 值
 @param key 键
 */
- (void)shy_setUnsignedLong:(unsigned long)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setLongLong:forKey:
 @abstract 设置指定key的long long类型值
 @param value 值
 @param key 键
 */
- (void)shy_setLongLong:(long long)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setUnsignedLongLong:forKey:
 @abstract 设置指定key的unsigned long long类型值
 @param value 值
 @param key 键
 */
- (void)shy_setUnsignedLongLong:(unsigned long long)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setFloat:forKey:
 @abstract 设置指定key的float类型值
 @param value 值
 @param key 键
 */
- (void)shy_setFloat:(float)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setDouble:forKey:
 @abstract 设置指定key的double类型值
 @param value 值
 @param key 键
 */
- (void)shy_setDouble:(double)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setBool:forKey:
 @abstract 设置指定key的BOOL类型值
 @param value 值
 @param key 键
 */
- (void)shy_setBool:(BOOL)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setInteger:forKey:
 @abstract 设置指定key的NSInteger类型值
 @param value 值
 @param key 键
 */
- (void)shy_setInteger:(NSInteger)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setUnsignedInteger:forKey:
 @abstract 设置指定key的NSUInteger类型值
 @param value 值
 @param key 键
 */
- (void)shy_setUnsignedInteger:(NSUInteger)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setPointValue:forKey:
 @abstract 设置指定key的CGPoint类型值
 @param value 值
 @param key 键
 */
- (void)shy_setPointValue:(CGPoint)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setSizeValue:forKey:
 @abstract 设置指定key的CGSize类型值
 @param value 值
 @param key 键
 */
- (void)shy_setSizeValue:(CGSize)value forKey:(id<NSCopying>)key;

/*!
 @method shy_setRectValue:forKey:
 @abstract 设置指定key的CGRect类型值
 @param value 值
 @param key 键
 */
- (void)shy_setRectValue:(CGRect)value forKey:(id<NSCopying>)key;

@end
