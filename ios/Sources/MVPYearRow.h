//
//  MVPYearRow.h
//  MoviePro
//
//  Created by 风海 on 17/2/21.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVTableRow.h"

@interface MVPYearRow : MVTableRow

@property (assign, nonatomic) BOOL isSelect;
@property (strong, nonatomic) NSMutableDictionary *extDic;
@property (assign, nonatomic) long tagNum;
@property (assign, nonatomic) BOOL isYear;
- (void)setYearContent:(NSString *)year;

@end
