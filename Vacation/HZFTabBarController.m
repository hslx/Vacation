//
//  HZFTabBarController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFTabBarController.h"
#import "HZFMainViewController.h"
#import "HZFRollViewController.h"
#import "HZFMyViewController.h"
#import "HZFLoginViewController.h"
#import "HZFMacro.h"
#import "HZFViewController.h"
@interface HZFTabBarController ()
{
      //声明四个子视图控制器的成员变量
      HZFMainViewController *_mainController;
      UINavigationController *_mainNavController;
      
      HZFRollViewController *_rollController;
      UINavigationController *_rollNavController;
      
      
//      HZFMyViewController *_myController;
//      UINavigationController *_myNavController;
      
      
           
      //记录上一个被点击的按钮
      UINavigationController *_preNav;
      UIImageView *_preImgV;
      
    
      UIImageView *_imageView;
 
}
@end

@implementation HZFTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      _imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
      _imageView.image = [UIImage imageNamed:@"aboutUsBackImage"];
      [self.view addSubview:_imageView];
      [self createNav];
}

- (void)animation
{
      [UIView animateWithDuration:1 animations:^{
            _imageView.alpha = 0;
            
      } completion:^(BOOL finished) {

      }];
      
}


-(void)createNav
{
      _mainController=[[HZFMainViewController alloc]init];
      
      _rollController=[[HZFRollViewController alloc]init];
      
    
      
      _mainNavController=[[UINavigationController alloc]initWithRootViewController:_mainController];
      
      _rollNavController=[[UINavigationController alloc]initWithRootViewController:_rollController];
      
      
      
      
      UITabBarItem *mainItem=[[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"tabbar_home"] selectedImage:[UIImage imageNamed:@"tabbar_home_selected_os7"]];
      _mainNavController.tabBarItem=mainItem;
      
      
      UITabBarItem *rollItem=[[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"tabbar_discover"] selectedImage:[UIImage imageNamed:@"tabbar_discover_selected"]];
      _rollNavController.tabBarItem=rollItem;
      
      
    
      [self.tabBar setBackgroundColor:[UIColor whiteColor]];
      
      BOOL ret = [[[NSUserDefaults standardUserDefaults]valueForKey:@"login"]boolValue];
      if(!ret)
      {
           
            HZFLoginViewController *myController = [[HZFLoginViewController alloc]init];
            UINavigationController *myNavController=[[UINavigationController alloc]initWithRootViewController:myController];
            self.viewControllers=@[_mainNavController,_rollNavController,myNavController];
            UITabBarItem *myItem=[[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_profile_os7"] selectedImage:[UIImage imageNamed:@"tabbar_profile_selected_os7"]];
            myNavController.tabBarItem=myItem;
            
            //向标签控制器中，添加对应的子视图控制器
            self.viewControllers=@[_mainNavController,_rollNavController,myNavController];
      }else
      {
            HZFMyViewController *myController = [[HZFMyViewController alloc]init];
            myController.title = @"我";
            UINavigationController *myNavController=[[UINavigationController alloc]initWithRootViewController:myController];
            self.viewControllers=@[_mainNavController,_rollNavController,myNavController];
            UITabBarItem *myItem=[[UITabBarItem alloc]initWithTitle:@"我" image:[UIImage imageNamed:@"tabbar_profile_os7"] selectedImage:[UIImage imageNamed:@"tabbar_profile_selected_os7"]];
            myNavController.tabBarItem=myItem;
            
            //向标签控制器中，添加对应的子视图控制器
            self.viewControllers=@[_mainNavController,_rollNavController,myNavController];
      }
}


//添加tabbar上的按钮
-(void)viewDidAppear:(BOOL)animated
{
      [self performSelector:@selector(animation) withObject:nil afterDelay:1];
      [super viewDidAppear:animated];
     
     
}



@end
