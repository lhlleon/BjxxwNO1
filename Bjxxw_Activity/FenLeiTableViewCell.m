
//
//  FenLeiTableViewCell.m
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/3/7.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "FenLeiTableViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "UIImageView+WebCache.h"

@implementation FenLeiTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(void)loadViewsWithModel:(FenLeiModel *)model
{
    NSMutableString * str = [[NSMutableString alloc]init];
    str = [NSMutableString stringWithString:ZhuUrl];
    [str insertString:model.logo atIndex:42];
    
//    [_imageurl setImageWithURL:[NSURL URLWithString:str]];
    [_imageurl sd_setImageWithURL:[NSURL URLWithString:str] placeholderImage:[UIImage imageNamed:@"bki.png"]];
    _address.text = [NSMutableString stringWithFormat:@"地点:%@",model.address];
    _titles.text = model.title;
    _times.text = [NSMutableString stringWithFormat:@"活动开始时间:%@",model.start_time];
    _endTime.text = [NSMutableString stringWithFormat:@"活动结束时间:%@",model.end_time];
    
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
