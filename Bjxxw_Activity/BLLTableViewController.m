//
//  BLLTableViewController.m
//  Bjxxw_Activity
//
//  Created by hanlunlee on 16/3/15.
//  Copyright © 2016年 Leon. All rights reserved.
//

#import "BLLTableViewController.h"

@interface BLLTableViewController ()
{
    NSMutableArray * dataSource;
    NSString * str;
    NSString * shiJian;
}


@end

@implementation BLLTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    dataSource = [[NSMutableArray alloc]init];
    NSArray * data = @[@"即将开始",@"正在进行",@"历史活动"];
    [dataSource addObjectsFromArray:data];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.bounces = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //tableView表示的是与用户交互的表格视图
    //section 表示区号 区号的下标值从0开始
    return 3;
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

    if(self.view.frame.size.width == 568){
        [cell.textLabel setFont:[UIFont systemFontOfSize:14]];
    }

    cell.textLabel.text=[dataSource objectAtIndex:indexPath.row];
//    cell.separatorStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        str = @"aa";
    }
    if (indexPath.row == 1) {
        str = @"bb";
    }
    if (indexPath.row == 2) {
        str = @"cc";
    }
    UITableViewCell * cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    shiJian = cell.textLabel.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ClassB" object:str];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"shijian" object:shiJian];
    
    
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
