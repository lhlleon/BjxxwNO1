//
//  HuoDongViewController.m
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/2/24.
//  Copyright © 2016年 Leon. All rights reserved.
//



#import "HuoDongViewController.h"

#import "BaseWebViewController.h"



@interface HuoDongViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    UICollectionView * imageCollection;
    UICollectionViewCell * cell;
}

@property (nonatomic,strong) NSArray * imageTu;

@property (nonatomic,strong) NSArray * dataSource;

@end

@implementation HuoDongViewController

static NSString * Identifier = @"cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    //创建数据源
    _imageTu = @[@"qbhd",@"yszl",@"dyhd",@"xjqy",@"whsl",@"yyyc",@"yysj",@"ydjs",@"chwl",@"szhy",@"pdyd",@"zjzp",@"hwly",@"jyqz",@"gyhb",@"zmqt",@"sshd",@"fcjj",@"qchd",@"sqhd",@"schd"];
    
    //创建网址数据
    _dataSource = @[@"http://www.bjxxw.com/index.php?c=thread&fid=67",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=279",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=134",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=274",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=275",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=135",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=276",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=277",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=137",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=138",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=140",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=281",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=139",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=280",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=136",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=278",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=306",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=307",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=308",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=309",@"http://www.bjxxw.com/index.php?c=thread&fid=67&type=311"];

    [self createButton];
    // Do any additional setup after loading the view.
}


-(void)createButton
{
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    
    imageCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width, self.view.frame.size.height - 60) collectionViewLayout:flowLayout];
    NSLog(@"当前屏幕高度  ===   %f",self.view.frame.size.width);
    imageCollection.delegate = self;
    imageCollection.dataSource = self;
    imageCollection.showsVerticalScrollIndicator = NO;
    [imageCollection setBackgroundColor:[UIColor clearColor]]
    ;
    [imageCollection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:Identifier];
    [self.view addSubview:imageCollection];
   
}

#pragma mark - collection代理设置

//cell的个数

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageTu.count;
}

//section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:Identifier forIndexPath:indexPath];
    NSLog(@"%lu",(unsigned long)_imageTu.count);
    for (int i = 0; i <21; i ++) {
        if (indexPath.row == i) {
            UIImageView * image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:_imageTu[i]]];
            //设置背景显示的图片圆角
            image.layer.cornerRadius = 20;
            image.layer.masksToBounds = YES;
            [cell setBackgroundView:image];
        }
    }
    return cell;
    
}

#pragma mark - UICollectionViewDelegate

//定义每个UICollection的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width/3- 10, self.view.frame.size.width/3 - 25);
}

//定义每个collectionview的范围
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

//UICollectionView被选中时调用的方法
#pragma mark 网格的 点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",_dataSource[indexPath.row]);
    BaseWebViewController * bv = [[BaseWebViewController alloc]init];
    bv.CURL =_dataSource[indexPath.row];
    [self.navigationController pushViewController:bv animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
    
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
