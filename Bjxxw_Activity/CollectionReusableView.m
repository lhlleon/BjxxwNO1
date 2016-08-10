//
//  CollectionReusableView.m
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/3/1.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "CollectionReusableView.h"
#import "AFNetworking.h"
#import "URL.h"
#import "UIImageView+AFNetworking.h"
#import "MJExtension.h"
#import "BaseWebViewController.h"
#import "UIImageView+WebCache.h"
#import "AYPageControl.h"


#define Klwidth self.frame.size.width
#define Klheigt self.frame.size.width/2
#define Kiwidth self.frame.size.width/4
#define totalPages 4



@interface CollectionReusableView ()<UIScrollViewDelegate>

{
    UILabel * Scrolllabe;
    UIImageView * imageView;
    NSMutableArray * lunData;
    int page;
    UIButton * button;
    UILabel * title;
}
@property(nonatomic,strong) UIPageControl *pageControl;

@property (nonatomic,strong) UILabel * title;

@property (nonatomic,strong) UIScrollView * imgView;

@property (nonatomic,strong) UILabel * titles;

@property (nonatomic,strong) UIPageControl * page;

@property (nonatomic,strong) NSArray * URL;

@property (nonatomic, strong) AYPageControlView *pageControlView;


@end



@implementation CollectionReusableView


- (void)awakeFromNib {
    // Initialization code
//    self.backgroundColor = [UIColor orangeColor];
    
    
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor orangeColor];
       // UINavigationController * nan = [[UINavigationController alloc]init];
        
        lunData = [[NSMutableArray alloc]init];
        
        [self creatScroll];
        [self createData];
        [self createButton];
    }
    return self;
}


#pragma mark - 创建button
-(void)createButton
{
    NSArray * image = [NSArray array];
    image = @[@"sqhd1.png",@"dyhd1.png",@"fcjj1.png",@"hwly1.png",@"pdyd1.png",@"yszl1.png",@"yyyc1.png",@"gyhb1.png"];
    NSArray * buttonsTitles = @[@"社区活动",@"电影活动",@"房产家居",@"户外/旅游",@"夜店/派对",@"艺术展览",@"音乐演出",@"公益/环保"];
        
        for (int i = 0 ; i < 2; i++) {
            for (int a = 0 ; a < 4;  a++) {
                
                button = [[UIButton alloc]initWithFrame:CGRectMake(Kiwidth * a + 20, Kiwidth * i + Kiwidth * 2, Kiwidth-40, Kiwidth - 40)];
                [button setBackgroundImage:[UIImage imageNamed:image[4*i + a]] forState:UIControlStateNormal];
                
                UILabel * labels = [[UILabel alloc]initWithFrame:CGRectMake(Kiwidth * a + 5, Kiwidth * i +Kiwidth - 30+ Kiwidth * 2, Kiwidth - 10, 10)];
                labels.text = buttonsTitles[4 * i + a];
                //            labels.numberOfLines = 1;
                //            labels.minimumFontSize = 10;//
                labels.textAlignment = NSTextAlignmentCenter;
                
                labels.font = [UIFont systemFontOfSize:15];
                
                button.tag = 4*i + a;
                
                [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
                
                [self addSubview:labels];
                [self addSubview:button]; 
                
            }
        }
    
    
    UILabel * line = [[UILabel alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 10, self.bounds.size.width, 1 )];
//    [line setBackgroundColor:[UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:1]];
    [line setBackgroundColor:[UIColor grayColor]];
    
    [self addSubview:line];
    
    
}


#pragma mark - button的点击事件
-(void)click:(UIButton *)button
{

    NSLog(@" = = = = %ld",(long)button.tag);
    NSArray * url = [NSArray array];
    url = @[@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=309",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=134",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=307",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=139",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=140",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=279",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=135",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=136"];
    
//    NSLog(@"= = = = %@",url[button.tag]);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dianji" object:url[button.tag]];
}




#pragma mark - scrollView
-(void)creatScroll
{
    //设置滚动视图位置
    _imgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, Klwidth,Klwidth)];
    _imgView.backgroundColor = [UIColor whiteColor];
