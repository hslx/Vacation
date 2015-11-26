//
//  HZFMyViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFMyViewController.h"
#import "HZFMacro.h"
#import "HZFLoveViewController.h"
#import "HZFApplyViewController.h"
#import "HZFLoginViewController.h"
#import "HZFNullViewController.h"
@interface HZFMyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation HZFMyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      [self hidenExtraLine];
      [self createView];
      [self.view addSubview:self.tableView];
      
}

#pragma mark------------------------隐藏多余的线--------------------
- (void)hidenExtraLine {
      UIView *extraView = [[UIView alloc]initWithFrame:CGRectZero];
      self.tableView.tableFooterView = extraView;
}
//创建头视图
- (void)createView {
      CGFloat y;
      if(SWIDTH==375)
      {
        y = 200;
      }
      else{
            
        y =170;
      }
      UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SWIDTH , y)];
      imageView.image = [UIImage imageNamed:@"look_user"];
      
      self.tableView.tableHeaderView = imageView;
      
}
#pragma mark-------------------tableView协议方法-----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      static NSString *reuseID=@"reuse id";
      UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
      if(!cell)
      {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
      }
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      
      NSArray *arrTitles = @[@"我喜欢的",@"我的订单",@"我的出游人",@"我的优惠劵",@"我的咨询",@"推荐应用",@"更多"];
      
      cell.textLabel.text = arrTitles[indexPath.row];
      
      NSMutableArray *images = [[NSMutableArray alloc]init];
      
      for(int i=0;i<7;i++)
      {
            [images addObject:[NSString stringWithFormat:@"hzf%02d",i]];
      }
      cell.imageView.image = [UIImage imageNamed:images[indexPath.row]];
      return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      
      if(SWIDTH==375)
      {
            return 44;
      }
      else{
            
            return 38;
      }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
      
      if(indexPath.row==5)
      {
            HZFApplyViewController *apply = [HZFApplyViewController alloc];
            apply.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:apply animated:YES];
            
      }else if (indexPath.row==0)
      {
            HZFLoveViewController *love = [[HZFLoveViewController alloc]init];
            love.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:love animated:YES];
      }else {
            HZFNullViewController *nu = [[HZFNullViewController alloc]init];
            nu.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:nu animated:YES];
      }
}
#pragma mark--------------------懒加载-----------------------
-(UITableView *)tableView
{
      if(!_tableView)
      {
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT) style:UITableViewStylePlain];
            _tableView.delegate=self;
            _tableView.dataSource=self;
      }
      return _tableView;
}



@end
