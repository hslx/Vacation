//
//  HZFShowMsgViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFShowMsgViewController.h"
#import "HZFLastModel.h"
#import "HZFManagerCell.h"
#import "HZFMapCell.h"
#import "HZFBrightCell.h"
#import "HZFCostCell.h"
#import "HZFPromatCell.h"
#import "HZFAskCell.h"
#import "HZFDatabaseManager.h"
#import "HZFShowMapViewController.h"
@interface HZFShowMsgViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
      //记录每个section的开关状态 0为关 1为开
      int folder[6];
      UIView *_shareView;
}
@property(nonatomic,strong)UIView *tbHeaderView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,strong)UIPageControl *pageControl;

@end

@implementation HZFShowMsgViewController

- (void)viewDidLoad {
      [super viewDidLoad];
      // Do any additional setup after loading the view from its nib.
      self.title =@"产品详情";
      [self loadData];
      [self createView];
      [self registerNib];
      [self createNav];
      [self.view addSubview:self.tableView];
}
- (void)createNav {
      
     
      UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
      imageView.image = [UIImage imageNamed:@"share"];
      
      UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:imageView];
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(rightItemAction)];
      
      [imageView addGestureRecognizer:tap];
      
      imageView.userInteractionEnabled = YES;
      self.navigationItem.rightBarButtonItem=rightItem;
      
}
-(void)rightItemAction{
      _shareView = [[UIView alloc]initWithFrame:CGRectMake(0, SHEIGHT-200, SWIDTH, 200)];
      _shareView.backgroundColor = [UIColor whiteColor];
      [self.view addSubview:_shareView];
      NSArray *arr = @[@"qq",@"微信",@"新浪微博",@"腾讯微博",@"朋友圈",@"twitter"];
      NSArray *arrImg = @[@"bundle_qq",@"bundle_wechat",@"bundle_weibo",@"umeng_socialize_tx_on",@"umeng_socialize_wxcircle",@"umeng_socialize_twitter"];
 
      for(int i=0 ;i<6;i++)
      {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame =CGRectMake(10+(SWIDTH+40)/3*(i%3), 5+65*(i/3), (SWIDTH-175)/3, 40);
            [button setImage:[UIImage imageNamed:arrImg[i]] forState:UIControlStateNormal];
            button.tag = 666+i;
            [button addTarget:self action:@selector(buttonShare:) forControlEvents:UIControlEventTouchUpInside];
            [_shareView addSubview:button];
            
            CGFloat y = CGRectGetMaxY(button.frame);
            UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(SWIDTH/3*(i%3), y+1, SWIDTH/3, 18)];
            lable.text = arr[i];
            lable.textAlignment = NSTextAlignmentCenter;
            lable.font = [UIFont systemFontOfSize:14];
            [_shareView addSubview:lable];
      }
      
      
}
- (void)buttonShare:(UIButton *)button {
      

      
}
- (void)createView {
      self.tbHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 160)];
      
      self.tableView.tableHeaderView = self.tbHeaderView;
}
#pragma mark-------------------tableView协议方法-----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
      return 6;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      if (folder[section]==1)
      {
            return 0;
      }else
      {
            return 1;
      }
    
}
//注册自定制cell
- (void)registerNib{
      UINib *nib0 = [UINib nibWithNibName:@"HZFManagerCell" bundle:nil];
      [self.tableView registerNib:nib0 forCellReuseIdentifier:@"cellID0"];
      
      UINib *nib1 = [UINib nibWithNibName:@"HZFMapCell" bundle:nil];
      [self.tableView registerNib:nib1 forCellReuseIdentifier:@"cellID1"];
      
      UINib *nib2 = [UINib nibWithNibName:@"HZFBrightCell" bundle:nil];
      [self.tableView registerNib:nib2 forCellReuseIdentifier:@"cellID2"];
      
      UINib *nib3 = [UINib nibWithNibName:@"HZFCostCell" bundle:nil];
      [self.tableView registerNib:nib3 forCellReuseIdentifier:@"cellID3"];
      
      UINib *nib4 = [UINib nibWithNibName:@"HZFPromatCell" bundle:nil];
      [self.tableView registerNib:nib4 forCellReuseIdentifier:@"cellID4"];
      
      UINib *nib5 = [UINib nibWithNibName:@"HZFAskCell" bundle:nil];
      [self.tableView registerNib:nib5 forCellReuseIdentifier:@"cellID5"];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
      
      if(indexPath.section==0)
      {
            HZFManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID0"];
            cell.model = self.dataSource.firstObject;
            return cell;
            
      }
      if (indexPath.section==1)
      {
           
            HZFMapCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID1"];
            cell.MapView.frame = CGRectMake(5, 5, SWIDTH-10, 190);
            return cell;
            
      }
      if (indexPath.section==2)
      {
            HZFBrightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID2"];
            cell.lableTitle.text = @"亮点";
            cell.icon.image = [UIImage imageNamed:@"laingdina_one"];
            cell.model = self.dataSource.firstObject;
           
            
            return cell;
      }
      if (indexPath.section==3)
      {
            HZFCostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID3"];
            cell.model = self.dataSource.firstObject;
            return cell;
            
      }
      if (indexPath.section==4)
      {
            HZFPromatCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID4"];
            cell.model = self.dataSource.firstObject;
            return cell;
            
      }else
      {
            HZFAskCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID5"];
            cell.model = self.dataSource.firstObject;
            return cell;
      }
      
      
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
      return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
      return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
      if(indexPath.section==3)
      {
            return 256;
      }else
      {
            return 200;
      }
      
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
      if(indexPath.section==1)
      {
            HZFShowMapViewController *map = [[HZFShowMapViewController alloc]init];
            HZFLastModel *model = self.dataSource.firstObject;
      
            map.east =  model.east_longitude;
            map.north = model.north_latitude;
            map.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:map animated:YES];

      }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
      UIView *view = [[UIView  alloc]initWithFrame:CGRectMake(0, 0, 0, 40)];
      UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 40)];
      imageview.image = [UIImage imageNamed:@"back_a"];
      [view addSubview:imageview];
      CGFloat width = (SWIDTH-40)/2.f;
      UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, width, 40)];
      NSArray *array = @[@"商户经理",@"地理位置",@"亮       点",@"费用说明",@"温馨提示",@"咨       询"];
      NSString *title =array[section];
      lable.text = title;
      [imageview addSubview:lable];
      //给每张图片添加点击的手势
      UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageTapClick:)];
      imageview.tag = 888+section;
      imageview.userInteractionEnabled = YES;
      [imageview addGestureRecognizer:tap];
      
      return view;
      
}
- (void)imageTapClick:(UITapGestureRecognizer *)tap{
      //0^1=1,1^1=0
      folder[tap.view.tag-888]=folder[tap.view.tag-888]^1;
      
      [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:tap.view.tag-888] withRowAnimation:UITableViewRowAnimationFade];
      
}
#pragma mark--------------------懒加载-----------------------
-(UITableView *)tableView{
      if(!_tableView)
      {
            _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
      NSInteger product_id = self.currentIndex;
      [manager GET:path_msg(product_id) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            NSDictionary *dict = responseObject[@"data"];
            
            HZFLastModel *model = [[HZFLastModel alloc]initWithDictionary:dict error:nil];
            
            [self.dataSource addObject:model];
           
            //创建滚动视图
            UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SWIDTH, 160)];
            
            scrollView.contentSize=CGSizeMake(SWIDTH*3, 160);
            
            scrollView.showsHorizontalScrollIndicator = NO;
            
            //设置滚动视图的翻页效果
            scrollView.pagingEnabled=YES;
            
            scrollView.delegate=self;
            
            [self.tbHeaderView addSubview:scrollView];
            
            for (int i=0; i<3; i++) {
                  
                  UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*SWIDTH, 0, SWIDTH,160)];
                  switch (i) {
                        case 0:
                              [imageView sd_setImageWithURL:[NSURL URLWithString:model.product_img_1] placeholderImage:[UIImage imageNamed:@"zhanwei3"]];
                              break;
                        case 1:
                              [imageView sd_setImageWithURL:[NSURL URLWithString:model.product_img_2] placeholderImage:[UIImage imageNamed:@"zhanwei3"]];
                              break;
                        case 2:
                              [imageView sd_setImageWithURL:[NSURL URLWithString:model.product_img_3] placeholderImage:[UIImage imageNamed:@"zhanwei3"]];
                              break;
                        default:
                              break;
                  }
                  
                  //将图片添加到滚动视图
                  [scrollView addSubview:imageView];
                  
            }
            
            //创建书页控件
            self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(SWIDTH/2-80, 110, 150, 30)];
            
            self.pageControl.numberOfPages=3;
            
            [self.tbHeaderView addSubview:self.pageControl];
            UIButton * favorite = [UIButton buttonWithType:UIButtonTypeCustom];
            favorite = [UIButton buttonWithType:UIButtonTypeCustom];
            favorite.frame = CGRectMake(SWIDTH-80, 10, 60, 30);
            [favorite setImage:[UIImage imageNamed:@"brozan"] forState:UIControlStateNormal];
            [favorite setImage:[UIImage imageNamed:@"brozan_bule"] forState:UIControlStateSelected];
            
            [favorite setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            favorite.titleLabel.font = [UIFont systemFontOfSize:12];
            
            [favorite addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            favorite.selected = NO;
            [self.tbHeaderView addSubview:favorite];
            [self.tableView reloadData];
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
      }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
      
      self.pageControl.currentPage = scrollView.contentOffset.x/SWIDTH;
}
- (void)buttonAction:(UIButton *) button {
      
      if (button.selected == YES) {
            button.selected  = NO;
            return;
      }
      button.selected = YES;
      
      
      HZFLastModel *model = self.dataSource.firstObject;
      
      if([[HZFDatabaseManager sharedManager] addRecord:model])
      {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" 提示" message:@"已成功添加到我喜欢的" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            
            [alert show];
            
      }
}

@end
