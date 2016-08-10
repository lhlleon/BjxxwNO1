//
//  User.m
//  北京信息网
//
//  Created by LiHanlun on 16/4/13.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "User.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"



#define baseUrl @"http://www.bjxxw.com/actioncenter/"//基础网页
#define haedBase @"http://www.bjxxw.com/windid/attachment/avatar/000/"//头像基础页

@interface User ()

{
//    NSString * userid;
//    NSString * userName;
    NSString * user;
}
@property (nonatomic,strong) NSMutableArray * date;

@property (nonatomic,strong) NSString * userid;

@property (nonatomic,strong) NSString * useruid;

@property (nonatomic,strong) NSString * useruuid;

@property (nonatomic,strong) NSString * userName;
@end


@implementation User

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(NSString *)userName
{
    if (!_userName) {
        _userName = [NSString string];
    }
    return _userName;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        //获取本地cookie
        NSArray *nCookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];NSHTTPCookie *cookie;
        for (id c in nCookies)
        {
            if ([c isKindOfClass:[NSHTTPCookie class]]){
                cookie=(NSHTTPCookie *)c;
                if ([cookie.name  isEqual: @"passport"]) {
                    self.useruuid = cookie.value;
                }
            }
        }
        NSLog(@"%@",self.useruuid);
        
    }
    [self AF];
    [self createTouXiang];
    return self;
}

-(void)useuid:(NSNotification *)click
{
    
    self.useruid = click.object;
        NSLog(@"=====bbbaabababbabab%@",self.useruid);
}

-(void)AF{
    NSArray * arr = [self.useruuid componentsSeparatedByString:@"%"];
    NSLog(@"字符串:%@",arr[0]);
    self.userid = [NSString stringWithFormat:arr[0]];
    NSLog(@"111111%@",self.userid);
    
    
    //个人信息的网络请求
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * url = [NSString stringWithFormat:@"%@APP/username_ajax.php",baseUrl];
    //    NSLog(@"wangye%@",url);
    
    [manager POST:url parameters:@{@"uid":self.userid} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        self.userName= [NSString stringWithFormat:@"%@",[arr[0]objectForKey:@"username"]];
        NSLog(@"user = %@",self.userName);
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 - 500, self.frame.size.height/2, 1000, 100)];
        label.text = self.userName;
        
        label.textColor = [UIColor whiteColor];
        
        label.textAlignment = NSTextAlignmentCenter;
        
        NSLog(@"%@",self.userName);
        
        [self addSubview:label];
        
        
 
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}


-(void)createTouXiang
{
    NSLog(@"%@",self.userid);
    
    //就获取用户 id 的长度
    NSInteger len = [self.userid length];
//    NSLog(@"%ld",(long)len);

    
    UIImageView * image = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-40
                                                                       , 25, 80, 80)];
    
    
    //圆角设置
    image.layer.cornerRadius = 45;
    
    
    
    if (len < 4) {
//        image = [UIImage imageNamed:@"headback"];
        [image setImage:[UIImage imageNamed:@"headback"]];
    }
    else{
        //用户头像地址拼接
    NSString * str1 = [self.userid substringWithRange:NSMakeRange(0, 2)];
    NSString * str2 = [self.userid substringWithRange:NSMakeRange(2, 2)];
    NSURL * url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@/%@/%@_middle.jpg",haedBase,str1,str2,self.userid]];
    NSLog(@"%@",url);

    
    [image sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"headback"]];
    }
    [self addSubview:image];
}








@end
