//
//  HZFRollCell.h
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HZFRollModel;

@interface HZFRollCell : UITableViewCell

@property(nonatomic,strong) HZFRollModel *model;

@property (nonatomic, assign) CGFloat maxY;

@property (nonatomic, strong) UIImageView *icon;

@property (nonatomic, strong) UIImageView *avatar;

@property (nonatomic, strong) UILabel *labelName;

@property (nonatomic, strong) UILabel *labelMessage;

@end
