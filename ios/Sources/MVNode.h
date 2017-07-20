//
//  MVNode.h
//  MVCommonUI
//
//  Created by 念纪 on 14/12/26.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//
#ifndef _MVNODE_H_
#define _MVNODE_H_

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

/**
 *  用于管理子节点和父节点的抽象类
 */
@interface MVNode : NSObject

@property (nonatomic, weak) __kindof MVNode *parent;
@property (nonatomic, strong) NSArray *children;

- (void)addChild:(MVNode *)node;
- (void)addChildFromArray:(NSArray *)array;
- (void)insertChild:(MVNode *)node atIndex:(NSUInteger)index;
- (void)removeChild:(MVNode *)node;

- (void)removeFromParent;
- (void)removeAllChild;
- (NSUInteger)nodeIndex;

- (__kindof MVNode *)firstChild;
- (__kindof MVNode *)lastChild;


- (NSArray *)siblings;

- (BOOL)isLastChild;
- (BOOL)isFirstChild;

- (__kindof MVNode *)nextSibling;
- (__kindof MVNode *)previousSibling;


- (NSUInteger)count; //aka self.children.count

//Support subscript
- (__kindof MVNode *)objectAtIndexedSubscript:(NSUInteger)idx;

//Support fast enumeration
- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state
                                  objects:(id __unsafe_unretained [])stackbuf
                                    count:(NSUInteger)len;

@end


#endif
