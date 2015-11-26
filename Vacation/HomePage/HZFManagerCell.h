//
//  HZFManagerCell.h
//  HappyWeekend
//
//  Created by qianfeng on 15/11/12.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HZFLastModel;
@interface HZFManagerCell : UITableViewCell
@property(nonatomic,strong) HZFLastModel *model;
/**商务经理*/
@property (weak, nonatomic) IBOutlet UILabel *cat_name;

@property (weak, nonatomic) IBOutlet UILabel *display_rank;



@property (weak, nonatomic) IBOutlet UIImageView *service_avatar;

@property (weak, nonatomic) IBOutlet UILabel *product_name;








@end
