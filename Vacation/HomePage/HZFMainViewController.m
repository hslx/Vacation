//
//  HZFMainViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFMainViewController.h"
#import "HZFAllCountryViewController.h"
#import "HZFSearchViewController.h"
#import "HZFNextViewController.h"
#import "HZFOthersViewController.h"
#import "HZFMainPageCell.h"
#import "HZFMainModel.h"
#import "HZFMacro.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "HZFChildViewController.h"
#define baseImage 666
@interface HZFMainViewController ()<UITableViewDataSource,UITableViewDelegate,HZFMainViewControllerDelgate>
{
      NSInteger site_id;
      NSString *_siteName;
      NSTimer *_timer;
      UIScrollView *_scrollView;
}
@property(nonatomic,strong)UIView *headerView;

@property(nonatomic,strong)UIPageControl * pageControl;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation HZFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      [self createView];
      [self registerNib];
      _siteName = @"北京站";
      [self createNav];
      
      UIImageView *imageView = [[UIImageView alloc]init];
      
      imageView.image = [UIImage imageNamed:@"home_back"];
      
      self.tableView.backgroundView = imageView;
      
      site_id=26;
      
      
      [self loadAdsRequest];
      
      [self.view addSubview:self.tableView];
}
//创建滚动广告视图
-(void)createView{
      CGFloat height;
      if(SWIDTH==375)
      {
            height =265;
      }
      else{
            
            height =226;
      }

      _headerView= [[UIView alloc]initWithFrame:CGRectMake(5, 5, SWIDTH-10, height)];
      
      self.tableView.tableHeaderView=self.headerView;
      
      NSArray *arrTil = @[@"home_bus",@"home_teamoneself",@"home_samcity",@"home_car"];
      
      CGFloat width = SWIDTH;
      
      CGFloat x = (width-20)/2;
      
      
      CGFloat y;
      if(SWIDTH==375)
      {
            y=50;
      }
      else{
            
            y=42.7;
      }
      CGFloat y1;
      if(SWIDTH==375)
      {
            y1=150;
      }
      else{
            
            y1=128;
      }

      for(int i=0;i<4;i++)
      {
           
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(5+(x+10)*(i%2), y1+5+(y+5)*(i/2), x, y)];
            imageView.image = [UIImage imageNamed:arrTil[i]];
            imageView.tag = 849 +i;
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAction:)];
            [imageView addGestureRecognizer:tap];
            imageView.userInteractionEnabled = YES;
            [self.headerView addSubview:imageView];
      }
      
}
- (void)clickAction:(UITapGestureRecognizer *)tap {
      HZFOthersViewController * others = [[HZFOthersViewController alloc]init];
      others.hidesBottomBarWhenPushed = YES;
      others.siteID = site_id;
      switch (tap.view.tag - 848) {
            case 1:{
                  others.currentIndex= 29;
                  others.currentIndex = 0;
                  others.siteID = site_id;
                  break;
            }
            case 2:{
                   others.catID = 24;
                  others.currentIndex = 1;
                  others.siteID = site_id;
                  break;
            }
            case 3:{
                   others.catID = 35;
                  others.currentIndex = 2;
                  others.siteID = site_id;
                  break;
            }
            case 4:{
                   others.catID = 25;
                  others.currentIndex = 3;
                  others.siteID = site_id;
                  break;
            }
            default:
                  break;
      }
      [self.navigationController pushViewController:others animated:YES];

}
- (void)showMsg:(NSInteger)currentIndex SiteName:(NSString *)site_name{
      site_id = currentIndex;
      _siteName = site_name;
      [self.dataArray removeAllObjects];
      [self createNav];
      [self loadAdsRequest];
}

- (void)createNav {

      UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithTitle:_siteName style:UIBarButtonItemStyleDone target:self action:@selector(leftItemAction)];
      self.navigationItem.leftBarButtonItem=leftItem;
      UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(rightItemAction)];
      self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)leftItemAction {
      
      HZFAllCountryViewController *allCountry = [[HZFAllCountryViewController alloc]init];
      allCountry.hidesBottomBarWhenPushed = YES;
      allCountry.delegate =self;
      [self.navigationController pushViewController:allCountry animated:YES];
      
}
- (void)rightItemAction {
      
      HZFSearchViewController *search = [[HZFSearchViewController alloc]init];
      search.hidesBottomBarWhenPushed = YES;
     
      search.siteID = site_id;
   
      [self.navigationController pushViewController:search animated:YES];
}


