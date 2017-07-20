//
//  MVTableViewDelegateProxy.h
//  MVCommonUI
//
//  Created by 念纪 on 14/11/24.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//
#ifndef _MVTABLEVIEWDELEGATEPROXY_H_
#define _MVTABLEVIEWDELEGATEPROXY_H_

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  Catch delegate method for `MVTableViewDataSource`
 */
@interface MVTableViewDelegateProxy : NSProxy <UITableViewDelegate>

@property(nonatomic, weak, nullable) id target;

@end

#endif
