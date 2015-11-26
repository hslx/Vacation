//
//  HZFManagerCell.m
//  HappyWeekend
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFManagerCell.h"
#import "HZFLastModel.h"
#import "UIImageView+WebCache.h"

@implementation HZFManagerCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(HZFLastModel *)model
{
      self.product_name.text = model.product_name;
      
      NSString *string = [NSString stringWithFormat:@"本条路线有%@人玩过",model.display_rank];
      self.display_rank.text = string;

      
      [self.service_avatar sd_setImageWithURL:[NSURL URLWithString:model.service_avatar]];
      self.service_avatar.layer.cornerRadius = 30;
      self.service_avatar.layer.masksToBounds = YES;
      
  
      self.cat_name.text = model.cat_name;
      
}

@end
