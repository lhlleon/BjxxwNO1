//
//  FenLeiViewController.m
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/2/24.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "FenLeiViewController.h"
#import "AFNetworking.h"
#import "URL.h"
#import "FenLeiModel.h"
#import "MJExtension.h"
#import "FenLeiTableViewCell.h"
#import "DropdowMenu.h"
#import "ALLTableViewController.h"
#import "UIView+Extension.h"
#import "BLLTableViewController.h"
#import "MJRefresh.h"
#import "BaseWebViewController.h"
#import "HHAlertView.h"

@interface FenLeiViewController ()<UITableViewDataSource,UITableViewDelegate,HHAlertViewDelegate>
{
    UIView * view;
    DropdowMenu * menu;
    DropdowMenu * menu1;
    NSString * biaoTi;
    NSString * shijian;
    UIButton * btn1;
    UIButton * btn2;
}
@property (nonatomic,strong) UITableView * fenTableView;

@property (nonatomic,strong) AFHTTPSessionManager * manager;

@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,strong) NSString * tid;

@property (nonatomic,assign) int page;

@property (nonatomic,strong) NSString * time;

@property (nonatomic,strong) NSString * start_time;

@property (nonatomic,strong) NSString * end_time;

@property (nonatomic,strong) NSString * dateing;

@property (nonatomic,strong) NSDateFormatter * formatter;

@property (nonatomic,strong) NSString * dateTime;



@end

@implementation FenLeiViewController

static NSString * iden = @"hello";

-(NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tid = @"";
    _start_time = @"";
    _end_time = @"";
    _dateing = @"1";
    biaoTi = @"全部分类";
    shijian = @"活动时间";
    [self.fenTableView registerNib:[UINib nibWithNibName:NSStringFromClass([FenLeiTableViewCell class]) bundle:nil] forCellReuseIdentifier:iden];
    [self btnView];
    [self createTableView];
    [self dataRequest];
    [self createTime];
    
    //接受通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onClick:) name:@"CityID" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onClick1:) name:@"ClassB" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(biaoti:) name:@"biaoti" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shijian:) name:@"shijian" object:nil];
    
    [self createRefresh];
    
}

#pragma mark - 加载

-(void)createRefresh
{
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_fenTableView addFooterWithTarget:self action:@selector(footerRereshing)];
    //一些设置
    // 设置文字
    
    _fenTableView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _fenTableView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _fenTableView.footerRefreshingText = @"加载中。。。";
    
}

-(void)footerRereshing
{
    _page ++;
    //@"classid":@"",@"page":@"0",@"start_time":@"",@"end_time":@"",@"id_date_ing":@""
    NSString * page = [NSString stringWithFormat:@"%d",_page];
    
    NSDictionary * classid = @{@"classid":_tid , @"page":page , @"start_time":_start_time, @"end_time":_end_time, @"id_date_ing":_dateing};
    
    
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager POST:FenLeiUrl parameters:classid progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        NSArray * arr2 = [FenLeiModel objectArrayWithKeyValuesArray:arr];
        
        [_dataSource addObjectsFromArray:arr2];
        

        
        [self.fenTableView reloadData];
        [_fenTableView footerEndRefreshing];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


#pragma mark - 获取当前系统时间
-(void)createTime
{
    _formatter = [[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"yyyy-MM-dd"];
    _dateTime = [_formatter stringFromDate:[NSDate date]];
    NSLog(@"%@",_dateTime);
}

#pragma mark - 通知
-(void)shijian:(NSNotification *)click
{
    shijian = click.object;
    [btn2 setTitle:shijian forState:UIControlStateNormal];
}

-(void)biaoti:(NSNotification *)click
{
    biaoTi = click.object;
    [btn1 setTitle:biaoTi forState:UIControlStateNormal];
}

-(void)onClick1:(NSNotification *)click
{
    _time = click.object;
    if ([_time isEqualToString:@"aa"]) {
        _start_time = _dateTime;
        _end_time = @"";
        _dateing = @"1";
        
    }else if ([_time isEqualToString:@"bb"]) {
        _start_time = @"";
        _end_time = _dateTime;
        _dateing = @"2";
    }else if([_time isEqualToString:@"cc"]) {
        _start_time = @"";
        _end_time = _dateTime;
        _dateing = @"1";
    }
    [menu1 dismiss];
    [self dataRequest];
    [self.fenTableView reloadData];
}


-(void)onClick:(NSNotification *)clcik
{
    _tid = clcik.object;
  //  NSLog(@"%@",_tid);
    [menu dismiss];
    [self dataRequest];
     [self.fenTableView reloadData];
    
    
}


#pragma mark - 创建button
-(void)btnView
{
    view = [[UIView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:view];

    
    btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, view.frame.size.width/2, view.frame.size.height);
    [btn1 setTitle:biaoTi forState:UIControlStateNormal];
    //这是btn1的字体颜色
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置btn1的字体
    btn1.titleLabel.font = [UIFont systemFontOfSize:13];
    //设置btn1的背景颜色
    [btn1 setBackgroundColor:[UIColor clearColor]];
    
    //设置分界线
    [btn1.layer setMasksToBounds:YES];
    
   
    CGFloat _btn2X = CGRectGetMaxX( btn1.frame) ;
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(_btn2X, 0, view.frame.size.width/2, view.frame.size.height);
    [btn2 setTitle:shijian forState:UIControlStateNormal];
    //设置btn2的背景颜色
    [btn2 setBackgroundColor:[UIColor clearColor]];
    //设置btn2的字体
    btn2.titleLabel.font = [UIFont systemFontOfSize:13];
    //设置btn2的字体颜色
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    
    UILabel * labelLine = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2, 0, 1, self.view.frame.size.height)];
    [labelLine setBackgroundColor:[UIColor blackColor]];
    [view addSubview:labelLine];
    
    //添加btn的点击事件
    [btn1 addTarget:self action:@selector(dowBtn1) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(dowBtn2) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn1];
    [view addSubview:btn2];
}
-(void)dowBtn1
{
    menu = [DropdowMenu menu];
    
    ALLTableViewController * allVIew = [[ALLTableViewController alloc]init];
    allVIew.view.width = self.view.width/2-19;
    allVIew.view.height =self.view.height- self.view.height/3;
     menu.contentController = allVIew;
       [menu showFrom:btn1];
}
-(void)dowBtn2
{
    menu1 = [DropdowMenu menu];
    
    BLLTableViewController * bllview = [[BLLTableViewController alloc]init];
    bllview.view.width = self.view.width/2-19;
    
    //根据设备不同判断显示长度
    if (self.view.height == 568) {
        bllview.view.height = self.view.height - self.view.height/4 - 300;
    }else if(self.view.height == 736)  {
        bllview.view.height = self.view.height - self.view.height/4 - 420;
    }else if (self.view.height == 667) {
        bllview.view.height = self.view.height - self.view.height/4 - 380;
    }
    NSLog(@"当前屏幕宽度: %f",self.view.height);
    menu1.contentController = bllview;
    [menu1 showFrom:btn2];
    
}


