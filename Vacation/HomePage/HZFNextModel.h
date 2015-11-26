//
//  HZFNextModel.h
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "JSONModel.h"

@interface HZFNextModel : JSONModel
/**id*/
@property(nonatomic,assign) NSInteger related_id;

/**图片*/
@property(nonatomic,copy) NSString *list_img;
//
/**标题*/
@property(nonatomic,copy) NSString *name;

/**带队*/
@property(nonatomic,copy) NSString *sales_uname;

/**价格*/
@property(nonatomic,copy) NSString *price;

@end
