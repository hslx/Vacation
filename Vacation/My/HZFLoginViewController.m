//
//  HZFLoginViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFLoginViewController.h"
#import "HZFMyViewController.h"
#import "HZFViewController.h"
#import "AppDelegate.h"
#import "HZFTabBarController.h"
#import "HZFRegistViewController.h"
#define baseText 564
@interface HZFLoginViewController ()
{
      UIImageView *imageView;
}
@end

@implementation HZFLoginViewController

- (void)viewDidLoad {
      [super viewDidLoad];
      // Do any additional setup after loading the view from its nib.
      [self createBgView];
      [self createNav];
      [self createView];
      
      self.title=@"登录";
}
-(void)createNav
{
      
      UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
      self.navigationItem.rightBarButtonItem=right;
}
-(void)rightAction
{
      HZFRegistViewController *regist=[[HZFRegistViewController alloc]init];
      regist.showMsg=^(NSString *name,NSString *pwd)
      {
            UITextField *text=(UITextField *)[self.view viewWithTag:baseText];
            text.text=name;
            UITextField *text1=(UITextField *)[self.view viewWithTag:baseText+1];
            text1.text=pwd;
      };
      [self.navigationController pushViewController:regist animated:YES];
}

-(void)createBgView
{
      imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
      imageView.image = [UIImage imageNamed:@"背景图2.png"];
      //必须打开图片交互,不然之上所有东西都不会有响应
      imageView.userInteractionEnabled = YES;
      [self.view addSubview:imageView];
      
      UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, 128)];
      imageView2.image = [UIImage imageNamed:@"home_title"];

      [imageView addSubview:imageView2];
      
}

-(void)createView
{
      NSArray *arr=@[@"用户名",@"密    码"];
      for(int i=0;i<2;i++)
      {
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 240+40*i, 60, 30)];
            lable.text=arr[i];
            [imageView addSubview:lable];
            UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(75, 240+40*i, 200, 30)];
            textField.borderStyle=UITextBorderStyleRoundedRect;
            
            if(i==1)
            {
                  textField.secureTextEntry=YES;
            
                  
            }
             textField.tag=baseText+i;
            textField.clearButtonMode=UITextFieldViewModeWhileEditing;
            [imageView addSubview:textField];
            
            
      }
      
      
      UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
      [button setTitle:@"登     录" forState:UIControlStateNormal];
      button.frame=CGRectMake(110, 330, 120, 30);
      [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
      button.backgroundColor=[UIColor lightGrayColor];
      [imageView addSubview:button];
      
      UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 370, SWIDTH, 1)];
      icon.image = [UIImage imageNamed:@"popup_green"];
      [imageView addSubview:icon];
      
      
      NSArray *Images = @[@"bundle_qq",@"bundle_wechat",@"bundle_weibo"];
      
      for(int i=0;i<Images.count;i++)
      {
            CGFloat y =CGRectGetMaxY(icon.frame);
            CGFloat x =(SWIDTH-200)/3;
            UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:CGRectMake(50+(x+50)*(i%3), y+20, x, x)];
            imageIcon.layer.cornerRadius = x/2;
            imageIcon.layer.masksToBounds = YES;
            imageIcon.image = [UIImage imageNamed:Images[i]];
            [imageView addSubview:imageIcon];
      }
      
}

-(void)buttonAction
{
      UITextField *text=(UITextField *)[self.view viewWithTag:baseText];
      UITextField *text1=(UITextField *)[self.view viewWithTag:baseText+1];
      if(text.text.length==0||text1.text.length==0)
      {
            showAlert(@"用户名或者密码不存在");
            return;
      }
      AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
      
      manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
      
      NSDictionary *dic = @{
                            @"username": text.text,
                            @"password": text1.text
                            };
      NSString *path=@"http://10.0.8.8/sns/my/login.php";
      [manager POST:path parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *code = responseObject[@"code"];
            if ([code isEqualToString:@"login_success"]) {
                  //showAlert(@"登录成功");
                  
                  NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                  [defaults setValue:@"YES" forKey:@"login"];
      
                  HZFMyViewController *my=[[HZFMyViewController alloc]init];
                  
                  [self.navigationController pushViewController:my animated:YES];
                  
            }
            else {
                  NSString *message = responseObject[@"message"];
                  showAlert(message);
            }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@", error);
      }];
      
      
      
      
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
      [self.view endEditing:YES];
}




@end
