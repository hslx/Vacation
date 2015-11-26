//
//  HZFChildCell.m
//  Vacation
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFChildCell.h"
#import "HZFOthersModel.h"
#import "UIImageView+WebCache.h"
@implementation HZFChildCell

- (void)setModel:(HZFOthersModel *)model {
      
      _model = model;
      
      [self.icon sd_setImageWithURL:[NSURL URLWithString:model.product_image]];
      
      self.lable1.text = model.product_name;
      
      
      NSString *sales =[NSString stringWithFormat:@"月销售%@笔",model.real_sales_count];
      self.lable2.text = sales;
      
}
@end
