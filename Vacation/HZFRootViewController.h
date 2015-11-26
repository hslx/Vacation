//
//  HZFRootViewController.h
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HZFMacro.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "MJRefresh.h"
#import "MBProgressHUD.h"

#define showAlert(message) [self showAlertWithMessage:message];
#define filePath [NSString stringWithFormat:@"%@/Documents/vacation.arc", NSHomeDirectory()]
@interface HZFRootViewController : UIViewController

-(void)showAlertWithMessage:(NSString *)message;

@end
