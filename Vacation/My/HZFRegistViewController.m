//
//  HZFRegistViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFRegistViewController.h"
#define baseTextField 654
@interface HZFRegistViewController ()
{
      UIImageView *imageView;
}
@end

@implementation HZFRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      
      self.title=@"注册";
      
      imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, 400)];
      imageView.image = [UIImage imageNamed:@"背景3.png"];
      //必须打开图片交互,不然之上所有东西都不会有响应
      imageView.userInteractionEnabled = YES;
      [self.view addSubview:imageView];
      [self createView];
}
-(void)createView
{
      NSArray *arr=@[@"用  户  名",@"密       码",@"确认密码",@"邮       箱"];
      NSArray *arr1=@[@"请输入用户名(英文)",@"请输入密码",@"请确认密码",@"请输入邮箱(任意邮箱)"];
      for(int i=0;i<arr.count;i++)
      {
            UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(10, 80+50*i, 80, 30)];
            
            lable.text=arr[i];
            lable.textAlignment=NSTextAlignmentRight;
            [imageView addSubview:lable];
            UITextField *textField=[[UITextField alloc]initWithFrame:CGRectMake(100,80+50*i , 180, 30)];
            textField.tag=baseTextField+i;
            textField.placeholder=arr1[i];
            if(i==1||i==2)
            {
                  textField.secureTextEntry=YES;
            }
            textField.borderStyle=UITextBorderStyleRoundedRect;
            textField.clearButtonMode=UITextFieldViewModeWhileEditing;
            [imageView addSubview:textField];
      }
      UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
      button.frame=CGRectMake((SWIDTH-80)/2, 310, 80, 30);
      [button setTitle:@"完成注册" forState:UIControlStateNormal];
      [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
      button.backgroundColor=[UIColor lightGrayColor];
      [imageView addSubview:button];
}
-(void)buttonAction
{
      UITextField *name=(UITextField *)[self.view viewWithTag:baseTextField];
      UITextField *pwd=(UITextField *)[self.view viewWithTag:baseTextField+1];
      UITextField *repeatPwd=(UITextField *)[self.view viewWithTag:baseTextField+2];
      UITextField *email=(UITextField *)[self.view viewWithTag:baseTextField+3];
      if(![pwd.text isEqualToString:repeatPwd.text])
      {
            showAlert(@"两次输入密码不一致");
            return;
      }else if (name.text.length==0||pwd.text.length==0||repeatPwd.text.length==0||email.text.length==0)
      {
            showAlert(@"请补全信息");
            return;
      }
      NSString *path=@"http://10.0.8.8/sns/my/register.php";
      //注册的事件
      AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
      
      manager.responseSerializer.acceptableContentTypes=[NSSet setWithObject:@"text/html"];
      //开始请求
      NSDictionary *dic=@{@"username": name.text,@"password":pwd.text,@"email":email.text};
      [manager POST: path parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSString *code = responseObject[@"code"];
            // 判断返回的code是否是正确的
            if ([code isEqualToString:@"registered"]) {
                  if([self respondsToSelector:@selector(transMsgName:Pwd:)])
                  {
                        [self transMsgName:name.text Pwd:pwd.text];
                  }
                  NSLog(@"注册成功");
                  [self.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                  NSString *message=responseObject[@"message"];
                  showAlert(message);
            }
            
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error.localizedDescription);
      }];
}
-(void)transMsgName:(NSString *)name Pwd:(NSString *)pwd
{
      self.showMsg(name,pwd);
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
      [self.view endEditing:YES];
}


@end
