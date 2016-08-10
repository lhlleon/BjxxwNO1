//
//  HeaderView.m
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/3/2.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "HeaderView.h"
#import "AFNetworking.h"
#import "URL.h"
#import "UIImageView+AFNetworking.h"
#import "MJExtension.h"
#define Klwidth self.frame.size.width
#define Klheigt self.frame.size.height


@interface HeaderView ()<UIScrollViewDelegate>

{
    UILabel * Scrolllabe;
    UIImageView * imageView;
    NSMutableArray * lunData;
}

@property(nonatomic,strong) UIScrollView * ResrceScroll;

@property(nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) UILabel * title;

@property (nonatomic,strong) UIScrollView *imgView;

@property (nonatomic,strong) UILabel *titles;

@property (nonatomic,strong) UIPageControl *page;



//@property (nonatomic,strong) AFHTTPSessionManager * manager;


@end

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame {
    
    lunData = [[NSMutableArray alloc]init];
    if (self = [super initWithFrame:frame]) {
        [self creatScroll];
        [self createData];
    }
    return self;
}




#pragma mark - scrollView
-(void)creatScroll
{
    //设置滚动视图位置
    _imgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Klwidth, Klheigt)];
    _imgView.backgroundColor = [UIColor redColor];
    //隐藏横向纵向滚动条
    _imgView.showsHorizontalScrollIndicator = NO;
    _imgView.showsVerticalScrollIndicator = NO;
    //设置按页滚动效果
    _imgView.pagingEnabled = YES;
    //设置偏移量
    _imgView.contentOffset = CGPointMake(0, 0);
    _imgView.delegate = self;
    _imgView.contentSize =  CGSizeMake(self.frame.size.width * 4 , self.frame.size.height);
}

#pragma mark - scroll数据


-(void)createData
{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * pro = [NSString stringWithFormat:@"http://www.bjxxw.com/actioncenter/APP/lunbotu.php"];
    [manager GET:pro parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        
        if (arr.count !=0) {
            
            [lunData addObjectsFromArray:arr];
            
            NSLog(@"%@",lunData);
            [self scrollRequest];
        }
        else
        {
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

-(void)scrollRequest
{
   
    NSArray * ass = @[  [UIColor redColor],  [UIColor purpleColor],  [UIColor orangeColor],  [UIColor grayColor]];
    for (int i = 0; i < lunData.count; i++) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Klwidth * i, 0, Klwidth, Klheigt)];
        imageView.userInteractionEnabled = YES;
        imageView.backgroundColor = ass[i];
//        [imageView setImageWithURL:[NSURL URLWithString:[lunData[i] objectForKey:@"imgsrc"]]];
        NSLog(@"@@@@@@E$$$");
        [_imgView addSubview:imageView];
        
        Scrolllabe = [[UILabel alloc]initWithFrame:CGRectMake( 0, Klheigt - 20 , Klwidth - 100, 20)];
        Scrolllabe.text = [lunData[i] objectForKey:@"title"];
         [_imgView addSubview:Scrolllabe];
        NSLog(@"%@",_imgView);  
        
    }
}


@end


