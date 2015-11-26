//
//  HZFAllCountryViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFAllCountryViewController.h"
#import "HZFMainViewController.h"
#import "HZFAllCountryModel.h"
@interface HZFAllCountryViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation HZFAllCountryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      self.title = @"站点选择";
      [self.view addSubview:self.tableView];
}

#pragma mark-------------------tableView协议方法-----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      static NSString *reuseID=@"reuse id";
      UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
      if(!cell)
      {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
      }
      HZFAllCountryModel *model = self.dataSource[indexPath.row];
      
      cell.textLabel.text = model.site_name;
      return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      // HZFMainViewController *mv = [[HZFMainViewController alloc]init];
      
      HZFAllCountryModel *model = self.dataSource[indexPath.row];
      
      NSInteger currentIndex = model.site_id;
      NSString *siteName = model.site_name;
      if([self respondsToSelector:@selector(pushMsg:SiteName:)])
      {
            [self pushMsg:currentIndex SiteName:siteName];
      }
      
      [self.navigationController popViewControllerAnimated:YES];
      
}
#pragma mark------------------------代理---------------------------
- (void)pushMsg:(NSInteger)currentIndex SiteName:(NSString *)site_name{
      [self.delegate showMsg:currentIndex SiteName:site_name];
}

#pragma mark--------------------懒加载-----------------------
-(UITableView *)tableView{
      if(!_tableView)
      {
            _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
      
      AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
      [manager GET:PATH_ALLCOUNTRY parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *arr = responseObject[@"data"];
            for(NSDictionary *dic in arr)
            {
                  HZFAllCountryModel *model = [[HZFAllCountryModel alloc]initWithDictionary:dic error:nil];
                  [self.dataSource addObject:model];
            }
            [self.tableView reloadData];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
      }];
}

@end
