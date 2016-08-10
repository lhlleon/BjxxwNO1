//
//  WebViewControll.m
//  Bjxxw_Activity
//
//  Created by LiHanlun on 16/3/25.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "WebViewControll.h"
#import "MyViewController.h"

@interface WebViewControll ()
{
    NSString * tuichu;
}

@end

@implementation WebViewControll 


-(void)viewDidLoad
{
    tuichu = nil;
    [self createWebView];
}



-(void)createWebView
{
    
    
//    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height+190)];
    
//    webView.backgroundColor = [UIColor grayColor];
    
    NSURL * dd = _URL;
    NSLog(@"%@",dd);
    
    NSURL * aa = [NSURL URLWithString:@"http://www.bjxxw.com/index.php?m=profile&c=avatar&type=nomal"];
    
    if (dd == aa) {
        
    UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 150, self.view.frame.size.width, self.view.frame.size.height)];
        
        webView.backgroundColor = [UIColor grayColor];
        NSURLRequest * request = [NSURLRequest requestWithURL:dd];
        
        webView.delegate = self;
        
        //设置取消网页回弹机制
//        webView.scrollView.bounces = NO;
        
        
        //设置隐藏右侧滑动只是栏
        webView.scrollView.showsVerticalScrollIndicator = NO;
        
        
        
        
        [webView loadRequest:request];
        
        [self.view addSubview:webView];
        
        
    }else{
        
        UIWebView * webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, -150, self.view.frame.size.width, self.view.frame.size.height+190)];
        
        webView.backgroundColor = [UIColor grayColor];
        NSURLRequest * request = [NSURLRequest requestWithURL:dd];
        
        webView.delegate = self;
        
        //设置取消网页回弹机制
        webView.scrollView.bounces = NO;
        
        
        //设置隐藏右侧滑动只是栏
        webView.scrollView.showsVerticalScrollIndicator = NO;
        
        
        
        
        [webView loadRequest:request];
        
        [self.view addSubview:webView];
        
    }
    
//    NSURLRequest * request = [NSURLRequest requestWithURL:dd];
//    
//    webView.delegate = self;
//    
//    //设置取消网页回弹机制
//    webView.scrollView.bounces = NO;
//    
//    
//    //设置隐藏右侧滑动只是栏
//    webView.scrollView.showsVerticalScrollIndicator = NO;
//    
//    
//    
//    
//    [webView loadRequest:request];
//    
//    [self.view addSubview:webView];
//    
}



@end
