//
//  HZFWriteModel.m
//  read
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFWriteModel.h"
#import "HZFRootViewController.h"

@interface  HZFWriteModel()<NSCoding>

@end
@implementation HZFWriteModel
- (id)initWithCoder:(NSCoder *)aDecoder {
      if (self = [super init]) {
            self.diary = [aDecoder decodeObjectForKey:@"name"];
            
      }
      return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
      [aCoder encodeObject:self.diary forKey:@"name"];
      
}

@end

@implementation HZFDiaryManager

// 添加一个联系人
+ (BOOL)addFriend:(HZFWriteModel *)diary {
      // 1. 先去读取本地的所有联系人
      NSMutableArray *allFriends = [[NSMutableArray alloc] initWithArray:[self friends]];
      // 2. 添加到数组中
      [allFriends addObject:diary];
      // 3. 将添加过后的数组存到本地
      return [NSKeyedArchiver archiveRootObject:allFriends toFile:filePath];
}

// 根据名字删除联系人(有可能会删除多个)
+ (BOOL)deleteFriendWithFriendName:(NSString *)name {
      // 1. 先去读取本地的所有联系人
      NSMutableArray *allFriends = [[NSMutableArray alloc] initWithArray:[self friends]] ;
      // 2. 创建一个对象, 用来接收要删除的联系人
      HZFWriteModel *deletedFriend = nil ;
      // 3. 循环遍历, 找到名称能匹配的上的联系人, 存到上面的临时的对象中(因为在for in 里面不能对数组进行修改)
      for (HZFWriteModel *diary in allFriends) {
            if ([diary.diary isEqualToString:name]) {
                  deletedFriend = diary;
                  break;
            }
      }
      // 4. 如果找到了名称匹配的联系人, 就从数组中删除
      if (deletedFriend) {
            [allFriends removeObject:deletedFriend];
      }
      
      // 5. 将删除后的数组存到本地
      return [NSKeyedArchiver archiveRootObject:allFriends toFile:filePath];
}

+ (BOOL)modifyFrieldWithFriendName:(NSString *)name withNewName:(NSString *)newName{
      // 1. 先去读取本地所有的联系人
      NSMutableArray *allFriends = [[NSMutableArray alloc] initWithArray:[self friends]];
      // 2. 循环遍历所有联系人, 找到名称能匹配的上的
      for (HZFWriteModel*diary in allFriends) {
            if ([diary.diary isEqualToString:name]) {
                  diary.diary = newName;
            }
      }
      // 3. 将修改后的数组存到本地
      return [NSKeyedArchiver archiveRootObject:allFriends toFile:filePath];
}

// 返回所有的联系人
+ (NSArray *)friends {
      return [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}

@end
