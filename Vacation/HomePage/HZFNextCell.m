//
//  HZFNextCell.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFNextCell.h"
#import "HZFNextModel.h"
#import "UIImageView+WebCache.h"
@implementation HZFNextCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(HZFNextModel *)model
{
      _model = model;
      
      
      self.lable1.text = model.name;
      
      self.lable2.text = model.sales_uname;
      
      [self.icon sd_setImageWithURL:[NSURL URLWithString:model.list_img]];
}


@end
