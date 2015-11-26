//
//  HZFRollCell.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFRollCell.h"
#import "HZFMacro.h"
#import "UIImageView+WebCache.h"
#import "HZFRollModel.h"
#define baseTag 666
@implementation HZFRollCell

- (void)setModel:(HZFRollModel *)model
{
      _model = model;
      
      
      [self.icon sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
      
      self.labelName.text = model.nickname;
      
      self.labelMessage.text = model.content;
      
      CGSize size = [model.content sizeWithFont:self.labelMessage.font constrainedToSize:CGSizeMake(CGRectGetWidth(self.labelMessage.frame), FLT_MAX) lineBreakMode:NSLineBreakByCharWrapping];
      
      CGRect fm = self.labelMessage.frame;
      
      fm.size = size;
      
      self.labelMessage.frame = fm;
      
      self.maxY = CGRectGetMaxY(fm);
      
      // 添加图片之前, 先将原来的图片移除
      for (UIView *subView in self.contentView.subviews) {
            if (subView.tag >= baseTag) {
                  [subView removeFromSuperview];
            }
      }
      
      // 添加图片
      if (model.images_all.count == 1) {
            float x = CGRectGetMaxX(self.icon.frame);
            float y = CGRectGetMaxY(self.labelMessage.frame);
            
            for (int i = 0; i < model.images_all.count; i++) {
                  NSDictionary *dic = model.images_all[i];
                  UIImageView *imageView = [[UIImageView alloc] init];
                  
                  [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"big_img"]]];
                  
                  imageView.tag = baseTag;
                  
                  imageView.frame = CGRectMake(x + 45, y + 5 , 210, 210);
                  
                  [self.contentView addSubview:imageView];
                  
                  self.maxY = CGRectGetMaxY(imageView.frame);
            }
      }
      else if (model.images_all.count ==2) {
            
            float x = CGRectGetMaxX(self.icon.frame);
            float y = CGRectGetMaxY(self.labelMessage.frame);
            
            for (int i = 0; i < model.images_all.count; i++) {
                  NSDictionary *dic = model.images_all[i];
                  UIImageView *imageView = [[UIImageView alloc] init];
                  
                  [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"small_img"]]];
                  
                  imageView.tag = baseTag;
                  
                  imageView.frame = CGRectMake(x + 25 + 108 * (i % 2), y + 5 + 105 * (i / 2), 105, 85);
                  
                  [self.contentView addSubview:imageView];
                  
                  self.maxY = CGRectGetMaxY(imageView.frame);
            }
            
      } else if (model.images_all.count ==4) {
            
            //float x = CGRectGetMaxX(self.icon.frame);
            float y = CGRectGetMaxY(self.labelMessage.frame);
            
            for (int i = 0; i < model.images_all.count; i++) {
                  NSDictionary *dic = model.images_all[i];
                  UIImageView *imageView = [[UIImageView alloc] init];
                  
                  [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"small_img"]]];
                  
                  imageView.tag = baseTag;
                  
                  imageView.frame = CGRectMake((SWIDTH-161)/2 + 81 * (i % 2), y + 5 + 81 * (i / 2), 80, 80);
                  
                  [self.contentView addSubview:imageView];
                  
                  self.maxY = CGRectGetMaxY(imageView.frame);
            }
      }else if (model.images_all.count > 2 && model.images_all.count!=4) {
            
            float x = CGRectGetMaxX(self.icon.frame);
            float y = CGRectGetMaxY(self.labelMessage.frame);
            
            for (int i = 0; i < model.images_all.count; i++) {
                  NSDictionary *dic = model.images_all[i];
                  UIImageView *imageView = [[UIImageView alloc] init];
                  
                  [imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"small_img"]]];
                  
                  imageView.tag = baseTag;
                  
                  imageView.frame = CGRectMake(x + 15 + 71 * (i % 3), y + 5 + 71 * (i / 3), 70, 70);
                  
                  [self.contentView addSubview:imageView];
                  
                  self.maxY = CGRectGetMaxY(imageView.frame);
            }
      }else if (model.images_all.count==0)
      {
            //float x = CGRectGetMaxX(self.icon.frame);
            float y = CGRectGetMaxY(self.labelMessage.frame);
            self.maxY = 200;
      }
      
}

- (UIImageView *)icon {
      if (!_icon) {
            _icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 15, 43, 43)];
            [self.contentView addSubview:_icon];
      }
      
      return _icon;
}

- (UILabel *)labelName {
      if (!_labelName) {
            float x = CGRectGetMaxX(self.icon.frame);
            _labelName = [[UILabel alloc] initWithFrame:CGRectMake(x + 15, 15, SWIDTH - x - 30, 15)];
            _labelName.font = [UIFont boldSystemFontOfSize:15];
            
            
            [self.contentView addSubview:_labelName];
      }
      
      return _labelName;
}

- (UILabel *)labelMessage {
      if (!_labelMessage) {
            float x = CGRectGetMaxX(self.icon.frame);
            float y = CGRectGetMaxY(self.labelName.frame);
            _labelMessage = [[UILabel alloc] initWithFrame:CGRectMake(x + 15, y + 5, SWIDTH - x - 30, 30)];
            _labelMessage.font = [UIFont systemFontOfSize:13];
            
            _labelMessage.numberOfLines = 0;
            
            [self.contentView addSubview:_labelMessage];
      }
      
      return _labelMessage;
}


@end
