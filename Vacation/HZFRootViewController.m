//
//  HZFRootViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFRootViewController.h"

@interface HZFRootViewController ()

@end

@implementation HZFRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)showAlertWithMessage:(NSString *)message
{
      UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
      [alert show];
}

@end
