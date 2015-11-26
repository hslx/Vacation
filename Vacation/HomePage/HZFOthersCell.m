//
//  HZFOthersCell.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFOthersCell.h"
#import "HZFOthersModel.h"
#import "UIImageView+WebCache.h"
#import "HZFMacro.h"
@implementation HZFOthersCell
- (void)setModel:(HZFOthersModel *)model {
      
      _model = model;
      
      [self.icon sd_setImageWithURL:[NSURL URLWithString:model.product_image]];
      
      self.lable1.text = model.product_name;
      
      self.lable2.text = model.bt_keywords;
      NSString *sales =[NSString stringWithFormat:@"月销售%@笔",model.virtual_sales_count];
      self.lable3.text = sales;
      

}

@end
