//
//  ShouYeViewController.m
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/2/24.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "ShouYeViewController.h"
#import "URL.h"
#import "ShouYeModel.h"

#import "ShouYeCollectionViewCell.h"
#import "JSONModel.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "BaseWebViewController.h"
#import "CollectionReusableView.h"

#import "HeaderView.h"
#import "KSGuideManager.h"


#define KscreenSize  ([UIScreen mainScreen].bounds.size)

#define KscreenWidth  (KscreenSize.width)

#define KscreenHeight  (KscreenSize.height)


@interface ShouYeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,NSURLConnectionDelegate,UICollectionViewDelegateFlowLayout>
{
    NSString * URL;
    UILabel * Scrolllabe;
    UIImageView * imageView;
    NSMutableArray * lunData;
    NSString * dianjiURL;
}
@property (nonatomic,strong)NSMutableArray * dataSource;

@property (nonatomic,strong)AFHTTPSessionManager * manager;

@property (nonatomic,strong)AFHTTPSessionManager * scrollManager;

@property (nonatomic,strong)NSMutableArray * gunSource;

@property (nonatomic,strong)UICollectionView * collectionView;

@property (nonatomic,strong)UICollectionReusableView * headView;

@property (nonatomic,assign)int page1;



//@property (nonatomic,strong) UILabel * title;

@property (nonatomic,strong) UIScrollView *imgView;

@property (nonatomic,strong) UILabel *titles;

@property (nonatomic,strong) UIPageControl *page;


@end

@implementation ShouYeViewController

static NSString * CellIdentifier = @"cell";
//头轮播
static NSString *kheaderIdentifier = @"headerIdentifier";

#pragma mark - 懒加载
//懒加载.如果没有则创建
-(AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    

    
     _dataSource = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor clearColor];
    _page = 0;
    [self createCollectionView];
    [self creataNet];
    [self setupRefresh];
    [self.collectionView registerClass:[CollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    lunData = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dianji:) name:@"dianji" object:nil];
    
//    [self creatScroll];
//    [self createData];
//    
}

-(void)dianji:(NSNotification *)click
{
    dianjiURL = click.object;
    BaseWebViewController * bv= [[BaseWebViewController alloc]init];
    NSURL * url = [NSURL URLWithString:dianjiURL];
    bv.CURL = url;
    [self.navigationController pushViewController:bv animated:YES];
}

#pragma mark - 上拉刷新下拉加载
//开始刷新自定义方法
- (void)setupRefresh
{
    //下拉刷新
    [_collectionView addHeaderWithTarget:self action:@selector(headerRereshing)];
//    [_collectionView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [_collectionView addFooterWithTarget:self action:@selector(footerRereshing)];
    //一些设置
    // 设置文字
    _collectionView.headerPullToRefreshText = @"下拉可以刷新了";
    _collectionView.headerReleaseToRefreshText = @"松开马上刷新了";
    _collectionView.headerRefreshingText = @"刷新中。。。";
    
    _collectionView.footerPullToRefreshText = @"上拉可以加载更多数据了";
    _collectionView.footerReleaseToRefreshText = @"松开马上加载更多数据了";
    _collectionView.footerRefreshingText = @"加载中。。。";
}

//下拉刷新
- (void)headerRereshing
{
    _page1 = 0;
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:ShouYeUrl parameters:self progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        [_dataSource removeAllObjects];
        NSArray * resour = [ShouYeModel objectArrayWithKeyValuesArray:arr];
        [_dataSource addObjectsFromArray:resour];

        [_collectionView reloadData];
        
        NSLog(@"刷新完成");
        
        //结束加载
        [_collectionView headerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

//上拉加载
- (void)footerRereshing
{
    //page改变时加载更多数据
    _page1 ++;

    NSString * requestAddress = [NSString stringWithFormat:ShouYeUrl];
//    
    AFHTTPSessionManager * manager1 = [AFHTTPSessionManager manager];
    manager1.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString * paga = [NSString stringWithFormat:@"%d",_page1];
    NSDictionary * dic = @{@"page":paga};
    
    [manager1 POST:requestAddress parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray * resour = [ShouYeModel objectArrayWithKeyValuesArray:arr];
        [_dataSource addObjectsFromArray:resour];
        
//        NSLog(@"!!!!!!!%@",_dataSource);

        
        
        
        [_collectionView reloadData];
        
        [_collectionView footerEndRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
    }];

}

#pragma mark - 头视图
//组的头视图创建
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
   CollectionReusableView  * headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kheaderIdentifier forIndexPath:indexPath];

    
    return headView;

}

#pragma mark - 设置头视图



#pragma mark - 建立collectionView
-(void)createCollectionView
{
    //创建
    UICollectionViewFlowLayout * layOut = [[UICollectionViewFlowLayout alloc]init];
    
    //设置头视图大小
    layOut.headerReferenceSize = CGSizeMake(KWidth, KWidth);
    
    //设置collectionView的滚动方向
    [layOut setScrollDirection:UICollectionViewScrollDirectionVertical];
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHeight-49) collectionViewLayout:layOut];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView setBackgroundColor:[UIColor clearColor]];
    
    //注册cell
    [self.collectionView registerClass:[ShouYeCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kheaderIdentifier];
    [self.view addSubview:self.collectionView];

}

#pragma mark - CollectionView的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
//        NSLog(@"-------/n%lu",(unsigned long)_dataSource.count);
    return _dataSource.count;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}


-(UICollectionViewCell * ) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UINib *nib = [UINib nibWithNibName:@"ShouYeCollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:CellIdentifier];
    ShouYeCollectionViewCell *cell = [[ShouYeCollectionViewCell alloc]init];
    
    // Set up the reuse identifier
    cell = [collectionView dequeueReusableCellWithReuseIdentifier: CellIdentifier
                                                     forIndexPath:indexPath];
    
 

 if (!cell) {
     cell.logo.image = nil;
        cell = [[[NSBundle mainBundle]loadNibNamed:@"ShouYeCollectionViewCell" owner:self options:nil]lastObject];
    }
 
    ShouYeModel  * model = (ShouYeModel *)[_dataSource objectAtIndex:indexPath.row];
    
    URL = model.url;
    
    [cell loadViewsWithModel:model];
  
    return cell;
}

#pragma mark - FlowDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
        return CGSizeMake(([UIScreen mainScreen].bounds.size.width-30)/3, 225);
    
}

//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (KWidth == 414) {
        return UIEdgeInsetsMake(0, 18, 10, 5);
    }else if (KWidth == 375){
        return UIEdgeInsetsMake(0,5, 5, 5);

    }else{
        return UIEdgeInsetsMake(0,5, 5, 5);
    }
}

//定义每个UICollectionView 纵向的间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

//UICollectionView被选中时调用的方法
#pragma mark 网格的 点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[_dataSource [indexPath.row] url]);
    BaseWebViewController * bv = [[BaseWebViewController alloc]init];
    bv.CURL =[_dataSource [indexPath.row] url];
    [self.navigationController pushViewController:bv animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
#pragma mark - 网络数据请求
-(void)creataNet
{
    //collectionView的滚动视图
    _manager = [AFHTTPSessionManager manager];
    _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [_manager POST:ShouYeUrl parameters:self progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray * arr = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        NSArray * resour = [ShouYeModel objectArrayWithKeyValuesArray:arr];
         [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:resour];
        // NSLog(@"!!!!!!!%@",_dataSource);
        [_collectionView reloadData];
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"-----%@----",error);
    }];
}

@end
