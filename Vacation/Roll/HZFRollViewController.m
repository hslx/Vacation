//
//  HZFRollViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFRollViewController.h"
#import "HZFWriteViewController.h"
#import "HZFRollCell.h"
#import "HZFRollModel.h"
@interface HZFRollViewController ()<UITableViewDataSource,UITableViewDelegate>
{
      BOOL _isRefresh;
      NSInteger _offset;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HZFRollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      [self createNav];
      [self addRefresh];
      UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
      imageView.image = [UIImage imageNamed:@"big_bg"];
      self.tableView.backgroundView = imageView;
      [self.view addSubview:self.tableView];
}
- (void)createNav {
      
      UIBarButtonItem *rightItem=[[UIBarButtonItem alloc]initWithTitle:@"记事本" style:UIBarButtonItemStyleDone target:self action:@selector(leftItemAction)];
      
      self.navigationItem.rightBarButtonItem=rightItem;
      
}
- (void)leftItemAction {
      
      HZFWriteViewController *write = [[HZFWriteViewController alloc]init];
      write.hidesBottomBarWhenPushed = YES;
      [self.navigationController pushViewController:write animated:YES];
      
}
#pragma mark-------------------tableView协议方法-----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      static NSString *reuseID=@"reuse id";
      HZFRollCell * cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
      if(!cell)
      {
            cell=[[HZFRollCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
      }
      self.tableView.backgroundColor = [UIColor clearColor];
      
      cell.model = self.dataSource[indexPath.row];
      return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
     HZFRollCell *cell = [ tableView dequeueReusableCellWithIdentifier:@"reuse id"];
      if(!cell)
      {
            cell = [[HZFRollCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuse id"];
      }
      //cell.model = nil;
      
      cell.model = self.dataSource[indexPath.row];
    
      return cell.maxY + 20;
}
#pragma mark--------------------懒加载-----------------------
-(UITableView *)tableView
{
      if(!_tableView)
      {
            _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
            _tableView.delegate=self;
            _tableView.dataSource=self;
      }
      return _tableView;
}
-(NSMutableArray *)dataSource
{
      if(!_dataSource)
      {
            _dataSource=[[NSMutableArray alloc]init];
            
            [self loadData];
      }
      return _dataSource;
}
- (void)loadData {
      
      AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
      NSInteger page = _isRefresh? 0 : _offset+5;
      [manager GET:path_televise(page) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if(_isRefresh)
            {
                  [self.dataSource removeAllObjects];
            }
            NSArray *arr = responseObject[@"data"];
            
            for(NSDictionary *dic in arr)
            {
                  HZFRollModel *model = [[HZFRollModel alloc]initWithDictionary:dic error:nil];
                  [self.dataSource addObject:model];
            }
            [self.tableView reloadData];
            
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
      }];
}
#pragma mark-----------------刷新加载--------------------------

- (void)addRefresh {
      
      //下拉刷新
      
      MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            _isRefresh = YES;
            
            [self loadData];
            
            _offset = 0;
            
            [self.tableView.header endRefreshing];
            
      }];
      
      header.automaticallyChangeAlpha = YES;
      
      header.lastUpdatedTimeLabel.hidden = NO;
      
      self.tableView.header = header;
      
      //下拉加载
      
      MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            _isRefresh = NO;
            
            _offset += 5;
            
            [self loadData];
            [self.tableView.footer endRefreshing];
      }];
      
      self.tableView.footer = footer;
      
}


@end
