//
//  MVTableView.h
//  MVCommonUI
//
//  Created by 念纪 on 14/11/24.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//
#ifndef _MVTABLEVIEW_H_
#define _MVTABLEVIEW_H_

#import <UIKit/UIKit.h>

@interface MVTableView : UITableView

/**
 *  Add an empty table view footer view so that no more seperator line after the content is over
 */
- (void)addEmptyTableViewFooterView;
- (void)addEmptyTableViewHeaderView;

@end

#endif
