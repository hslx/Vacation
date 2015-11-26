//
//  HZFChildCell.h
//  Vacation
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZFOthersModel;
@interface HZFChildCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UILabel *lable2;
@property(nonatomic,strong) HZFOthersModel *model;
@end
