//
//  WeexPluginCalendarModule.m
//  WeexPluginTemp
//
//  Created by  on 17/3/14.
//  Copyright © 2017年 . All rights reserved.
//

#import "WeexPluginCalendarModule.h"
#import <WeexPluginLoader/WeexPluginLoader.h>
#import "MVPCalendarConfigModel.h"
#import "MVPCalendarDataSourceTools.h"
#import "MVPCalenarConfigModel.h"
#import "MVPCalendarRootViewController.h"

@implementation WeexPluginCalendarModule
@synthesize weexInstance;
WX_PlUGIN_EXPORT_MODULE(weexPluginCalendar, WeexPluginCalendarModule)
WX_EXPORT_METHOD(@selector(startCalendar:callbackOk:callbackCancel:))


- (void)startCalendar:(NSMutableDictionary *)date callbackOk:(WXModuleCallback)callbackOk callbackCancel:(WXModuleCallback)callbackCancel {
    if (![date isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSArray *headersJson = [date objectForKey:@"headers"];
    NSDictionary *dateJson = [date objectForKey:@"currentModel"];
    MVPCalendarConfigModel *model = [MVPCalendarDataSourceTools assembleDataSourceWithHeader:headersJson dateJson:dateJson];
    NSDictionary *bizConfigDic = [date objectForKey:@"config"];
    if (bizConfigDic) {
        MVPCalenarConfigModel *bizConfigModel = [[MVPCalenarConfigModel alloc] initWithDictionary:bizConfigDic];
        model.bizConfigModel = bizConfigModel;
    }
    
    MVPCalendarRootViewController *cVC = [[MVPCalendarRootViewController alloc] init];
    [cVC setConfigDataSource:model];
    cVC.rBlock = ^(MVPCalendarResultModel *model){
        NSMutableDictionary *resultDic = [NSMutableDictionary dictionary];
        [resultDic setObject:@(model.type) forKey:@"type"];
        [resultDic setObject:model.typeName?model.typeName:@"" forKey:@"dateAlias"];
        [resultDic setObject:@{@"year":@(model.startModel.year),@"month":@(model.startModel.month),@"week":@(model.startModel.week),@"day":@(model.startModel.day),@"weekYear":@(model.startModel.weekYear),@"periodYear":@(model.startModel.periodYear)} forKey:@"start"];
        [resultDic setObject:@{@"year":@(model.endModel.year),@"month":@(model.endModel.month),@"week":@(model.endModel.week),@"day":@(model.endModel.day),@"weekYear":@(model.endModel.weekYear),@"periodYear":@(model.endModel.periodYear)} forKey:@"end"];
        callbackOk(resultDic);
    };
    [weexInstance.viewController presentViewController:cVC animated:YES completion:^{
        
    }];
}

@end
