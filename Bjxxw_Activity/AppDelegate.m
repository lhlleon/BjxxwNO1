//
//  AppDelegate.m
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/2/24.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "AppDelegate.h"
#import "ShouYeViewController.h"
#import "FenLeiViewController.h"
#import "HuoDongViewController.h"
#import "MyViewController.h"
#import "TabBarViewController.h"
#import "CALayer+Transition.h"
#import "XZMCoreNewFeatureVC.h"
#import "JPUSHService.h"
#import "LHLPushHelper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // Override point for customization after application launch.
    
    [LHLPushHelper setupWithOptions:launchOptions];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(root:) name:@"tuichu" object:nil];
    
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window = window;
    
    //判断是否需要显示：（内部已经考虑版本及本地版本缓存）
    BOOL canShow = [XZMCoreNewFeatureVC canShowNewFeature];
    
    //判断是否是第一次登陆!!!!!
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
    
           [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
            NSLog(@"第一次启动");
            canShow = YES;
            //如果是第一次启动的话,使用UserGuideViewController (用户引导页面) 作为根视图
    
        }
         else
    {
        
        canShow = NO;
            NSLog(@"不是第一次启动");
            //如果不是第一次启动的话,使用LoginViewController作为根视图
        }
    
    if(canShow){ // 初始化新特性界面
        window.rootViewController = [XZMCoreNewFeatureVC newFeatureVCWithImageNames:@[@"1.jpg",@"2.jpg",@"3.jpg",@"4.jpg"] enterBlock:^{
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
            NSLog(@"第一次启动");
            NSLog(@"进入主页面");
            [self enter];
            
        } configuration:^(UIButton *enterButton) { // 配置进入按钮
            [enterButton setBackgroundImage:[UIImage imageNamed:@"jin"] forState:UIControlStateNormal];
            [enterButton setBackgroundImage:[UIImage imageNamed:@"jin"] forState:UIControlStateHighlighted];
            enterButton.bounds = CGRectMake(0, 0, 120, 35);
            enterButton.center = CGPointMake(KScreenW * 0.5, KScreenH* 0.85);
        }];
        
    }else{
        
        [self enter];
    }
    
    [window makeKeyAndVisible];
    
    return YES;
    
    
}


-(void)enter{
    
    
    ShouYeViewController * svc = [[ShouYeViewController alloc]init];
    FenLeiViewController * fvc = [[FenLeiViewController alloc]init];
    HuoDongViewController * hvc = [[HuoDongViewController alloc]init];
    MyViewController * myvc = [[MyViewController alloc]init];
    TabBarViewController * tbc = [[TabBarViewController alloc]init];
    tbc.viewControllers = @[svc,fvc,hvc,myvc];
    
    //创建导航控制器
    UINavigationController * nvc = [[UINavigationController alloc]initWithRootViewController:tbc];
    tbc.title = @"北京信息网";
    
    //创建右边按钮
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightButton setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
    
    
    
    self.window.rootViewController = nvc;
}



//点击退出按钮的时候所做的事情
-(void)root:(NSNotification *)click
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(root:) name:@"tuichu" object:nil];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    ShouYeViewController * svc = [[ShouYeViewController alloc]init];
    FenLeiViewController * fvc = [[FenLeiViewController alloc]init];
    HuoDongViewController * hvc = [[HuoDongViewController alloc]init];
    MyViewController * myvc = [[MyViewController alloc]init];
    TabBarViewController * tbc = [[TabBarViewController alloc]init];
    tbc.viewControllers = @[svc,fvc,hvc,myvc];
    
    //创建导航控制器
    _nvc = [[UINavigationController alloc]initWithRootViewController:tbc];
    tbc.title = @"北京信息网";
    
    //创建右边按钮
    UIButton * rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    [rightButton setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
//    [rightButton addTarget:self  action:nil forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem*rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    
    //    UIBarButtonItem * rightButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:nil];
    //    rightButton.image = image;
    
    
    self.window.rootViewController = _nvc;
    [self.window makeKeyAndVisible];
    
}


#pragma mark - 推送的一些设置
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [LHLPushHelper registerDeviceToken:deviceToken];
    return;
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [LHLPushHelper handleRemoteNotification:userInfo completion:nil];
    return;
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
// ios7.0以后才有此功能
- (void)application:(UIApplication *)application didReceiveRemoteNotification
                   :(NSDictionary *)userInfo fetchCompletionHandler
                   :(void (^)(UIBackgroundFetchResult))completionHandler {
    [LHLPushHelper handleRemoteNotification:userInfo completion:completionHandler];
    
    // 应用正处理前台状态下，不会收到推送消息，因此在此处需要额外处理一下
    if (application.applicationState == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"收到推送消息"
                                                        message:userInfo[@"aps"][@"alert"]
                                                       delegate:nil
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];
        [alert show];
    }
    return;
}
#endif



- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [LHLPushHelper showLocalNotificationAtFront:notification];
    return;
}


- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    NSLog(@"Error in registration. Error: %@", err);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [application setApplicationIconBadgeNumber:0];
    return;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}



- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
