//
//  HZFMapCell.m
//  HappyWeekend
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFMapCell.h"
#import "HZFMacro.h"
@implementation HZFMapCell

- (void)awakeFromNib {
    // Initialization code]
      
}

- (UIImageView *)MapView {
  
      if(!_MapView)
      {
            _MapView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, SWIDTH-20, 190)];
            _MapView.image = [UIImage imageNamed:@"map"];
            [self.contentView addSubview:_MapView];
      }
      return _MapView;
}
@end