//加载滚动视图中广告网络数据
-(void)loadAdsRequest {
      
      AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
      //通过GET方法加载网络数据
      [manager GET:path_main(site_id) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [self.dataArray removeAllObjects];
            NSArray *arr = responseObject[@"data"];
            for(NSDictionary *dic in arr)
            {
                  HZFMainModel *model = [[HZFMainModel alloc]initWithDictionary:dic error:nil];
                  [self.dataArray addObject:model];
            }
            CGFloat y;
            if(SWIDTH==375)
            {
                  y=155;
            }
            else{
                  
                  y=128;
            }
            //创建滚动视图
            _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(5, 5, SWIDTH, y)];
            
            _scrollView.contentSize=CGSizeMake(SWIDTH*self.dataArray.count, y);
            
            _scrollView.showsHorizontalScrollIndicator = NO;
            
            //设置滚动视图的翻页效果
            _scrollView.pagingEnabled=YES;
            
            _scrollView.delegate=self;
            
            [self.headerView addSubview:_scrollView];
           
            if(self.dataArray.count==0)
            {
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 0, SWIDTH-10, y)];
                  imageView.image = [UIImage imageNamed:@"laingdina_one"];
                  [self.headerView addSubview:imageView];
            }else
            {
                  for (int i=0; i<self.dataArray.count ; i++) {
                        
                        HZFMainModel *model=[self.dataArray objectAtIndex:i];
                        
                        
                        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*SWIDTH, 0, SWIDTH-10, 150)];
                        
                        [imageView sd_setImageWithURL:[NSURL URLWithString:model.advert_img]];
                        imageView.tag = baseImage + i;
                        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
                        imageView.userInteractionEnabled = YES;
                        [imageView addGestureRecognizer:tap];
                        
                        //将图片添加到滚动视图
                        [_scrollView addSubview:imageView];
                        
                  }
            }
           
            
            //创建书页控件
            self.pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(SWIDTH/2-50, 110, 100, 30)];
            
            self.pageControl.numberOfPages=self.dataArray.count;
            
            [self.headerView addSubview:self.pageControl];
            
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
      }];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
      _pageControl.currentPage=scrollView.contentOffset.x/SWIDTH;
}

#pragma mark----------------点击每张滚动视图------------------
- (void)tapAction:(UITapGestureRecognizer *)tap {
      HZFNextViewController * showMsg = [[HZFNextViewController alloc]init];
      
      HZFMainModel *model = self.dataArray[tap.view.tag -baseImage];
      //传到下个界面的id和标题
      showMsg.currentIndex =model.item_id;
      showMsg.title = model.title;
      showMsg.hidesBottomBarWhenPushed = YES;
      showMsg.hidesBottomBarWhenPushed = YES;
      
      [self.navigationController pushViewController:showMsg animated:YES];
}
//注册自定制cell
- (void)registerNib{
      UINib *nib = [UINib nibWithNibName:@"HZFMainPageCell" bundle:nil];
      [self.tableView registerNib:nib forCellReuseIdentifier:@"cellID"];
      
}
#pragma mark----------------协议方法-----------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
      return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
      return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
      HZFMainPageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
      
      switch (indexPath.section) {
            case 0:
                  cell.imageview.image = [UIImage imageNamed:@"home_ertong"];
                  break;
            case 1:
                  cell.imageview.image = [UIImage imageNamed:@"home_child"];
                  break;
            case 2:
                  cell.imageview.image = [UIImage imageNamed:@"home_dazhe"];
                  break;
            default:
                  break;
      }
      self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
      return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      if(SWIDTH==375)
      {
            return 80;
      }
      else{
            
            return 68;
      }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
      return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
      return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
      switch (indexPath.section) {
            case 0:{
                  HZFChildViewController *child = [[HZFChildViewController alloc]init];
                  child.catID = 34;
                  child.siteID = site_id;
                  child.hidesBottomBarWhenPushed = YES;
                  [self.navigationController pushViewController:child animated:YES];
                  break;
            }
            case 1:{
                  HZFOthersViewController *others = [[HZFOthersViewController alloc]init];
                  others.hidesBottomBarWhenPushed = YES;
                  others.catID = 20;
                  others.siteID = site_id;
                   others.currentIndex = 4;
                  [self.navigationController pushViewController:others animated:YES];
                  break;
            }
            case 2:{
                  HZFOthersViewController *others = [[HZFOthersViewController alloc]init];
                  others.hidesBottomBarWhenPushed = YES;
                  others.siteID = site_id;
                  others.catID = 1;
                   others.currentIndex = 5;
                  [self.navigationController pushViewController:others animated:YES];
                  break;
            }
            default:
                  break;
      }
}
#pragma mark--------------------懒加载----------------------
- (UITableView *)tableView {
      if(!_tableView)
      {
            _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
      
            _tableView.delegate = self;
            _tableView.dataSource =self;
      }
      return _tableView;
}

- (NSMutableArray *)dataArray {
      if(!_dataArray)
      {
            _dataArray = [[NSMutableArray alloc]init];
      }
      return _dataArray;
}
@end
