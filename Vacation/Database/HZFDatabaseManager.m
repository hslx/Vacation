//
//  HZFDatabaseManager.m
//  HappyWeekend
//
//  Created by qianfeng on 15/11/11.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFDatabaseManager.h"
#import "HZFLastModel.h"
@implementation HZFDatabaseManager

+ (instancetype)sharedManager {
      
      static HZFDatabaseManager *_manager = nil;
      
      static dispatch_once_t onceToken;
      
      dispatch_once(&onceToken, ^{
            
            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            
            path  = [path stringByAppendingString:@"/data.db"];
            
            _manager = [[HZFDatabaseManager alloc]initWithPath:path];
            
            [_manager open];
            
            //建表
            NSString *sql = @"create table if not exists HZFApp(ID integer primary key, name varchar(128), icon varchar(64),price varchar(4))";
            [_manager executeUpdate:sql];
      });
      return _manager;
}

- (BOOL)addRecord:(HZFLastModel *)model {
      
      NSString *sql = @"insert into HZFApp (ID, name ,icon, price) values(?,?,?,?)";
      
      return [self executeUpdate:sql,model.product_id,model.product_name,model.product_img_1,model.sale_price];
}
- (BOOL)deleteRecord:(NSString *)ID
{
      NSString *sql =@"delete from HZFApp where ID = ?";
      return [self executeUpdate:sql,ID];
}
- (NSArray *)showAll {
      
      NSString *sql = @"select * from HZFApp";
      
      FMResultSet *results = [self executeQuery:sql];
      
      NSMutableArray *temp = [[NSMutableArray alloc]init];
      while (results.next) {
            HZFLastModel *model = [[HZFLastModel alloc]init];
            model.product_id = [results objectForColumnName:@"ID"];
            model.product_name = [results objectForColumnName:@"name"];
            model.product_img_1 = [results objectForColumnName:@"icon"];
            model.sale_price = [results objectForColumnName:@"price"];
            
            //将模型添加到数组
            [temp addObject:model];
            
      }
      return  temp;
}
@end
