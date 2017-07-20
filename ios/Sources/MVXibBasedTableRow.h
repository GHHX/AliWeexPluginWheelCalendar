//
//  MVXibBasedTableRow.h
//  MVCommonUI
//
//  Created by Erick Xi on 15/9/10.
//  Copyright © 2015年 Alipay. All rights reserved.
//
#ifndef _MVXIBBASEDTABLEROW_H_
#define _MVXIBBASEDTABLEROW_H_
#import "MVTableRow.h"

@interface MVXibBasedTableRowCell : UITableViewCell

@end

@interface MVXibBasedTableRow : MVTableRow

/**
 *  Override point, default implementation is return [self reuseIdentifier] directly
 *
 *  @return The xib name for table row to load
 */
- (NSString *)xibName;

@end

#endif
