//
//  HZFOthersModel.h
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "JSONModel.h"

@interface HZFOthersModel : JSONModel
/**id*/
@property(nonatomic,assign) NSInteger product_id;
/**信息简介*/
@property(nonatomic,copy) NSString *product_name;

/**图片*/
@property(nonatomic,copy) NSString *product_image;

/**适合群体*/
@property(nonatomic,copy) NSString *bt_keywords;

/**价格*/
@property(nonatomic,copy) NSString *sale_price;

/**月销售*/
@property(nonatomic,copy) NSString *virtual_sales_count;

/**儿童了乐园*/
@property(nonatomic,copy) NSString *real_sales_count;
@end
