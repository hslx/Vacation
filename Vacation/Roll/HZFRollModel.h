//
//  HZFRollModel.h
//  Vacation
//
//  Created by qianfeng on 15/11/14.
//  Copyright (c) 2015年 HZF. All rights reserved.
//

#import "JSONModel.h"

@interface HZFRollModel : JSONModel
/**头像*/
@property(nonatomic,copy) NSString *avatar;

/**发表者*/
@property(nonatomic,copy) NSString *nickname;

/**发表内容*/
@property(nonatomic,copy) NSString *content;

/**图片*/
@property(nonatomic,copy) NSArray *images_all;

/**点赞个数*/
@property(nonatomic,assign) NSInteger praise_count;

@end
