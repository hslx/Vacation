//
//  HZFCostCell.h
//  HappyWeekend
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZFLastModel;
@interface HZFCostCell : UITableViewCell
@property(nonatomic,strong) HZFLastModel *model;
/**费用包含*/
@property(nonatomic,strong) UIScrollView *view1;
/**费用不含*/
@property(nonatomic,strong) UIScrollView *view2;
@property(nonatomic,strong) UILabel *lable1;
@property(nonatomic,strong) UILabel *lable2;
@end
