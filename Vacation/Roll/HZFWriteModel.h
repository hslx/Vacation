//
//  HZFWriteModel.h
//  read
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HZFWriteModel : NSObject

@property (nonatomic, copy) NSString *diary;


@end

#pragma mark ----------------  联系人管理类  ----------------

@interface HZFDiaryManager : NSObject

// 添加一个联系人
+ (BOOL)addFriend:(HZFWriteModel *)diary;

// 删除一个联系人
+ (BOOL)deleteFriendWithFriendName:(NSString *)name;

// 修改一个联系人
+ (BOOL)modifyFrieldWithFriendName:(NSString *)name withNewName:(NSString *)newName;
// 所有的联系人
+ (NSArray *)friends;
@end