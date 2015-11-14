//
//  USAViewController.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#define kPosterItemTag 101
#define kListItemTag   102

#import "USAViewController.h"
#import "common.h"
#import "WXNetworkService.h"
#import "MovieModel.h"
#import "MJExtension.h"
#import "USACell.h"
#import "PosterView.h"
#import "ItemView.h"

@interface USAViewController ()


// 加载表视图
- (void)loadListView;

// 加载海报视图
- (void)loadPosterView;

// 添加NavigationItem
- (void)loadNavigationItem;

// 过渡动画效果
- (void)animationBaseView:(UIView *)baseView flag:(BOOL)flag;

// 请求首页数据
- (void)requestData;

// 刷新UI
- (void)refreshUI;




@end

@implementation USAViewController

#pragma mark - ViewController Life
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
    view.backgroundColor = [UIColor blackColor];
    
    // 加载表视图
    [self loadListView];
    
    // 加载海报视图
    [self loadPosterView];
    
    // 添加NavigationItem
    [self loadNavigationItem];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"北美榜";
    
    
//    id result = [WXNetworkService testData];
//    NSLog(@"result title:%@",result[@"titleCn"]);
//    NSLog(@"result type:%@",result[@"type"][2]);
//    NSLog(@"result release:%@",result [@"release"][@"location"]);
    
    
//    id result = [WXNetworkService northUSAData];
//    NSLog(@"result subjects:%@",result);
//    NSLog(@"result subjects:%@",[result objectAtIndex:0]);
//    NSLog(@"result box:%@",[[result objectAtIndex:0] objectForKey:@"box"]);
//    NSLog(@"result title:%@",[[[result objectAtIndex:0] objectForKey:@"subject"] objectForKey:@"title"]);

    //模拟网络延迟效果，所以等待一秒
     [self performSelector:@selector(requestData) withObject:nil afterDelay:1];

}



#pragma mark - Private Method
- (void)loadListView
{    //状态栏20 导航栏44 tabar49
    _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49) style:UITableViewStylePlain];
    
    //pattern平铺  colorWithPatternImage从图中抓取颜色进行平铺
    _listView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
    _listView.indicatorStyle = UIScrollViewIndicatorStyleWhite;// 默认黑色风格
    _listView.dataSource = self;
    _listView.delegate   = self;

    
    
    [self.view addSubview:_listView];
}// 加载表视图

- (void)loadPosterView
{
    _poserView = [[PosterView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49)];
    //_poserView.backgroundColor=[UIColor purpleColor];
    [self.view addSubview:_poserView];
}// 加载海报视图

- (void)loadNavigationItem
{
    // 初始化基视图
    UIImageView *itemBaseView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 25)];
    itemBaseView.userInteractionEnabled = YES;
    itemBaseView.image = [UIImage imageNamed:@"exchange_bg_home"];
    // 给基视图添加单击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeBrowseMode)];
    [itemBaseView addGestureRecognizer:tap];
    
    // 添加子视图，海报logo
    UIImageView *posterItem = [[UIImageView alloc] initWithFrame:CGRectMake(itemBaseView.width/2-22.0/2, itemBaseView.height/2-15/2.0, 23, 14)];
    posterItem.tag = kPosterItemTag;
    
    posterItem.hidden = YES;
    
    posterItem.image = [UIImage imageNamed:@"poster_home"];
    // 添加子视图，列表logo
    UIImageView *listItem = [[UIImageView alloc] initWithFrame:CGRectMake(itemBaseView.width/2-23.0/2, itemBaseView.height/2-7, 23, 14)];
    listItem.image = [UIImage imageNamed:@"list_home"];
    listItem.tag = kListItemTag;
    // 添加子视图
    [itemBaseView addSubview:posterItem];
    [itemBaseView addSubview:listItem];
    
    // 添加rightItem
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:itemBaseView];
    
    self.navigationItem.rightBarButtonItem = rightItem ;
}// 添加NavigationItem



- (void)animationBaseView:(UIView *)baseView flag:(BOOL)flag
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    
    [baseView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    [UIView setAnimationTransition:flag ? UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight forView:baseView cache:YES];
    
    [UIView commitAnimations];
}// 翻转过渡动画效果

#pragma mark - Actions Method
- (void)changeBrowseMode
{
    // 获得itembaseView
    UIView *baseItemView = [self.navigationItem.rightBarButtonItem customView];
    UIView *posterItem = [baseItemView viewWithTag:kPosterItemTag];
    UIView *listItem   = [baseItemView viewWithTag:kListItemTag];
    
    [self animationBaseView:self.view flag:posterItem.hidden];
    [self animationBaseView:baseItemView flag:posterItem.hidden];
    
    if (posterItem.hidden) {
        posterItem.hidden = NO;
        listItem.hidden   = YES;
        
    }
    else {
        posterItem.hidden = YES;
        listItem.hidden   = NO;
    }
}// 改变浏览方式

- (void)requestData
{

    NSArray *result = [WXNetworkService northUSAData];
    
    //为了满足第三方框架方法，将数组定义为不可变数组
    _subjectsArray = [[NSArray alloc] init];
    
//    for (id data in result) {
//        MovieModel *movieModel = [[MovieModel alloc] init];
//        movieModel.box     = [data objectForKey:@"box"];
//        movieModel.subject = [data objectForKey:@"subject"];
//        movieModel.rank    = [data objectForKey:@"rank"];
//        [_subjectsArray addObject:movieModel];
//    }
    
    //第三方框架的方法，可以取代以上的for循环内容
    _subjectsArray=[MovieModel modelArrayWithDictArray:result];
    
    [self refreshUI];

    
}// 请求数据


- (void)refreshUI
{
    [_listView reloadData];
    [_poserView reloadPosterData:_subjectsArray];

}// 刷新UI

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_subjectsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义静态标识符
    static NSString *cellIdentifier = @"cell";
    
//    // 检查表视图中是否存在闲置的单元格
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    
//    if (cell == nil) {
//        
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
//    
//    cell.textLabel.textColor=[UIColor whiteColor];
//    cell.textLabel.text = @"test";
    
    //自定义的格
    USACell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[USACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.movieModel = _subjectsArray[indexPath.row];

    
    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
       return cell;
}

#pragma mark - TableView Delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

@end
