//
//  FenLeiTableViewCell.h
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/3/7.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FenLeiModel.h"
#import "URL.h"

@interface FenLeiTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageurl;

@property (weak, nonatomic) IBOutlet UILabel *titles;

@property (weak, nonatomic) IBOutlet UILabel *times;
@property (weak, nonatomic) IBOutlet UILabel *endTime;

@property (weak, nonatomic) IBOutlet UILabel *address;

-(void)loadViewsWithModel:(FenLeiModel *)model;


@end