#pragma mark - 创建tableView
-(void)createTableView
{
     CGFloat _fenTableViewY = CGRectGetMaxY( view.frame) ;
    _fenTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _fenTableViewY, KWidth, KHeight-150
                                                                 )];
//    _fenTableView.backgroundColor = [UIColor blueColor];
    
    _fenTableView.delegate = self;
    _fenTableView.dataSource = self;
    
    [self.view addSubview:_fenTableView];
    
    
}


#pragma mark - 数据请求
-(void)dataRequest
{
    //@"classid":@"",@"page":@"0",@"start_time":@"",@"end_time":@"",@"id_date_ing":@""
    NSString * page = [NSString stringWithFormat:@"%d",_page];
    
    NSDictionary * classid = @{@"classid":_tid , @"page":page , @"start_time":_start_time, @"end_time":_end_time, @"id_date_ing":_dateing};
    
    
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [_manager POST:FenLeiUrl parameters:classid progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
 //       NSLog(@"%@",responseObject);
        [_dataSource  removeAllObjects];
        
        
       
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
 //       NSArray * resour = [FenLeiModel objectArrayWithKeyValuesArray:arr];
        
//        NSLog( @"%@",resour);
        
        NSArray * arr2 = [FenLeiModel objectArrayWithKeyValuesArray:arr];
        
        [_dataSource addObjectsFromArray:arr2];
        if(arr == nil){
            HHAlertView *alertview = [[HHAlertView alloc] initWithTitle:@"" detailText:@"没有这类活动哦~\n请选取其他选项!" cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alertview.mode = HHAlertViewModeWarning;
            [alertview setEnterMode:HHAlertEnterModeBottom];
            [alertview setDelegate:self];
            [alertview show];
        }

//        NSLog(@"%@",arr);
        [self.fenTableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
}

#pragma mark - TableView的代理方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UINib * nib = [UINib nibWithNibName:@"FenLeiTableViewCell" bundle:[NSBundle mainBundle]];
    
    FenLeiTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:iden];
    if (cell == nil) {
//        cell = [[FenLeiTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:iden];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FenLeiTableViewCell" owner:self options:nil]lastObject];
    }
    FenLeiModel  * model = (FenLeiModel *)[_dataSource objectAtIndex:indexPath.row];
    
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 10, 10);
    
    [cell loadViewsWithModel:model];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 140;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaseWebViewController * bv = [[BaseWebViewController alloc]init];
    bv.CURL =[_dataSource [indexPath.row] url];
    [self.navigationController pushViewController:bv animated:YES];
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
