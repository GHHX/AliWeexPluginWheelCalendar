//
//  MVPCalendarDataSourceTools.m
//  MoviePro
//
//  Created by 风海 on 17/3/9.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPCalendarDataSourceTools.h"
#import "MVPCalendarConfigModel.h"
#import "NSArray+SHYUtil.h"

@implementation MVPCalendarDataSourceTools

+ (MVPCalendarConfigModel *)assembleDataSourceWithHeader:(NSArray *)headersJson dateJson:(NSDictionary *)dateJson{
    
    MVPCalendarConfigModel *model = [[MVPCalendarConfigModel alloc] init];
    model.selectType = [[dateJson objectForKey:@"type"] longValue];
    NSDictionary *startDic = [dateJson objectForKey:@"start"];
    NSDictionary *endDic = [dateJson objectForKey:@"end"];
    
    MVPCalendarResultModel *selModel = [[MVPCalendarResultModel alloc] init];
    MVPCalendarModel *startModel  = [[MVPCalendarModel alloc] init];
    startModel.year = [[startDic objectForKey:@"year"] longValue];
    startModel.week = [[startDic objectForKey:@"week"] longValue];
    startModel.month = [[startDic objectForKey:@"month"] longValue];
    startModel.day = [[startDic objectForKey:@"day"] longValue];
    startModel.periodYear = [[startDic objectForKey:@"periodYear"] longValue];
    startModel.weekYear = [[startDic objectForKey:@"weekYear"] longValue];
    selModel.startModel = startModel;
    MVPCalendarModel *endModel  = [[MVPCalendarModel alloc] init];
    endModel.year = [[endDic objectForKey:@"year"] longValue];
    endModel.week = [[endDic objectForKey:@"week"] longValue];
    endModel.month = [[endDic objectForKey:@"month"] longValue];
    endModel.day = [[endDic objectForKey:@"day"] longValue];
    endModel.periodYear = [[endDic objectForKey:@"periodYear"] longValue];
    endModel.weekYear = [[endDic objectForKey:@"weekYear"] longValue];
    selModel.endModel = endModel;
    selModel.type = [[dateJson objectForKey:@"type"] longValue];
    model.selModel = selModel;
    
    NSMutableArray *configArray = [NSMutableArray array];
    for (NSDictionary *configDic in headersJson) {
        if ([[configDic objectForKey:@"type"] longValue] == CalendarTypeDay) {
            CalendarConfigModel *dayConfig = [[CalendarConfigModel alloc] init];
            dayConfig.type = CalendarTypeDay;
            dayConfig.title = [configDic objectForKey:@"name"]?[configDic objectForKey:@"name"]:@"日票房";
            dayConfig.isMult = [[configDic objectForKey:@"mode"] intValue];
            dayConfig.maxUnit = [[configDic objectForKey:@"maxUnit"] intValue];
            
            [configArray addObject:dayConfig];
            
        }else if ([[configDic objectForKey:@"type"] longValue] == CalendarTypeWeek){
            CalendarConfigModel *weekConfig = [[CalendarConfigModel alloc] init];
            weekConfig.type = CalendarTypeWeek;
            weekConfig.title = [configDic objectForKey:@"name"]?[configDic objectForKey:@"name"]:@"周票房";
            weekConfig.isMult = [[configDic objectForKey:@"mode"] intValue];
            weekConfig.maxUnit = [[configDic objectForKey:@"maxUnit"] intValue];
            
            [configArray addObject:weekConfig];
        }else if ([[configDic objectForKey:@"type"] longValue] == CalendarTypeMonth){
            CalendarConfigModel *monthConfig = [[CalendarConfigModel alloc] init];
            monthConfig.type = CalendarTypeMonth;
            monthConfig.title = [configDic objectForKey:@"name"]?[configDic objectForKey:@"name"]:@"月票房";
            monthConfig.isMult = [[configDic objectForKey:@"mode"] intValue];
            monthConfig.maxUnit = [[configDic objectForKey:@"maxUnit"] intValue];
            
            [configArray addObject:monthConfig];
        }else if ([[configDic objectForKey:@"type"] longValue] == CalendarTypeYear){
            CalendarConfigModel *yearConfig = [[CalendarConfigModel alloc] init];
            yearConfig.type = CalendarTypeYear;
            yearConfig.title = [configDic objectForKey:@"name"]?[configDic objectForKey:@"name"]:@"年票房";
            yearConfig.isMult = [[configDic objectForKey:@"mode"] intValue];
            yearConfig.maxUnit = [[configDic objectForKey:@"maxUnit"] intValue];
            
            [configArray addObject:yearConfig];
        }else if ([[configDic objectForKey:@"type"] longValue] == CalendarTypeCustom){
            
            CalendarConfigModel *customConfig = [[CalendarConfigModel alloc] init];
            customConfig.type = CalendarTypeCustom;
            customConfig.title = [configDic objectForKey:@"name"]?[configDic objectForKey:@"name"]:@"自定义";
            customConfig.isMult = [[configDic objectForKey:@"mode"] intValue];
            customConfig.maxUnit = [[configDic objectForKey:@"maxUnit"] intValue];
            
            [configArray addObject:customConfig];
        }
    }
    
    model.configArray = configArray;
    return model;
}

@end
