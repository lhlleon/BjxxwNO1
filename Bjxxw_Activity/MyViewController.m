//
//  MyViewController.m
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/2/24.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "MyViewController.h"
#import "LogViewController.h"
#import "MyView.h"
#import "LoginURL.h"
#import "BaseWebViewController.h"
#import "WebViewControll.h"
#import "HeardView.h"
#import "AFNetworking.h"



#define KW self.view.frame.size.width
#define KH self.view.frame.size.height


@interface MyViewController ()
{
    NSString * userid;
    NSString * url;
    
}

@property (nonatomic,strong) UIButton * button;

@property (nonatomic,strong) UIButton * zhuCe;

@property (nonatomic,strong) UIImageView * image;

@property (nonatomic,strong) LogViewController * lView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    userid = nil;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dianji:) name:@"dianle" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(huanle:) name:@"lingwai" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(touxiang:) name:@"touxiang" object:nil];
    //    [self panDuanLogin];
}


-(void)touxiang:(NSNotification *)click
{
    NSString * qq = click.object;
    HeardView * hv = [[HeardView alloc]init];
    NSURL * url = [NSURL URLWithString:qq];
    hv.URL = url;
    [self.navigationController pushViewController:hv animated:YES];
    
}

-(void)huanle:(NSNotification *)click
{
    NSString * qq = click.object;
    WebViewControll * lv = [[WebViewControll alloc]init];
    NSURL * url11 = [NSURL URLWithString:qq];
    lv.URL = url11;
    [self.navigationController pushViewController:lv animated:YES];
    
    
}


-(void)dianji:(NSNotification *)click
{
    NSString * qq = click.object;
    _lView = [[LogViewController alloc]init];
    NSURL * url12 = [NSURL URLWithString:qq];
    _lView.URL = url12;
    [self.navigationController pushViewController:_lView animated:YES];
}


-(void)viewWillAppear:(BOOL)animated
{
    [self panDuanLogin];
}



#pragma mark - 判断是否登录
//判断是否登录成功
-(void)panDuanLogin
{
    NSArray *nCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];NSHTTPCookie *cookie;
    for (id c in nCookies)
    {
        if ([c isKindOfClass:[NSHTTPCookie class]]){
            cookie=(NSHTTPCookie *)c;
            if ([cookie.name  isEqual: @"passport"]) {
                userid = cookie.value;
            }
        }
    }
    
    
    if(userid == nil){
        [self createImage];
        [self createLogin];
        [self createZhuCe];
    }else{
        self.view.backgroundColor = [UIColor blackColor];
        [super viewWillAppear:YES];
        [self.image removeFromSuperview];
        [self.button removeFromSuperview];
        [self.zhuCe removeFromSuperview];
        self.image = nil;
        self.button = nil;
        self.zhuCe = nil;
        
        MyView * mview = [[MyView alloc]initWithFrame:CGRectMake(0, 29, self.view.frame.size.width, self.view.frame.size.height - 29)];
        
        
        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"useid" object:userid];
        
        [self.view addSubview:mview];
        
        
        
    }
}

#pragma mark - 登录页面设置
-(void)createImage
{
    _image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo"]];
    _image.frame = CGRectMake(KW/2 - (KW/2-90)/2, KH/2 - (KH/2 - 20 )/2, KW / 2 - 90 , KW / 2 - 90);
    [self.view addSubview:_image];
}

-(void)createLogin
{
    _button = [UIButton buttonWithType:UIButtonTypeSystem];
    _button.frame = CGRectMake(KW/2 - (KW - 50) /2 , KH/2 + 30, KW - 50, 50);
    //设置背景颜色
    [_button setBackgroundColor:[UIColor colorWithRed:255/255.0 green:85/255.0 blue:0/255.0 alpha:1]];
    //设置文字
    [_button setTitle:@"登 录" forState:UIControlStateNormal];
    //设置文字字体大小
    _button.titleLabel.font = [UIFont systemFontOfSize:30];
    //设置文字颜色
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _button.layer.cornerRadius = 10.0;
    
    //设置button的点击事件
    [_button addTarget:self action:@selector(onClick1:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button];
}

#pragma mark - 登录的点击事件
-(void)onClick1:(UIButton *)button
{
    NSLog(@"点击了");
    NSString * path = [NSString stringWithFormat:@"http://www.bjxxw.com/index.php?m=my&c=fresh"];
    NSURL * url1 = [NSURL URLWithString:path];
    LogViewController * lView = [[LogViewController alloc]init];
    lView.URL = url1;
    [self.navigationController pushViewController:lView animated:YES];
}

-(void)createZhuCe
{
    _zhuCe = [UIButton buttonWithType:UIButtonTypeSystem];
    _zhuCe.frame = CGRectMake(KW/2 - (KW - 50) / 2, KH/2 + 120, KW - 50, 50);
    [_zhuCe setBackgroundColor:[UIColor whiteColor]];
    
    //设置button边框
    [_zhuCe.layer setBorderWidth:1.0];
    
    //设置button边框颜色
    [_zhuCe.layer setBorderColor:[[UIColor colorWithRed:255/255.0 green:85/255.0 blue:0 alpha:1] CGColor]];
    
    //设置button圆角
    [_zhuCe.layer setCornerRadius:10.0];
    
    //设置文字
    [_zhuCe setTitle:@"注 册" forState:UIControlStateNormal];
    //设置字体大小
    _zhuCe.titleLabel.font = [UIFont systemFontOfSize:30];
    //设置字体颜色
    [_zhuCe setTitleColor:[UIColor colorWithRed:255/255.0 green:85/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
    
    //添加button的点击事件
    [_zhuCe addTarget:self action:@selector(onClick2:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_zhuCe];
    
    
    
}

-(void)onClick2:(UIButton *)zhuCe
{
    NSLog(@"点击了");
    NSString * path = [NSString stringWithFormat:@"http://www.bjxxw.com/index.php?m=u&c=register"];
    NSURL * url1 = [NSURL URLWithString:path];
    _lView = [[LogViewController alloc]init];
    _lView.URL = url1;
    
    
    
    [self.navigationController pushViewController:_lView animated:YES];
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
