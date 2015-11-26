//
//  HZFBrightCell.h
//  HappyWeekend
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZFLastModel;
@interface HZFBrightCell : UITableViewCell
@property(nonatomic,strong) UILabel *lableTitle;
@property(nonatomic,strong) UILabel *lable;
@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) HZFLastModel *model;
@end
