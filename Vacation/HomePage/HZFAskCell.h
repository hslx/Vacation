//
//  HZFAskCell.h
//  HappyWeekend
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZFLastModel;
@interface HZFAskCell : UITableViewCell
@property(nonatomic,strong) HZFLastModel *model;
@property (weak, nonatomic) IBOutlet UILabel *lable;
@end
