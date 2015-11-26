//
//  HZFAllCountryViewController.h
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFRootViewController.h"
@protocol HZFMainViewControllerDelgate <NSObject>

- (void)showMsg:(NSInteger)currentIndex SiteName:(NSString *)site_name;

@end
@interface HZFAllCountryViewController : HZFRootViewController

#pragma mark-------------------代理-------------------------------
@property(nonatomic,weak) id<HZFMainViewControllerDelgate>delegate;

- (void)pushMsg:(NSInteger)currentIndex SiteName:(NSString *)site_name;

@end
