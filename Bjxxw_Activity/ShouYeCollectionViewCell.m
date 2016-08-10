//
//  ShouYeCollectionViewCell.m
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/2/26.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "ShouYeCollectionViewCell.h"
#import "URL.h"
#import "AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"

@interface ShouYeCollectionViewCell ()



@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *start_time;

@property (weak, nonatomic) IBOutlet UILabel *end_time;

@property (weak, nonatomic) IBOutlet UILabel *address;




@end


@implementation ShouYeCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}



-(void)loadViewsWithModel:(ShouYeModel *)model
{
    
   // _model = model;
  //  NSLog(@"======%@=====", model.title);
    
    //字符串拼接  做图标显示
    NSMutableString * str = [[NSMutableString alloc]init];
    str = [NSMutableString stringWithString:ZhuUrl];
    [str insertString:model.logo atIndex:42];
    
//    NSLog(@"字符串-------%@",str);
    
//   [_logo setImageWithURL:[NSURL URLWithString:str]];
    [_logo sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"bki.png"]];
    
//    NSLog(@"%@",_logo);
    
    _title.text = model.title;
    _start_time.text = [NSString stringWithFormat:@"开始时间:%@",model.start_time];
    _end_time.text = [NSString stringWithFormat:@"结束时间:%@",model.end_time];
    _address.text = [NSString stringWithFormat:@"活动地点:%@",model.address];
    
    

}





@end