//    _imgView.contentSize = CGSizeMake(self.bounds.size.width * 6, 0);
    //隐藏横向纵向滚动条
    _imgView.showsHorizontalScrollIndicator = NO;
    _imgView.showsVerticalScrollIndicator = NO;
    //设置按页滚动效果
    _imgView.pagingEnabled = YES;
    //设置偏移量
    _imgView.contentOffset = CGPointMake(Klwidth, 0);
    _imgView.delegate = self;
    
    
    
    self.pageControlView = [[AYPageControlView alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
    self.pageControlView.bindingScrollView = self.imgView;

    self.pageControlView.numberOfPages = 6;
    self.pageControlView.selectedColor = [UIColor blackColor];
    self.pageControlView.unSelectedColor = [UIColor lightGrayColor];
    self.pageControlView.backgroundColor = [UIColor cyanColor];
    [self addSubview:self.pageControlView];
    
    
    
    
    
    [self addSubview:_imgView];
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
        
        
//        if (arr.count !=0) {
        
            [lunData addObjectsFromArray:arr];
            
           NSLog(@"$$$$%@",lunData);
             [self scrollRequest];
//        }
//        else
//        {
//        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
   
}
#pragma mark - 设置滚动视图显示的颜色
-(void)scrollRequest
{
    NSMutableArray * array = [[NSMutableArray alloc]init];
    NSMutableArray * array2 = [[NSMutableArray alloc]init];
    for (int i =0; i< [lunData count]; i++) {
        
        NSString * str = [NSString stringWithFormat:@"%@",[lunData[i]objectForKey:@"imgsrc"]];
        [array addObject:str];
    }
    for (int i =0; i< [lunData count]; i++) {
        
        NSString * str = [NSString stringWithFormat:@"%@",[lunData[i]objectForKey:@"title"]];
        //   NSString * str2 = [NSString stringWithFormat:@"%@",[lunData[i]objectForKey:@"title"]];
        [array2 addObject:str];
        //        [array addObject:str2];
        //        [array2 addObjectsFromArray:array];
    }
 // NSLog(@"22%@",array2);
     [array insertObject:[array lastObject] atIndex:0];
     [array insertObject:array[1] atIndex:[array count]];
    
    [array2 insertObject:[array2 lastObject] atIndex:0];
    [array2 insertObject:array2[1] atIndex:[array2 count]];

    _imgView.contentSize =  CGSizeMake(self.frame.size.width * array.count , self.frame.size.height);
    for (int i =0; i<array.count; i++) {
      
        
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(Klwidth * i, 0, Klwidth, Klheigt-10)];
    imageView.userInteractionEnabled = YES;
       
        NSURL * url = [NSURL URLWithString:array[i]];
        
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        tap.numberOfTapsRequired = 1;
        tap.numberOfTouchesRequired = 1;
        [imageView addGestureRecognizer:tap];
//        [imageView setImageWithURL:url];
        [imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"bki.png"]];
        [_imgView addSubview:imageView];
        
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0, Klheigt - 30, Klwidth, 20)];
        label.backgroundColor = [UIColor blackColor];
        label.alpha = 0.7;
        //背景颜色
//        [imageView addSubview:label];
        
        Scrolllabe = [[UILabel alloc]initWithFrame:CGRectMake( 0, Klheigt - 30 , Klwidth, 20)];
//        NSLog(@"label显示的文字:%lu",(unsigned long)array2.count);
        Scrolllabe.text = [NSString stringWithFormat:@"  %@", array2[i]];
        Scrolllabe.font = [UIFont systemFontOfSize:13];
//        Scrolllabe.backgroundColor = [UIColor blackColor];
        Scrolllabe.textColor = [UIColor whiteColor];
        Scrolllabe.alpha = 0.5;
        
        //底下的文字
//        [imageView addSubview:Scrolllabe];
        
        
    }
    
    UIPageControl * page1 = [[UIPageControl alloc]init];
    
    
    //总页
    page1.numberOfPages = lunData.count;
    
    CGSize size = [page1 sizeForNumberOfPages:lunData.count];

    page1.bounds = CGRectMake(100, 20, size.width, size.height);
    page1.center =CGPointMake(Klwidth/2, Klheigt/2);
    
    
    [Scrolllabe addSubview:page1];
    
    self.pageControl = page1;
}

#pragma mrk - 滚动视图的点击事件
-(void)tapAction:(UITapGestureRecognizer *)tap
{
   
//    NSLog(@"%@",tap);
    switch (page) {
        case 0:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dianji" object:[lunData[3]objectForKey:@"asrc"]];
            break;
        case 1:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dianji" object:[lunData[0]objectForKey:@"asrc"]];
            break;
        case 2:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dianji" object:[lunData[1]objectForKey:@"asrc"]];
            break;
        case 3:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"dianji" object:[lunData[2]objectForKey:@"asrc"]];
            break;
        default:
            break;
    }
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"dianji" object:[lunData[self.pageControl.currentPage]objectForKey:@"asrc"]];
//    NSLog(@"%@",[lunData[self.pa1geControl.currentPage]objectForKey:@"asrc"]);
}
/** 减速停止 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    page = scrollView.contentOffset.x/ Klwidth;
    
    CGPoint point = scrollView.contentOffset;
    if (point.x == Klwidth) {
        scrollView.contentOffset = CGPointMake(5 * Klwidth, 0);
    }
    else if (point.x == 4 * Klwidth){
        
        scrollView.contentOffset = CGPointMake(0 * Klwidth, 0);
    }
    
    if (scrollView.contentOffset.x == Klwidth * 4) {
        page = 0;
    }else if (scrollView.contentOffset.x ==  Klwidth * 5){
        page =1;
    }
    
    self.pageControl.currentPage = page;
    
//        NSLog(@"%ld",(long)self.pageControl.currentPage);

    

    if (page == 0 ){
//  NSLog(@"%@",[lunData[self.pageControl.currentPage - 1]objectForKey:@"asrc"]);
    
    }

    
    
    self.pageControlView.lastContentOffset_x = scrollView.contentOffset.x;
    
    
}

#pragma mark - 设置轮播图

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if ((int)point.x == 0) {
        [scrollView setContentOffset:CGPointMake(self.frame.size.width *4, 0) animated:NO];
    }else if ((int)point.x == self.frame.size.width * 5){
        [scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];

    }
    self.pageControlView.contentOffset_x = scrollView.contentOffset.x;

}



@end
