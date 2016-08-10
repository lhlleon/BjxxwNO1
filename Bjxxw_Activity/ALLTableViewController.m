//
//  ALLTableViewController.m
//  Bjxxw_Activity
//
//  Created by freedom on 16/3/10.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "ALLTableViewController.h"
#import "DropdowMenu.h"
@interface ALLTableViewController ()
{
     NSMutableArray * dataSource;
}

@property (nonatomic,strong) NSString * Cid;

@property (nonatomic,strong) NSString * BiaoTi;

@end

@implementation ALLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    dataSource = [[NSMutableArray alloc]init];
    NSArray * data = @[@"电影活动",@"音乐/演出活动",@"戏曲/曲艺活动",@"艺术展览活动",@"文化沙龙活动",@"游园/市集活动",@"吃喝/玩乐活动",@"派对/夜店活动",@"运动/健身活动",@"户外/旅游活动",@"公益环保活动",@"商展/会议活动",@"招募/其他活动",@"教育/亲子活动",@"社区活动",@"汽车活动",@"房产家居",@"赛事活动",@"商场活动"];
    [dataSource addObjectsFromArray:data];
    self.tableView.separatorStyle = NO;
    
    //隐藏右侧滑动框
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //tableView表示的是与用户交互的表格视图
    //section 表示区号 区号的下标值从0开始
    return [dataSource count];
}
//设置单元格中显示的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //<1>设置重用单元格的标识
    static NSString * identifier = @"hello";
    //<2>从队列中获取用字符串标识的单元格
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //<3>判断可重用单元格是否存在
    if(cell == nil)
    {
        //<4>创建单元格对象
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        //创建带有副标题的单元格
    }
   
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text=[dataSource objectAtIndex:indexPath.row];
    if(self.view.frame.size.width == 568){
    [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];

    
    //为了适配后台数据.改变cell的indexpath.row的数字
    if (indexPath.row ==0 ) {
        
        _Cid = [NSString stringWithFormat:@"%ld", indexPath.row +1] ;
    }else
    {
        _Cid =[NSString stringWithFormat:@"%ld", indexPath.row +3] ;
    }
//    NSLog(@"%@",_Cid);
    
    
    _BiaoTi = cell.textLabel.text;
//    NSLog(@"%@",_BiaoTi);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CityID" object:_Cid];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"biaoti" object:_BiaoTi];
    
       [self.view removeFromSuperview];
    
}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
