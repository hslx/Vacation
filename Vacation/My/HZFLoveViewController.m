//
//  HZFLoveViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFLoveViewController.h"
#import "HZFLoveCell.h"
#import "HZFLastModel.h"
#import "HZFDatabaseManager.h"
@interface HZFLoveViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
      NSString *_product_id;
      NSInteger _currentIndex;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;


@end

@implementation HZFLoveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      [self registerNib];
      [self.view addSubview:self.tableView];
      [self hideExtraLine];
}
//隐藏多余的line
- (void)hideExtraLine
{
      
      UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
      
      [self.tableView setTableFooterView:view];
}
//注册自定制cell
- (void)registerNib{
      UINib *nib = [UINib nibWithNibName:@"HZFLoveCell" bundle:nil];
      [self.tableView registerNib:nib forCellReuseIdentifier:@"cellID"];
      
}
#pragma mark-------------------tableView协议方法-----------
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
      return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
     
      
      HZFLoveCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
           self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
      
      HZFLastModel *model = self.dataSource[indexPath.row];
      
      [cell.icon sd_setImageWithURL:[NSURL URLWithString:model.product_img_1]];
      
      cell.lableIntro.text = model.product_name;
      
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteAction:)];
      _product_id = model.product_id;
      
      [cell.love addGestureRecognizer:tap];
      
      cell.love.userInteractionEnabled = YES;
      
      return cell;
      
      
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
      
      HZFLastModel *model = self.dataSource[indexPath.row];
      _product_id = model.product_id;
      
      _currentIndex = indexPath.row;
}

- (void)deleteAction:(NSString *)ID {
      UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"你真的不爱我了吗?" delegate:self cancelButtonTitle:@"是的" otherButtonTitles:@"不是", nil];
      [alert show];
      
}
#pragma mark----------------alertView协议方法---------------------------
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
      NSLog(@"%ld",buttonIndex);
      switch (buttonIndex) {
            case 0:{
                  [[HZFDatabaseManager sharedManager]deleteRecord:_product_id];
                  
                  [self.dataSource removeObjectAtIndex:_currentIndex];
                  
                  [self.tableView reloadData];
                  break;
            }
                  case 1:
            {
                  break;
            }
            default:
                  break;
      }
     
      
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
      
      return 180;
      
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
            
            for(HZFLastModel *model in [[HZFDatabaseManager sharedManager] showAll])
            {
                  [_dataSource addObject:model];
            }
            [self.tableView reloadData];
      }
      return _dataSource;
}

@end
