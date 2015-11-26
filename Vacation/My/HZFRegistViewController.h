//
//  HZFRegistViewController.h
//  Vacation
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFRootViewController.h"

@interface HZFRegistViewController : HZFRootViewController

@property(nonatomic,copy)void(^showMsg)(NSString * ,NSString *);
-(void)transMsgName:(NSString *)name Pwd:(NSString *)pwd;

@end
