//
//  HZFDatabaseManager.h
//  HappyWeekend
//
//  Created by qianfeng on 15/11/11.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "FMDatabase.h"
@class HZFLastModel;

@interface HZFDatabaseManager : FMDatabase

+ (instancetype)sharedManager;

/** 增 */
- (BOOL)addRecord:(HZFLastModel *)model;

/** 删 */
- (BOOL)deleteRecord:(NSString *)ID;

/** 查 */
- (NSArray *)showAll;
@end
