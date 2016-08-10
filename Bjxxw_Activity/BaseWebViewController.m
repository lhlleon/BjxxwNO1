//
//  BaseWebViewController.m
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/3/1.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "BaseWebViewController.h"
#import "ShouYeModel.h"
#import "URL.h"

#define url @"http://www.bjxxw.com/read.php?tid=531487&fid=67"


@interface BaseWebViewController ()<UIWebViewDelegate>


@property (nonatomic,strong) NSURLRequest * request;

@property (nonatomic,strong) UIActivityIndicatorView * activityIndicator;

@end

@implementation BaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//     NSString * ss = [_CURL absoluteString];
    NSURL * asd = _CURL;
   // _request = [NSURLRequest requestWithURL:_CURL];
    NSString * dd = [NSString stringWithFormat:@"%@",asd];
    NSLog(@"@@@@@@@@@%@",dd);
    _webView.delegate = self;
    NSURL * urlss = [NSURL URLWithString:dd];
    
    NSString * strChou = [NSString stringWithFormat:@"http://www.bjxxw.com/beijing-daohang-41.html"];
    NSURL * newUrl = [NSURL URLWithString:strChou];
    if (urlss == newUrl) {
        _webView.scrollView.contentOffset = CGPointMake(0, 100);
    }
    //<4>将NSURL封装成请求对象
    NSURLRequest * request = [NSURLRequest requestWithURL:urlss];
    //<5>将请求下来的数据显示在webView上

    
    //设置取消网页回弹机制
    _webView.scrollView.bounces = NO;
    
    //设置隐藏右侧滑动只是栏
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    
    [_webView loadRequest:request];

   // [self.view addSubview:web];

  //  [_webView loadRequest:_request];
    
}


#pragma mark - UIWebView的代理方法
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    
    //创建UIActivityIndicatorVIew
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
//    [view setTag:100];
//    [view setBackgroundColor:[UIColor blackColor]];
//    [view setAlpha:0.5];
//    [self.view addSubview:view];
    
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

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"加载失败:%@",error);
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
