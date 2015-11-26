//
//  HZFPromatCell.m
//  HappyWeekend
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFPromatCell.h"
#import "HZFLastModel.h"
#import "HZFMacro.h"
@implementation HZFPromatCell
{
      HZFLastModel *_model;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(HZFLastModel *)model
{
      
      _model = model;
      
      for(int i=0;i<model.prompt.count;i++)
      {
            self.lable.text = model.prompt[i];
      }
     
}
- (UIScrollView *)view {
      CGFloat y;
            
      
      if(!_view)
      {
            _view = [[UIScrollView alloc]initWithFrame:CGRectMake(10, 10, SWIDTH-20, 180)];
            _view.showsVerticalScrollIndicator = NO;
            [self.contentView addSubview:_view];
      }
      return _view;
}
- (UILabel *)lable
{
      if(!_lable)
      {
            for(int i=0;i<_model.prompt.count;i++)
            {
                  _lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 35*i, self.view.frame.size.width, 35)];
                  _lable.text = _model.prompt[i];
                  _lable.numberOfLines = 0;
                  _lable.font = [UIFont systemFontOfSize:14];
                  self.view.contentSize = CGSizeMake(self.view.frame.size.width, 35*_model.prompt.count+40);
                  [self.view addSubview:_lable];
            }
      }
      return _lable;
}

@end
