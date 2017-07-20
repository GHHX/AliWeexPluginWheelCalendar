//
//  MVTableViewCell.h
//  MVCommonUI
//
//  Created by 念纪 on 14/10/31.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//
#ifndef _MVBASETABLEVIEWCELL_H_
#define _MVBASETABLEVIEWCELL_H_

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MVBaseTableViewCell : UITableViewCell

/**
 *  添加cell顶部左右顶边分割线
 */
- (void)addTopFullLine;
/**
 *  添加cell底部左右顶边分割线
 */
- (void)addBottomFullLine;
/**
 *  添加cell顶部右顶边分割线，左16偏移
 */
- (void)addBottomShortLine;

@end

NS_ASSUME_NONNULL_END
#endif
