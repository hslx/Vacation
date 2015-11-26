//
//  HZFChildViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/23.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFChildViewController.h"
#import "HZFOthersModel.h"
#import "HZFOthersCell.h"
#import "HZFNoSourceCell.h"
#import "HZFShowMsgViewController.h"
@interface HZFChildViewController ()<UITableViewDataSource,UITableViewDelegate>
{
      BOOL _isRefresh;
      int _offset;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)MBProgressHUD *hud;
@end

@implementation HZFChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      _offset = 0;
      [self hideExtraLine];
      [self addRefresh];
      [self registerNib];
      UIImageView *imageView =[[UIImageView alloc]initWithFrame:self.view.bounds];
      imageView.image = [UIImage imageNamed:@"aboutUsBackImage"];
      self.tableView.backgroundView = imageView;
      [self.view addSubview:self.tableView];
}
//隐藏多余的line
- (void)hideExtraLine{
      
      UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
      
      [self.tableView setTableFooterView:view];
}
//注册自定制cell
- (void)registerNib{
      UINib *nib = [UINib nibWithNibName:@"HZFChildCell" bundle:nil];
      [self.tableView registerNib:nib forCellReuseIdentifier:@"cellID"];
      
      UINib *nib1 = [UINib nibWithNibName:@"HZFNoSourceCell" bundle:nil];
      [self.tableView registerNib:nib1 forCellReuseIdentifier:@"cellID1"];
      
}
#pragma mark-------------------tableView协议方法-----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return self.dataSource.count;
      
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      
      HZFOthersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
      if([self.dataSource[indexPath.row] isKindOfClass:[HZFOthersModel class]])
      {
            cell.model = self.dataSource[indexPath.row];
            return cell;
      }else
      {
            HZFNoSourceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID1"];
            cell.lable.text = @"这个人很懒,竟然什么都没有给你留下......";
            return cell;
      }
      
      
      
      
      
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      if([self.dataSource[indexPath.row] isKindOfClass:[HZFOthersModel class]])
      {
            
            return 70;
      }else
      {
            
            
            return 44;
      }
      
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
      
      if([self.dataSource[indexPath.row] isKindOfClass:[HZFOthersModel class]])
      {
            HZFOthersModel *model = self.dataSource[indexPath.row];
            HZFShowMsgViewController *show = [HZFShowMsgViewController alloc];
            show.currentIndex = model.product_id;
            show.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:show animated:YES];
            
            
      }else
      {
            
            [self.navigationController popViewControllerAnimated:YES];
            
      }
}
#pragma mark--------------------懒加载-----------------------
-(UITableView *)tableView{
      if(!_tableView)
      {
            _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH,SHEIGHT) style:UITableViewStylePlain];
            _tableView.delegate=self;
            _tableView.dataSource=self;
      }
      return _tableView;
}
-(NSMutableArray *)dataSource{
      if(!_dataSource)
      {
            _dataSource=[[NSMutableArray alloc]init];
            [self loadData];
      }
      return _dataSource;
}
- (void)loadData {
      [self showLoadingView];
      AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
      
      NSInteger page,site_id;
 
      page = _offset;
      site_id = self.siteID;
      
      UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 160)];
      UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 160)];
     imageView.image = [UIImage imageNamed:@"child"];
     [headerView addSubview:imageView];
      self.tableView.tableHeaderView = headerView;
      [manager GET:path_child(self.catID,site_id,page) parameters:self success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self hideLoadingView];
            
            if([responseObject[@"data"] isKindOfClass:[NSArray class]])
            {
                  NSArray *arr = responseObject[@"data"];
                  for(NSDictionary *dict in arr)
                  {
                        HZFOthersModel *model = [[HZFOthersModel alloc]initWithDictionary:dict error:nil];
                        
                        [self.dataSource addObject:model];
                  }
                  
            } else {
                  
                  //                  HZFOthersModel *modle = [[HZFOthersModel alloc] init];
                  //                  modle.product_name = @"请稍等";
                  NSArray *arr = @[@"这个人很懒,什么都没有"];
                  [self.dataSource addObject:arr];
            }
            [self.tableView reloadData];
            
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
      }];
}
- (void)addRefresh {
      
      MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            _isRefresh = YES;
            
            _offset +=1;
            
            [self loadData];
            
            
            [self.tableView.footer endRefreshing];
      }];
      self.tableView.footer = footer;
}
- (void)showLoadingView{
      [self.hud show:YES];
}
- (void)hideLoadingView{
      [self.hud hide:YES];
}
- (MBProgressHUD *)hud {
      
      if(!_hud){
            _hud = [[MBProgressHUD alloc]initWithView:self.view];
            _hud.labelText = @"心急吃不了热豆腐";
            
            [self.view addSubview:_hud];
      }
      return _hud;
}


@end
