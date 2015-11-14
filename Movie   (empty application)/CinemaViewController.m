//
//  CinemaViewController.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//


#import "CinemaViewController.h"
#import "WXNetworkService.h"
#import "CinemaModel.h"
#import "CinemaCell.h"
#import "common.h"
#import "MJExtension.h"
#import "CommentViewController.h"
#import "MainViewController.h"

@interface CinemaViewController ()

- (void)requestData;

- (void)refreshUI;

@end
@implementation CinemaViewController

#pragma mark - ViewController Life
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    
    self.view = view;
    
    // 初始化表视图
    _cinemaTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49) style:UITableViewStylePlain];
    _cinemaTableView.dataSource = self;
    _cinemaTableView.delegate = self;
    _cinemaTableView.hidden = YES;
    _cinemaTableView.rowHeight = 100;
    _cinemaTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    [self.view addSubview:_cinemaTableView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"影院";
    // 请求“网络”数据
    self.view.backgroundColor=[UIColor grayColor];
    [self performSelector:@selector(requestData) withObject:nil afterDelay:0];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
    
}


#pragma mark - Private Method
- (void)requestData
{
    NSArray *data = [WXNetworkService cinemaData];
    
    _cinemaArray=[NSArray array];
    _cinemaArray=[CinemaModel modelArrayWithDictArray:data];
    
    [self refreshUI];
}

- (void)refreshUI
{
    _cinemaTableView.hidden = NO;
    
    [_cinemaTableView reloadData];
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_cinemaArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义静态标识符
    static NSString *cellIdentifier = @"cell";
    
    // 检查表视图中是否存在闲置的单元格
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[CinemaCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.cinemaModel = _cinemaArray[indexPath.row];
    cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    return cell;
}

#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentViewController *commentVC = [[CommentViewController alloc] init];
    [self.navigationController pushViewController:commentVC animated:YES];
    
//    MainViewController *mainVC = (MainViewController *)self.tabBarController;
//    [mainVC showOrHiddenTabBarView:YES];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_cinemaTableView deselectRowAtIndexPath:[_cinemaTableView indexPathForSelectedRow] animated:YES];
}

@end
