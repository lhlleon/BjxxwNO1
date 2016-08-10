//
//  LogViewController.m
//  Bjxxw_Activity
//
//  Created by LiHanlun on 16/3/23.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "LogViewController.h"

@interface LogViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIActivityIndicatorView * activityIndicator;


@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createWebView];
}

-(void)createWebView
{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -190, self.view.frame.size.width, self.view.frame.size.height+190)];
    
    webView.backgroundColor = [UIColor whiteColor];
    
    webView.scrollView.backgroundColor = [UIColor whiteColor];
    
    
    NSURL * dd = _URL;
    NSLog(@"%@",dd);
    
    NSURLRequest * request = [NSURLRequest requestWithURL:dd];
    
    webView.delegate = self;
    
    //设置取消网页回弹机制
    webView.scrollView.bounces = NO;
    
    
    //设置隐藏右侧滑动只是栏
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    
    webView.scrollView.delegate = self;//添加webview的scrollview的代理实现webview里的content上下移动
    
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
    
}

- (UIView*)viewForZoomingInScrollView:(UIScrollView*)scrollView{ // 实现代理方法，禁止webview的content上下移动
    return nil;
    
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    _activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 40.0f, 40.0f)];
    [_activityIndicator setCenter:self.view.center];
    [_activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    [self.view addSubview:_activityIndicator];
    
    [_activityIndicator startAnimating];
    
}


-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [_activityIndicator stopAnimating];
    //    UIView * view = (UIView *)[self.view viewWithTag:100];
    //    [view removeFromSuperview];
    
    NSLog(@"加载完毕");
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
