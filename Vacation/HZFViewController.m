//
//  HZFViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFViewController.h"
#import "HZFTabBarController.h"
#import "AppDelegate.h"
#import "HZFMacro.h"
@interface HZFViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation HZFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      [self createScrollView];
}

-(void)createScrollView {
      NSArray *arr = @[@"guide_one",@"guide_two",@"guide_three",@"guide_four"];
      self.scrollView=[[UIScrollView alloc]initWithFrame:self.view.bounds];
      self.scrollView.contentSize=CGSizeMake(SWIDTH*4, SHEIGHT);
      for(int i=0;i<4;i++)
      {
            UIImageView * imageView=[[UIImageView alloc]initWithFrame:CGRectMake(SWIDTH*i, 0, SWIDTH, SHEIGHT)];
            imageView.image=[UIImage imageNamed:arr[i]];
            if(i==3)
            {
                  UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
                  
                  [imageView addGestureRecognizer:tap];
                  
                  imageView.userInteractionEnabled=YES;
            }
            
            [self.scrollView addSubview:imageView];
            [self.view addSubview:self.scrollView];
             self.scrollView.bounces = NO;
            self.scrollView.showsHorizontalScrollIndicator=NO;
      }
      
}

-(void)tapAction {
      NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
      [defaults setValue:@"YES" forKey:@"key"];
      [defaults synchronize];
      AppDelegate * appd=[UIApplication sharedApplication].delegate;
      HZFTabBarController *tab=[[HZFTabBarController alloc]init];
      appd.window.rootViewController=tab;
}

@end
