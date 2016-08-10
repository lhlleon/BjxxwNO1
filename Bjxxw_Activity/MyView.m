//
//  MyView.m
//  Bjxxw_Activity
//
//  Created by LiHanlun on 16/3/24.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "MyView.h"
#import "AFNetworking.h"
#import "LoginURL.h"
#import "MyViewController.h"
#import "HHAlertView.h"
#import "MJExtension.h"
#import "User.h"


#define ListName @"name" //对应数据的kay
#define baseUrl @"http://www.bjxxw.com/actioncenter/"//基础网页

@interface MyView ()<UITableViewDelegate,UITableViewDataSource>

{
    NSArray * listData;
    NSString * useruid;
    NSString * userName;
    //    NSMutableArray * date;//用户姓名数据源
}

@property (nonatomic,strong) UITableView * listTable;

@property (nonatomic,strong) NSString * username1;

@property (nonatomic,strong) NSMutableArray * date;

@property (nonatomic,strong) NSString * userid;

@end

@implementation MyView

-(NSMutableArray *)date
{
    if (!_date) {
        _date = [NSMutableArray array];
    }
    return _date;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _username1 = nil;
        [self createList];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(useuid:) name:@"useid" object:nil];
        //        _userName = @"1";
    }
    return self;
}

-(void)useuid:(NSNotification *)click
{
    
    useruid = click.object;
    //    NSLog(@"=====bbbaabababbabab%@",useruid);
}


-(void)createList
{
    
    _listTable = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStyleGrouped];
    
    
    _listTable.dataSource = self;
    _listTable.delegate = self;
    [self addSubview:_listTable];
    
    NSLog(@"%@",_userName);
    //设置数据源
    
}

#pragma mark - 数据源方法

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1) {
        return 5;
    }else if (section == 2){
        return 6;
    }
    else{
        return 1;
    }
    
}



#pragma mark 返回每一行显示的内容(每一行显示怎样的cell)
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;  //设置点击无颜色；
    
    if (indexPath.section == 0) {
        //通过view显示用户信息
        if (self.frame.size.height == 539) {
            User * uv = [[User alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 400)];
                  [cell addSubview:uv];
            
        }
        else if (self.frame.size.height == 638)
        {
            User * uv = [[User alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 500)];

            
                  [cell addSubview:uv];
        }
        else
        {
            User * uv = [[User alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height - 530)];
                  [cell addSubview:uv];
        }
  
        NSLog(@"当前屏幕高度 ： %f",self.frame.size.height);
        //设置
        
        cell.accessoryType = UITableViewCellAccessoryNone;//设置cell右边的箭头隐藏
        
        //        cell.backgroundColor = [UIColor orangeColor];
        cell.backgroundView = [[UIImageView  alloc]initWithImage:[UIImage imageNamed:@"bj"]];
        
    }
    if (indexPath.section == 1) {
        
        
        NSArray * array = @[@"我的活动",@"我的关注",@"我的粉丝",@"我的回复",@"发布活动"];
        NSArray * image = @[@"wdhd",@"wdgz",@"wdfs",@"wdhf",@"fbhd"];
        for (int i = 0; i < array.count; i++) {
            if (indexPath.row == i) {
                //创建文字
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 200, 40)];
                label.text = array[i];
                label.font = [UIFont systemFontOfSize:16];
                [cell addSubview:label];
                
                //创建图片
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
                imageView.image = [UIImage imageNamed:image[i]];
                [cell addSubview:imageView];
                }
            }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//设置cell右边的箭头
    }
    if (indexPath.section == 2) {
        NSArray * array = @[@"基本资料",@"联系方式",@"空间隐私",@"黑名单",@"修改密码",@"我的权限",@"我的积分"];
        NSArray * image = @[@"jbzl",@"llfs",@"kjys",@"hmd",@"xgmm",@"wdqx",@"wdjf"];
        
        
        for (int i = 0; i<array.count; i ++) {
            if (indexPath.row == i) {
                //创建文字
                UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 200, 40)];
                label.text = array[i];
                label.font = [UIFont systemFontOfSize:16];
                [cell addSubview:label];
                
                //创建图片
                UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
                imageView.image = [UIImage imageNamed:image[i]];
                [cell addSubview:imageView];
                
            }
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//设置cell右边的箭头
    }
    if (indexPath.section == 3) {
        //创建文字
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 200, 40)];
        label.text = @"关于我们";
        label.font = [UIFont systemFontOfSize:16];
        [cell addSubview:label];
        
        //创建图片
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        imageView.image = [UIImage imageNamed:@"gywm"];
        [cell addSubview:imageView];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//设置cell右边的箭头
    }
    if (indexPath.section == 4) {
        //创建文字
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(40, 0, 200, 40)];
        label.text = @"退出账号";
        label.font = [UIFont systemFontOfSize:16];
        [cell addSubview:label];
        
        //创建图片
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        imageView.image = [UIImage imageNamed:@"tczh"];
        [cell addSubview:imageView];
        
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//设置cell右边的箭头
    }
    
    //    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//设置cell右边的箭头
    
    
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else
        return 15;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4) {
        return 80;
    }
    return 15;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"section = %ld ,, row = %ld" , (long)indexPath.section,(long)indexPath.row);
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        _clickUrl = @"http://www.bjxxw.com/index.php?m=profile&c=avatar&type=nomal";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"touxiang" object:_clickUrl];
        
        
    }else if(indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
                _clickUrl = MYActivitUrl;
                break;
            case 1:
                _clickUrl = MYLockUrl;
                break;
            case 2:
                _clickUrl = MYFansUrl;
                break;
            case 3:
                _clickUrl = MYReplyUrl;
                break;
            case 4:
                _clickUrl = FaBuA;
                break;
            default:
                break;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"dianle" object:_clickUrl];
        
    }else if(indexPath.section == 2){
        switch (indexPath.row) {
            case 0:
                _clickUrl = Jiben;
                break;
            case 1:
                _clickUrl = LianXi;
                break;
            case 2:
                _clickUrl = KongJian;
                break;
            case 3:
                _clickUrl = HeiMing;
                break;
            case 4:
                _clickUrl = XiuGai;
                break;
            case 5:
                _clickUrl = QuanXian;
                break;
            case 6:
                _clickUrl = JiFen;
                break;
            default:
                break;
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"lingwai" object:_clickUrl];
    }
    else if (indexPath.section == 3){
        _clickUrl = @"http://bjxxw.com/foot/guanyuwomen/about_us.html";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"lingwai" object:_clickUrl];
    }
    else if(indexPath.section == 4){
        
        
        
        HHAlertView *alertview = [[HHAlertView alloc] initWithTitle:@"退出成功" detailText:@"即将退回首界面哦!" cancelButtonTitle:nil otherButtonTitles:@[@"确定"]];
        [alertview setEnterMode:HHAlertEnterModeLeft];
        [alertview setLeaveMode:HHAlertLeaveModeBottom];
        [alertview showWithBlock:^(NSInteger index) {
            //清除本地cookie
            NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
            NSArray *_tmpArray = [NSArray arrayWithArray:[cookieJar cookies]];
            for (id obj in _tmpArray) {
                [cookieJar deleteCookie:obj];
            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"tuichu" object:nil];
            
            
        }];
    }
}

#pragma mark - 判断section为1的时候  cell的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
        if (self.frame.size.height == 539) {
            return self.frame.size.height - 400;
        }
        else if (self.frame.size.height == 638)
        {
            return self.frame.size.height - 500;
        }
        else{
            return self.frame.size.height - 530;
        }
        
    }
    return 40;
}

@end
