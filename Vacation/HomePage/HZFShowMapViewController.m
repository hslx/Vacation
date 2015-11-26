//
//  HZFShowMapViewController.m
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFShowMapViewController.h"

@interface HZFShowMapViewController ()<MAMapViewDelegate,AMapSearchDelegate>

@end

@implementation HZFShowMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
      
      [self showMapView];
          [self mapConreol];
      
          [self mapBasicHandle];
          [self annotaionView];
      
          [self maplocation];
      //[self searchByAround];
          [self searchByKeyWords];
          [self geoCode];
          [self regeoCode];
}
/**周边查找*/
-(void)searchByAround
{
      _search=[[AMapSearchAPI alloc]initWithSearchKey:@"1b229596715d2dcbf399b5ec6d64f9c4" Delegate:self];
      //创建搜索地点的对象
      AMapPlaceSearchRequest *request=
      [[AMapPlaceSearchRequest alloc]init];
      //搜索对象的类型
      request.searchType=AMapSearchType_PlaceAround;
      
      //搜索半径
      request.radius=1000;
      
      //设置中心点
      
     // request.location=[AMapGeoPoint locationWithLatitude:39.98631 longitude:116.481018];
      request.location=[AMapGeoPoint locationWithLatitude:self.north longitude:self.east];
     
      request.keywords=@"大学";
      
      //开始搜素
      
      [_search AMapPlaceSearch:request];
      
}
/**反地理编码*/
-(void)regeoCode
{
      _search=[[AMapSearchAPI alloc]initWithSearchKey:@"1b229596715d2dcbf399b5ec6d64f9c4" Delegate:self];
      AMapReGeocodeSearchRequest *request=[[AMapReGeocodeSearchRequest alloc]init];
      request.searchType=AMapSearchType_ReGeocode;
      
      //request.location=[AMapGeoPoint locationWithLatitude:39.908722 longitude:116.397499];
      request.location=[AMapGeoPoint locationWithLatitude:self.north longitude:self.east];
 
      [_search AMapReGoecodeSearch:request];
      
}

/**反地理编码结束时调用方法*/
-(void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
      NSLog(@"%@",response.regeocode.formattedAddress);
      
      
}



/**地理编码*/
-(void)geoCode
{
      
      _search=[[AMapSearchAPI alloc]initWithSearchKey:@"1b229596715d2dcbf399b5ec6d64f9c4" Delegate:self];
      
      AMapGeocodeSearchRequest *request=[[AMapGeocodeSearchRequest alloc]init];
      
      //设置搜索类型为地理编码
      request.searchType=AMapSearchType_Geocode;
      
      //设置准备搜索的地点
      request.address=@"天安门";
      //设置搜索范文
      request.city=@[@"010"];
      
      //开始搜索
      
      [_search AMapGeocodeSearch:request];
}
//当地理编码结束时条用
-(void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
      [response.geocodes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            AMapGeocode *code=(AMapGeocode *)obj;
            NSLog(@"%f  %f",code.location.longitude,code.location.latitude);
      }];
      
}


/**关键字查询*/
-(void)searchByKeyWords
{
      //0e0426f5d845a88f0a31b77f78dbc0d4 1b229596715d2dcbf399b5ec6d64f9c4
      //创建搜索对象
      _search=[[AMapSearchAPI alloc]initWithSearchKey:@"1b229596715d2dcbf399b5ec6d64f9c4" Delegate:self];
      //创建准备搜索的地点的对象
      AMapPlaceSearchRequest *request=[[AMapPlaceSearchRequest alloc]init];
      //设置搜索类型  关键字查询
      request.searchType=AMapSearchType_PlaceKeyword;
      
      //设置准备查询的关键字
      request.keywords=@"KFC";
      
      //设置准备查询的范围
      request.city=@[@"010"];
      //开始查询
      [_search AMapPlaceSearch:request];
      
}

