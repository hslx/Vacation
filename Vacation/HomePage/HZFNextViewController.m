//
//  HZFNextViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFNextViewController.h"
#import "HZFShowMsgViewController.h"
#import "HZFNextModel.h"
#import "HZFNextCell.h"
@interface HZFNextViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)UIView *tbHeaderView;

@end

@implementation HZFNextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      [self.view addSubview:self.tableView];
      
      self.title = self.title;
      [self registerNib];
      [self addRefresh];
}
//注册自定制cell
- (void)registerNib{
      UINib *nib = [UINib nibWithNibName:@"HZFNextCell" bundle:nil];
      [self.tableView registerNib:nib forCellReuseIdentifier:@"cellID"];
      
}
#pragma mark------------------------协议方法----------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      
      return self.dataArray.count;
      
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
      static NSString * reuseID = @"cellID";
      
      HZFNextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
      
     
      cell.model = self.dataArray[indexPath.row];
      
      return cell;
      
      
      
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      return 80;
      
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
      
      HZFShowMsgViewController * showMsg = [[HZFShowMsgViewController alloc]init];
      HZFNextModel *model = self.dataArray[indexPath.row];
      showMsg.hidesBottomBarWhenPushed = YES;
      showMsg.currentIndex =model.related_id;
      [self.navigationController pushViewController:showMsg animated:YES];
      
      
}
#pragma mark------------------------懒加载--------------------------------------

- (UITableView *)tableView {
      if(!_tableView)
      {
            _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
            _tableView.delegate = self;
            _tableView.dataSource =self;
      }
      return _tableView;
}

- (NSMutableArray *)dataArray {
      if(!_dataArray)
      {
            _dataArray = [[NSMutableArray alloc]init];
            [self loadData];
      }
      return _dataArray;
}
- (void)loadData {
      
      AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
      
      NSInteger item_id = self.currentIndex;
      
      [manager GET:path_show(item_id) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary * dic = responseObject[@"data"];
            
            NSArray * arr = [dic objectForKey:@"topic_items"];
            
            for(NSDictionary *dict in arr)
            {
                  NSError *error = nil;
                  
                  HZFNextModel *model = [[HZFNextModel alloc]initWithDictionary:dict error:&error];
                  
                  
                  
                  [self.dataArray addObject:model];
            }
            UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 200)];
            
            [imageview sd_setImageWithURL:[NSURL URLWithString:dic[@"advert_pic"]]];
            
            self.tableView.tableHeaderView = imageview;
            
            [self.tableView reloadData];
            
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
      }];
}

- (void)addRefresh {
      MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self.tableView.footer endRefreshing];
      }];
      self.tableView.footer = footer;
}
@end
