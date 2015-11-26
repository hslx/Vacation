//
//  HZFCostCell.m
//  HappyWeekend
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFCostCell.h"
#import "HZFLastModel.h"
#import "HZFMacro.h"
@implementation HZFCostCell
{
      HZFLastModel *_model;
}
- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(HZFLastModel *)model
{
    
      _model = model;
      
      for(int i=0;i<model.cost_inclusive.count;i++)
      {
            self.lable1.text = model.cost_inclusive[i];
      }
      for(int i=0;i<model.cost_exclusive.count;i++)
      {
            self.lable2.text = model.cost_exclusive[i];
      }
}
- (UIScrollView *)view1 {
      
      if(!_view1)
      {
            _view1 = [[UIScrollView alloc]initWithFrame:CGRectMake(85, 30, SWIDTH-20, 130)];
            [self.contentView addSubview:_view1];
      }
      return _view1;
}
- (UIScrollView *)view2 {
      
      if(!_view2)
      {
            _view2 = [[UIScrollView alloc]initWithFrame:CGRectMake(85, 190, SWIDTH-20, 75)];
            [self.contentView addSubview:_view2];
      }
      return _view2;
}
- (UILabel *)lable1
{
      if(!_lable1)
      {
            for(int i=0;i<_model.cost_inclusive.count;i++)
            {
                  _lable1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 25*i, SWIDTH-100, 35)];
                  _lable1.numberOfLines = 0;
                  _lable1.text = _model.cost_inclusive[i];
                  _lable1.font = [UIFont systemFontOfSize:14] ;
                  self.view1.contentSize = CGSizeMake(self.view1.frame.size.width, 25*_model.cost_inclusive.count+40);
                  [self.view1 addSubview:_lable1];
            }
      }
      return _lable1;
}
- (UILabel *)lable2
{
      if(!_lable2)
      {
            for(int i=0;i<_model.cost_exclusive.count;i++)
            {
                  _lable2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 25*i, SWIDTH-100, 20)];
                  _lable2.text = _model.cost_exclusive[i];
                  _lable2.font = [UIFont systemFontOfSize:14] ;
                  self.view2.contentSize = CGSizeMake(self.view2.frame.size.width, 25*_model.cost_exclusive.count+40);
                  [self.view2 addSubview:_lable2];
            }
      }
      return _lable2;
}
@end
