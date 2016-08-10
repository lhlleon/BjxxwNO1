//
//  ShouYeModel.h
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/2/26.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShouYeModel : NSObject

//显示图片
@property (nonatomic,strong) NSString * logo;

//活动名称
@property (nonatomic,strong) NSString * title;

//开始时间
@property (nonatomic,strong) NSMutableString * start_time;

//结束时间
@property (nonatomic,strong) NSMutableString * end_time;

//地点
@property (nonatomic,strong) NSString * address;

//跳转的网页地址
@property (nonatomic,strong) NSString * url;

@end
