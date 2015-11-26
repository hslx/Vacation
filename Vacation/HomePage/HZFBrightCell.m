//
//  HZFBrightCell.m
//  HappyWeekend
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFBrightCell.h"
#import "HZFLastModel.h"
#import "HZFMacro.h"
@implementation HZFBrightCell

- (void)awakeFromNib {
    // Initialization code
  
}

- (void)setModel:(HZFLastModel *)model
{
      _model = model;
      self.lable.text = model.sales_promotion_intro;
}

- (UILabel *)lableTitle {
      
      if(!_lableTitle)
      {
            _lableTitle = [[UILabel alloc]initWithFrame:CGRectMake((SWIDTH-40)/2, 10, 40, 30)];
            _lableTitle.textAlignment = NSTextAlignmentCenter;
            _lableTitle.textColor = [UIColor redColor];
            [self.contentView addSubview:_lableTitle];
      }
      return _lableTitle;
}

- (UILabel *)lable {
      
      if(!_lable)
      {
            CGFloat y = CGRectGetMaxY(self.lableTitle.frame);
            _lable = [[UILabel alloc]initWithFrame:CGRectMake(20, y, SWIDTH-40, 80)];
            _lable.numberOfLines = 0;
            _lable.textAlignment = NSTextAlignmentCenter;
            _lable.font = [UIFont systemFontOfSize:15];
            [self.contentView addSubview:_lable];
      }
      return _lable;
}

- (UIImageView *)icon {
      
      if(!_icon)
      {
            CGFloat y = CGRectGetMaxY(self.lable.frame);
            _icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, y, SWIDTH-20, 80)];
            [self.contentView addSubview:_icon];
      }
      return _icon;
      
}
@end
