//
//  HZFSearchCell.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFSearchCell.h"

@implementation HZFSearchCell

- (UILabel *)lable
{
      if(!_lable)
      {
            _lable = [[UILabel alloc]initWithFrame:self.contentView.frame];
            
            _lable.textAlignment = UITextAlignmentCenter;
            
            [self.contentView addSubview:_lable];
      }
      return _lable;
}

@end
