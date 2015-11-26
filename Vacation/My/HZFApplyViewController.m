//
//  HZFApplyViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFApplyViewController.h"
#import "HZFApplyCell.h"
@interface HZFApplyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HZFApplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      [self.view addSubview: self.tableView];
      [self registerNib];
      self.title = @"推荐应用";
}
//注册自定制cell
- (void)registerNib{
      UINib *nib = [UINib nibWithNibName:@"HZFApplyCell" bundle:nil];
      [self.tableView registerNib:nib forCellReuseIdentifier:@"cellID"];
      
}
#pragma mark-------------------tableView协议方法-----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
      
      
      HZFApplyCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellID"];
     
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
      
      NSDictionary * dict =self.dataSource[indexPath.row];
      
      [cell.icon sd_setImageWithURL:[NSURL URLWithString:dict[@"pic"]]];
      
      cell.lableTitle.text = dict[@"name"];
      
      cell.lableIntro.text = dict[@"intro"];
      
      
      return cell;
      
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
      
      return 70;
      
      
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
      NSString *path = @"http://app.zmqnw.com.cn/friendsapp/list";
      
      [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

@end
