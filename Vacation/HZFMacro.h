//
//  HZFMacro.h
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#ifndef Vacation_HZFMacro_h
#define Vacation_HZFMacro_h

/** 屏幕宽高 */
#define SWIDTH [UIScreen mainScreen].bounds.size.width
#define SHEIGHT [UIScreen mainScreen].bounds.size.height

/** 首页*/
#define PATH_MAIN @"http://app.zmqnw.com.cn/advert?display_position=7&site_id=%ld&channel_id=6"
#define path_main(site_id) [NSString stringWithFormat:PATH_MAIN, site_id]

/**显示*/
#define PATH_SHOW @"http://app.zmqnw.com.cn//topic/detail?id=%ld"
#define path_show(item_id) [NSString stringWithFormat:PATH_SHOW, item_id]

/**全国*/
#define PATH_ALLCOUNTRY  @"http://app.zmqnw.com.cn//site/list"

/**搜索*/
#define PATH_SEARCH @"http://app.zmqnw.com.cn//search/suggest?site_id=%ld&size=10"
#define path_search(site_id)  [NSString stringWithFormat:PATH_SEARCH, site_id]

/**亲子打折和自驾大巴*/
#define PATH_PD @"http://app.zmqnw.com.cn//product/list?cat_id=%ld&size=10&site_id=%ld&offset=%ld"

#define path_cat(cat_id,site_id,offset) [NSString stringWithFormat:PATH_PD, cat_id,site_id,offset]

/**儿童乐园*/

#define PATH_CHILD @"http://app.zmqnw.com.cn//product/list?cat_id=%ld&size=10&site_id=%ld&east_longitude=0.0&north_latitude=0.0&page=%ld"

#define path_child(cat_id,site_id,offset) [NSString stringWithFormat:PATH_CHILD, cat_id,site_id,offset]

/**直播*/
#define PATH_TELEVISE @"http://app.zmqnw.com.cn//broadcast/list?site_id=26&size=5&offset=%ld"
#define path_televise(offset) [NSString stringWithFormat:PATH_TELEVISE, offset]


/**详细内容*/
#define PATH_MSG @"http://app.zmqnw.com.cn//product/detail?product_id=%ld"
#define path_msg(product_id) [NSString stringWithFormat:PATH_MSG, product_id]

#endif
