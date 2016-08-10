//
//  ShouYeCollectionViewCell.h
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/2/26.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShouYeModel.h"

@interface ShouYeCollectionViewCell : UICollectionViewCell



@property (nonatomic,strong) ShouYeModel * model;

-(void)loadViewsWithModel:(ShouYeModel *)model;

@property (weak, nonatomic) IBOutlet UIImageView *logo;

@end
