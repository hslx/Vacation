//
//  HZFLastModel.h
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "JSONModel.h"

@interface HZFLastModel : JSONModel
/**滚动视图*/
@property(nonatomic,copy) NSString * product_id;
@property(nonatomic,copy) NSString *product_img_1;
@property(nonatomic,copy) NSString *product_img_2;
@property(nonatomic,copy) NSString *product_img_3;


/**商务经理*/
@property(nonatomic,copy) NSString *product_name;
@property(nonatomic,copy) NSString *sale_price;
@property(nonatomic,copy) NSString *display_rank;
@property(nonatomic,copy) NSString *cat_name;
@property(nonatomic,copy) NSString *service_avatar;

/**地图*/
//@property(nonatomic,copy) NSString *sight_pos;

/**亮点*/
@property(nonatomic,copy) NSString *sales_promotion_intro;

/**费用说明*/
@property(nonatomic,copy) NSArray *cost_inclusive;
@property(nonatomic,copy) NSArray *cost_exclusive;
/**详细介绍*/
@property(nonatomic,copy) NSArray *prompt;

/**客服*/
@property(nonatomic,copy) NSString *service_mobile;


/**经纬度*/
@property(nonatomic,assign) double east_longitude;
@property(nonatomic,assign) double north_latitude;
@end
