//
//  MVPCalendarDataSourceTools.h
//  MoviePro
//
//  Created by 风海 on 17/3/9.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MVPCalendarConfigModel;
@interface MVPCalendarDataSourceTools : NSObject

+ (MVPCalendarConfigModel *)assembleDataSourceWithHeader:(NSArray *)headersJson dateJson:(NSDictionary *)dateJson;

@end
