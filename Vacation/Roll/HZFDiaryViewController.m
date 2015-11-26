//
//  HZFDiaryViewController.m
//  read
//
//  Created by qianfeng on 15/11/25.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFDiaryViewController.h"
#import "HZFWriteModel.h"
@interface HZFDiaryViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
      NSInteger _currentindex;
}
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@end

@implementation HZFDiaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      
      
      self.title = @"日记";
      [self initData];
      
      [self createTableView];
      //设置背景图片
      UIImageView *imageView = [[UIImageView alloc]init];
      
      imageView.image = [UIImage imageNamed:@"home_back"];
      
      self.tableView.backgroundView = imageView;
      
      [self createHideView];
}
//隐藏多余的线
- (void)createHideView {
      
      UIView *hideView = [[UIView alloc]initWithFrame:CGRectZero];
      [self.tableView setTableFooterView:hideView];
}
- (void)initData {
      // 读取本地的数据, 放到tableView的数据源数组中
      self.dataSource = [[NSMutableArray alloc] initWithArray:[HZFDiaryManager friends]];
}

- (void)createTableView {
      
      self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
      
      self.tableView.delegate = self;
      
      self.tableView.dataSource = self;
      [self.view addSubview:self.tableView];
      
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
      return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
      static NSString *reuseID = @"cell";
      UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
      if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseID];
      }
      
      // 数据源数组中存放的是联系人对象, 所以取出来对象
      HZFWriteModel *diary= self.dataSource[indexPath.row];
      
      // 分别将diary的日记赋给标题和副标题
      cell.textLabel.text = diary.diary;
      cell.textLabel.numberOfLines = 0;
      return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
      return 60;
}
//某一行能否被编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
      return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
     
      return UITableViewCellEditingStyleDelete;
      
}


//只有实现了这个方法才可以出现滑动删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
      _currentindex = indexPath.row;
      UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"确定要删除吗?" delegate:self cancelButtonTitle:@"不是" otherButtonTitles:@"是的", nil];
      [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
      
      if (buttonIndex == 1) {
            HZFWriteModel *diary= self.dataSource[_currentindex];
            
            if([HZFDiaryManager deleteFriendWithFriendName:diary.diary])
            {
                  [self confirmDelete:diary];
            }
            
      }
      
}
#pragma mark ---------------- 添加联系人页回调 ----------------
- (void)addFinishWithNewInfo:(HZFWriteModel *)newFriend {
      // 1. 修改tableView数据源数组
      [self.dataSource addObject:newFriend];
      // 2. 刷新表格
      [self.tableView reloadData];
}

- (void)confirmDelete:(HZFWriteModel *)data {
      // 1. 删除tableView数据源数组
      [self.dataSource removeObject:data];
      // 2. 刷新表格
      [self.tableView reloadData];
}

- (void)modifyComplete:(HZFWriteModel *)fiend {
      // 直接刷新即可, 因为我们已经将friend这个指针传给了修改的界面, 而修改界面根据这个指针修改了对应空间的内容, 所以我们这里不需要再做操作, 因为数组里面的内容已经改变了, 直接刷新表格即可
      [self.tableView reloadData];
}

@end
