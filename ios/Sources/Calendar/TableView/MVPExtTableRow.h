//
//  MVPTableView.h
//  MoviePro
//
//  Created by taotao on 2017/3/9.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVTableRow.h"

@protocol MVPTableViewCommonDelegate <NSObject>

- (void)tableViewNeedReload;

@end

@interface MVPExtTableRow : MVTableRow

@property (weak, nonatomic) id<MVPTableViewCommonDelegate> mvpCommentDelegate;

@end
