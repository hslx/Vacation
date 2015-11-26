//
//  HZFPromatCell.h
//  HappyWeekend
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZFLastModel;
@interface HZFPromatCell : UITableViewCell
@property (nonatomic,strong) UIScrollView *view;

@property(nonatomic,strong) HZFLastModel *model;
@property(nonatomic,strong) UILabel *lable;
@end
