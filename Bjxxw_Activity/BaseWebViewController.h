//
//  BaseWebViewController.h
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/3/1.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseWebViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSURL * CURL;

@end