//当搜索完成时 调用该方法
-(void)onPlaceSearchDone:(AMapPlaceSearchRequest *)request response:(AMapPlaceSearchResponse *)response
{
      //获得每个兴趣点的相关信息
      for (AMapPOI *poi in response.pois)
      {
            
            
            NSLog(@"精度:%f   纬度:%f   兴趣点名称:%@    地址:%@  ",poi.location.longitude,poi.location.latitude,poi.name,poi.address);
            
      }
      
}


//307655576360

/**地图定位*/
-(void)maplocation
{
      //开启地图定位
      _mapView.showsUserLocation=YES;
      
      
      
}

/**当手机移动时 调用该方法*/
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
      if(updatingLocation)
      {
            NSLog(@"lon:%f lat:%f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
            NSLog(@"手机移动了");
      }
      
      
}


//显示地图
-(void)showMapView
{
      
      [MAMapServices sharedServices].apiKey=@"1b229596715d2dcbf399b5ec6d64f9c4";
      
      //创建地图
      _mapView=[[MAMapView alloc]initWithFrame:CGRectMake(0, 64, SWIDTH, SHEIGHT)];
      
      //设置地图的回调
      _mapView.delegate=self;
      
      //将地图添加到仕途上
      [self.view addSubview:_mapView];
      
      
}

-(void)mapConreol{
      //设置比例尺坐标
      //    _mapView.scaleOrigin=CGPointMake(100, 100);
      //隐藏比例尺
      //    _mapView.showsScale=NO;
      
      //指南针位置
      //    _mapView.compassOrigin=CGPointMake(100, 100)
      
      ;
      //隐藏指南针
      //    _mapView.showsCompass=NO;
      
      //logo 位置
      //    _mapView.logoCenter=CGPointMake(100, 100);
      
      
}
/**地图操作*/
-(void)mapBasicHandle
{
      
      //设置地图的齿合度 官方为3--19  实际为0--21
      [_mapView setZoomLevel:10];
      
      
      //设置地图显示的中心点位置
      //CLLocationCoordinate2D location=CLLocationCoordinate2DMake(39.989631, 116.481018);
      CLLocationCoordinate2D location = CLLocationCoordinate2DMake(self.north, self.east);
      [_mapView setCenterCoordinate:location];
      
      UIImageView *imageview=[[UIImageView alloc   ]initWithFrame:CGRectMake(0, 0, 100, 100)];
      [self.view addSubview:imageview];
      imageview.image= [_mapView takeSnapshotInRect:CGRectMake(100, 100, 100, 100)];
      
}
/**地图上的大头针  覆盖物的使用*/
-(void)annotaionView
{
      //向地图中添加覆盖物
      
      MAPointAnnotation *point=[[MAPointAnnotation alloc]init];
      //设置覆盖物的经纬度
      point.coordinate=CLLocationCoordinate2DMake(self.north, self.east);
      //设置覆盖物的标题与副标题
      
      //point.title=@"北科";
//      
     //point.subtitle=@"haha";
      
      //将覆盖物添加到地图
      
      [_mapView addAnnotation:point];
}
/** 当向地图中添加覆盖物是 调用该方法 需要在这个方法中制定覆盖物的类型   协议方法*/
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
      
      static NSString *str=@"annID";
      
      //在服用队列中获得大头针
      MAPinAnnotationView *pin=(MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:str];
      if(!pin)
      {
            pin=[[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:str];
      }
      
      //设置大头针允许拖拽
      //    pin.draggable=YES;
      //    //设置大头针允许显示气泡
      pin.canShowCallout=YES;
      //    //设置大头针插入动画
          pin.animatesDrop=YES;
      //    //设置pin颜色
      //    pin.pinColor=MAPinAnnotationColorGreen;
      
      /**用图片自定制大头针*/
      pin.image=[UIImage imageNamed:@"MAGENTA"];
      
      return pin;

}
@end
