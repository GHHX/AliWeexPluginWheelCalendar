//
//  MVPCalendarTransformFestival.h
//  FSCalendar
//
//  Created by 风海 on 17/2/25.
//  Copyright © 2017年 wenchaoios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MVPCalendarTransformFestival : NSObject
+ (NSString *)transformFestivalWithDate:(NSDate *)date;
+ (BOOL)isPreSaleDate:(NSDate *)date preNum:(long)preNum;
@end
