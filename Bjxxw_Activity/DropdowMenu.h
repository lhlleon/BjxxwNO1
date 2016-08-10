//
//  DropdowMenu.h
//  Bjxxw_Activity
//
//  Created by freedom on 16/3/10.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropdowMenu : UIView

+ (instancetype)menu;
- (void)showFrom:(UIView *)from;
- (void)dismiss;
@property(nonatomic,strong)UIView * content;
@property(nonatomic,strong)UIViewController * contentController;
@end
