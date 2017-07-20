//
//  MVPScopeModel.h
//  MoviePro
//
//  Created by 风海 on 17/3/10.
//  Copyright © 2017年 moviepro. All rights reserved.
//
#import <Foundation/Foundation.h>
@class MVPScopeDataModel;
@class MVPScopeItemModel;

@protocol MVPScopeItemModel

@end
@interface MVPScopeItemModel : NSObject

@property (assign, nonatomic) long releaseCount;
@property (copy, nonatomic) NSString *releaseDate;

@end

@interface MVPScopeDataModel : NSObject

@end

@interface MVPScopeModel : NSObject

@property (strong, nonatomic) NSMutableArray<MVPScopeItemModel> *dataList;

@end
