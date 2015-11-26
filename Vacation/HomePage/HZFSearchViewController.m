//
//  HZFSearchViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFSearchViewController.h"
#import "HZFSearchCell.h"
#import "HZFMainViewController.h"
@interface HZFSearchViewController ()<UITableViewDataSource,UITableViewDelegate>
{
      NSInteger site_id;
}
@property(nonatomic,strong)UISearchDisplayController *display;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)NSMutableArray *searchResults;

@end

@implementation HZFSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      [self.view addSubview:self.tableView];
      
      UISearchBar *search = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, 0, 60)];
      self.display = [[UISearchDisplayController alloc]initWithSearchBar:search contentsController:self];
      self.display.searchResultsDataSource=self;
      self.display.searchResultsDelegate=self;
      self.tableView.tableHeaderView=search;
      
}

#pragma mark-------------------tableView协议方法-----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      if(tableView==self.tableView)
      {
            return self.dataSource.count;
      }else
      {
            [self.searchResults removeAllObjects];
            
            
            for(int i=0;i<self.dataSource.count;i++)
            {
                  
                  NSDictionary *dict = self.dataSource[i];
                  NSString *name = dict[@"key_word"];
                  NSRange range=[name rangeOfString:self.searchDisplayController.searchBar.text ];
                  if(range.location!=NSNotFound)
                  {
                        [self.searchResults addObject:name];
                  }
                  
            }
            return self.searchResults.count;
            
      }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      static NSString *reuseID=@"reuse id";
      HZFSearchCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
      if(!cell)
      {
            cell=[[HZFSearchCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
      }
      
      if (tableView==self.tableView)
      {
            NSDictionary * dict =self.dataSource[indexPath.row];
            cell.lable.text = dict[@"key_word"];
            
            return cell;
      }else
      {
            cell.lable.text = self.searchResults[indexPath.row];
            self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            return cell;
      }
      
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
      
}
#pragma mark--------------------懒加载-----------------------
-(UITableView *)tableView{
      if(!_tableView)
      {
            _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
      site_id =self.siteID;
      [manager GET:path_search(site_id) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSArray *arr = responseObject[@"data"];
            for(NSDictionary *dic in arr)
            {
                  
                  [self.dataSource addObject:dic];
            }
            [self.tableView reloadData];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
      }];
}
- (NSMutableArray *)searchResults{
      if(!_searchResults)
      {
            _searchResults=[[NSMutableArray alloc]init];
      }
      return _searchResults;
}
@end
