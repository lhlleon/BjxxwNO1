//
//  HeardView.m
//  北京信息网
//
//  Created by LiHanlun on 16/4/5.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "HeardView.h"

@implementation HeardView


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createWebView];
}



-(void)createWebView
{
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+190)];
    
    webView.backgroundColor = [UIColor grayColor];
    
    NSURL * dd = _URL;
    NSLog(@"%@",dd);
    
    NSURLRequest * request = [NSURLRequest requestWithURL:dd];
    
    //设置取消网页回弹机制
    webView.scrollView.bounces = NO;
    
    //设置隐藏右侧滑动只是栏
    webView.scrollView.showsVerticalScrollIndicator = NO;
    
    
    
    
    [webView loadRequest:request];
    
    [self.view addSubview:webView];
    
    
}
@end
