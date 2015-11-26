//
//  HZFAskCell.m
//  HappyWeekend
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFAskCell.h"
#import "HZFLastModel.h"
@implementation HZFAskCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(HZFLastModel *)model
{
      
      _model = model;
      
      self.lable.text = model.service_mobile;
      
}


@end
