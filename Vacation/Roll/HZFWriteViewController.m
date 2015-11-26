//
//  HZFWriteViewController.m
//  read
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFWriteViewController.h"
#import "HZFDiaryViewController.h"
#import "HZFWriteModel.h"
@interface HZFWriteViewController ()
{
      UIView *_Writeview;
      NSString *_path;
}

@end

@implementation HZFWriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      self.title = @"记事本";
      [self createView];
      [self createNavigationItem];
      

}
- (void)createNavigationItem {
      // 右上角的加号
      self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"日记" style:UIBarButtonItemStyleDone target:self action:@selector(addAction)];
}

- (void)addAction {
      HZFDiaryViewController *next = [[HZFDiaryViewController alloc]init];
      [self.navigationController pushViewController:next animated:YES];
}
- (void)createView {

      _Writeview = [[UIView alloc]initWithFrame:CGRectMake(0, 100, SWIDTH, 200)];
      [self.view addSubview:_Writeview];
      
   
      
      UIImageView *imageView =[[ UIImageView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 250)];
      imageView.image = [UIImage imageNamed:@"背景3.png"];
      [_Writeview addSubview:imageView];
      imageView.userInteractionEnabled = YES;
      
      UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, SWIDTH-10, 20)];
      lable.text = @"在这里,你可以记录下你旅途中的点点滴滴";
      [imageView addSubview:lable];
      CGFloat y1 = CGRectGetMaxY(lable.frame);
      UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(7, y1+2, SWIDTH-14, 1)];
      imageView1.image = [UIImage imageNamed:@"popup_green"];
      [imageView addSubview:imageView1];
      CGFloat y2 = CGRectGetMaxY(imageView1.frame);
      UITextView *textView =[[ UITextView alloc]initWithFrame:CGRectMake(10, y2+5, SWIDTH-20, 130)];
      textView.tag =987;
      [imageView addSubview:textView];
      
      
      CGFloat y3 = CGRectGetMaxY(textView.frame);
      
      UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(7, y3+5, SWIDTH-14, 1)];
      imageView2.image = [UIImage imageNamed:@"popup_green"];
      [imageView addSubview:imageView2];
        CGFloat y4 = CGRectGetMaxY(imageView2.frame);
      UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((SWIDTH-100)/2, y4+15, 100, 25)];
    
      [button setTitle:@"提交" forState:UIControlStateNormal];
      button.backgroundColor = [UIColor lightGrayColor];
      
      [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
      [imageView addSubview:button];
      
}
- (void)buttonAction {
      
      UITextView *textView = (UITextView*)[self.view viewWithTag:987];
      HZFWriteModel *diary = [[HZFWriteModel alloc]init];
      diary.diary =textView.text;
      
      //缓存到本地
      [HZFDiaryManager addFriend:diary];
      textView.text = nil;
      HZFDiaryViewController *next = [[HZFDiaryViewController alloc]init];
      [self.navigationController pushViewController:next animated:YES];
     
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
      [self.view endEditing:YES];
}
@end
