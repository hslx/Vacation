//
//  HZFMainModel.h
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "JSONModel.h"

@interface HZFMainModel : JSONModel
@property(nonatomic,assign) NSInteger item_id;
@property(nonatomic,copy) NSString *advert_img;
@property(nonatomic,copy) NSString *title;
@end
