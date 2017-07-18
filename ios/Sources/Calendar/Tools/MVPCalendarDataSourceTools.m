//
//  MVPCalendarDataSourceTools.m
//  MoviePro
//
//  Created by 风海 on 17/3/9.
//  Copyright © 2017年 moviepro. All rights reserved.
//

#import "MVPCalendarDataSourceTools.h"
#import "MVPCalendarConfigModel.h"
#import "NSDictionary+SHYUtil.h"
#import "NSArray+SHYUtil.h"

@implementation MVPCalendarDataSourceTools

+ (MVPCalendarConfigModel *)assembleDataSourceWithHeader:(NSArray *)headersJson dateJson:(NSDictionary *)dateJson{
    
    MVPCalendarConfigModel *model = [[MVPCalendarConfigModel alloc] init];
    model.selectType = [dateJson shy_longForKey:@"type"];
    NSDictionary *startDic = [dateJson shy_dictionaryForKey:@"start"];
    NSDictionary *endDic = [dateJson shy_dictionaryForKey:@"end"];
    
    MVPCalendarResultModel *selModel = [[MVPCalendarResultModel alloc] init];
    MVPCalendarModel *startModel  = [[MVPCalendarModel alloc] init];
    startModel.year = [startDic shy_longForKey:@"year"];
    startModel.week = [startDic shy_longForKey:@"week"];
    startModel.month = [startDic shy_longForKey:@"month"];
    startModel.day = [startDic shy_longForKey:@"day"];
    startModel.periodYear = [startDic shy_longForKey:@"periodYear"];
    startModel.weekYear = [startDic shy_longForKey:@"weekYear"];
    selModel.startModel = startModel;
    MVPCalendarModel *endModel  = [[MVPCalendarModel alloc] init];
    endModel.year = [endDic shy_longForKey:@"year"];
    endModel.week = [endDic shy_longForKey:@"week"];
    endModel.month = [endDic shy_longForKey:@"month"];
    endModel.day = [endDic shy_longForKey:@"day"];
    endModel.periodYear = [endDic shy_longForKey:@"periodYear"];
    endModel.weekYear = [endDic shy_longForKey:@"weekYear"];
    selModel.endModel = endModel;
    selModel.type = [dateJson shy_longForKey:@"type"];
    model.selModel = selModel;
    
    NSMutableArray *configArray = [NSMutableArray array];
    for (NSDictionary *configDic in headersJson) {
        if ([configDic shy_longForKey:@"type"] == CalendarTypeDay) {
            CalendarConfigModel *dayConfig = [[CalendarConfigModel alloc] init];
            dayConfig.type = CalendarTypeDay;
            dayConfig.title = [configDic shy_stringForKey:@"name"]?[configDic shy_stringForKey:@"name"]:@"日票房";
            dayConfig.isMult = [configDic shy_intForKey:@"mode"];
            dayConfig.maxUnit = [configDic shy_intForKey:@"maxUnit"];
            
            [configArray addObject:dayConfig];
            
        }else if ([configDic shy_longForKey:@"type"] == CalendarTypeWeek){
            CalendarConfigModel *weekConfig = [[CalendarConfigModel alloc] init];
            weekConfig.type = CalendarTypeWeek;
            weekConfig.title = [configDic shy_stringForKey:@"name"]?[configDic shy_stringForKey:@"name"]:@"周票房";
            weekConfig.isMult = [configDic shy_intForKey:@"mode"];
            weekConfig.maxUnit = [configDic shy_intForKey:@"maxUnit"];
            
            [configArray addObject:weekConfig];
        }else if ([configDic shy_longForKey:@"type"] == CalendarTypeMonth){
            CalendarConfigModel *monthConfig = [[CalendarConfigModel alloc] init];
            monthConfig.type = CalendarTypeMonth;
            monthConfig.title = [configDic shy_stringForKey:@"name"]?[configDic shy_stringForKey:@"name"]:@"月票房";
            monthConfig.isMult = [configDic shy_intForKey:@"mode"];
            monthConfig.maxUnit = [configDic shy_intForKey:@"maxUnit"];
            
            [configArray addObject:monthConfig];
        }else if ([configDic shy_longForKey:@"type"] == CalendarTypeYear){
            CalendarConfigModel *yearConfig = [[CalendarConfigModel alloc] init];
            yearConfig.type = CalendarTypeYear;
            yearConfig.title = [configDic shy_stringForKey:@"name"]?[configDic shy_stringForKey:@"name"]:@"年票房";
            yearConfig.isMult = [configDic shy_intForKey:@"mode"];
            yearConfig.maxUnit = [configDic shy_intForKey:@"maxUnit"];
            
            [configArray addObject:yearConfig];
        }else if ([configDic shy_longForKey:@"type"] == CalendarTypeCustom){
            
            CalendarConfigModel *customConfig = [[CalendarConfigModel alloc] init];
            customConfig.type = CalendarTypeCustom;
            customConfig.title = [configDic shy_stringForKey:@"name"]?[configDic shy_stringForKey:@"name"]:@"自定义";
            customConfig.isMult = [configDic shy_intForKey:@"mode"];
            customConfig.maxUnit = [configDic shy_intForKey:@"maxUnit"];
            
            [configArray addObject:customConfig];
        }
    }
    
    model.configArray = configArray;
    return model;
}

@end
