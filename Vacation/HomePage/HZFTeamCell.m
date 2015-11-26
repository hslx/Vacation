//
//  HZFTeamCell.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFTeamCell.h"
#import "HZFMacro.h"
@implementation HZFTeamCell

- (UILabel *)lableTitle
{
      if(!_lableTitle)
      {
            _lableTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 44)];
            [self.contentView addSubview:_lableTitle];
      }
      return _lableTitle;
}
- (UILabel *)lableSmall
{
      if(!_lableSmall)
      {
            _lableSmall = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 50, 44)];
            [self.contentView addSubview:_lableSmall];
      }
      return _lableSmall;
}
- (UITextField *)textField
{
      if(!_textField)
      {
            CGFloat x =CGRectGetMaxX(self.lableTitle.frame);
            _textField = [[UITextField alloc]initWithFrame:CGRectMake(x+5, 0, 200, 44)];
            [self.contentView addSubview:_textField];
      }
      return _textField;
}
- (UITextField *)tf
{
      if(!_tf)
      {
            _tf = [[UITextField alloc]initWithFrame:CGRectMake(10, 0,SWIDTH-20 , 100)];
            [self.contentView addSubview:_tf];
      }
      return _tf;
}

@end
