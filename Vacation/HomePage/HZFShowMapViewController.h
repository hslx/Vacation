//
//  HZFShowMapViewController.h
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "HZFRootViewController.h"
#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>

/**搜索功能*/
#import <AMapSearchKit/AMapSearchAPI.h>
@interface HZFShowMapViewController : HZFRootViewController
{
      
      /**s声明地图变量**/
      MAMapView *_mapView;
      
      /**声明POI搜索成员变量*/
      AMapSearchAPI *_search;
      
}
@property(nonatomic,assign) double east;
@property(nonatomic,assign) double north;
@end
