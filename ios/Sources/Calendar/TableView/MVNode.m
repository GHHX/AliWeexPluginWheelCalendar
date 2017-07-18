//
//  MVNode.m
//  MVCommonUI
//
//  Created by 念纪 on 14/12/26.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import "MVNode.h"

@interface MVNode () {
    NSMutableArray* _children;
    NSArray* _unmutableChildren;
    __weak MVNode* _parent;
}

@end

@implementation MVNode

@dynamic children;
@synthesize parent = _parent;

- (void)setChildren:(NSArray*)children
{

    if ([children isKindOfClass:[NSArray class]]) {

        _children = [[NSMutableArray alloc] initWithCapacity:[children count]];
        _unmutableChildren = [_children copy];
        for (MVNode* node in children) {
            [self addChild:node];
        }
    }
    else {
        _children = nil;
        _unmutableChildren = nil;
    }
}

- (NSArray*)children
{

    return _unmutableChildren;
}

- (void)addChild:(MVNode*)node
{

    if ([node isKindOfClass:[MVNode class]]) {

        node.parent = self;

        @synchronized(self)
        {
            if (!_children) {
                _children = [[NSMutableArray alloc] init];
            }
            [_children addObject:node];
            _unmutableChildren = [_children copy];
        }
    }
}

- (void)addChildFromArray:(NSArray*)array
{

    if ([array count]) {

        for (MVNode* node in array) {
            [self addChild:node];
        }
    }
}

- (void)insertChild:(MVNode*)node atIndex:(NSUInteger)index
{

    if ([node isKindOfClass:[MVNode class]]) {

        node.parent = self;

        @synchronized(self)
        {
            if (!_children) {
                _children = [[NSMutableArray alloc] init];
            }
            [_children insertObject:node atIndex:index];
            _unmutableChildren = [_children copy];
        }
    }
}

- (void)removeChild:(MVNode*)node
{

    if ([node isKindOfClass:[MVNode class]]) {

        @synchronized(self)
        {
            if ([_children containsObject:node]) {
                [_children removeObject:node];
                _unmutableChildren = [_children copy];
            }
        }
    }
}

- (void)removeFromParent
{

    [self.parent removeChild:self];
}

- (void)removeAllChild
{

    @synchronized(self)
    {

        _children = nil;
        _unmutableChildren = nil;
    }
}

- (void)setParent:(MVNode*)parent
{

    if (_parent != parent) {
        _parent = parent;
    }
}

- (MVNode*)parent
{

    if (![_parent.children containsObject:self]) {
        _parent = nil;
    }
    return _parent;
}

- (NSUInteger)nodeIndex
{
    if (self.parent) {
        return [self.parent.children indexOfObject:self];
    }

    return NSNotFound;
}

- (MVNode*)firstChild
{
    return [self.children firstObject];
}

- (MVNode*)lastChild
{
    return [self.children lastObject];
}

- (MVNode *)nextSibling
{
    NSArray *children = self.parent.children;
    NSUInteger myIndex = [children indexOfObject:self];
    if (children.count > myIndex + 1) {
        return children[myIndex + 1];
    }
    return nil;
}

- (MVNode *)previousSibling
{
    NSArray *children = self.parent.children;
    NSInteger myIndex = [children indexOfObject:self];
    if (myIndex - 1 >= 0) {
        return children[myIndex - 1];
    }
    return nil;
}


- (NSArray*)siblings
{
    if (self.parent == nil || self.nodeIndex == NSNotFound) {
        return nil;
    }
    NSMutableArray* array = [[self.parent children] mutableCopy];
    [array removeObject:self];
    return [array copy];
}

- (BOOL)isFirstChild
{
    return [self.parent firstChild] == self;
}

- (BOOL)isLastChild
{
    return [self.parent lastChild] == self;
}

- (NSUInteger)count
{
    return [self.children count];
}

- (MVNode*)objectAtIndexedSubscript:(NSUInteger)idx
{
    return self.children[idx];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState*)state objects:(__unsafe_unretained id[])stackbuf count:(NSUInteger)len
{
    return [self.children countByEnumeratingWithState:state objects:stackbuf count:len];
}

@end
