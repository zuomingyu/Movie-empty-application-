//
//  NewsViewController.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "ItemView.h"
#import "common.h"
#import "UIImageView+WebCache.h"
#import "WXNetworkService.h"
#import "MJExtension.h"
#import "AblumViewController.h"
#import    "MainViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "WebViewController.h"
#import "AFNetworking.h"

#define kHeaderLabelHeight 30
#define kRowHeight 60

@interface NewsViewController ()<UIScrollViewDelegate>

- (void)requestData;

- (void)refreshUI;

- (void)initHeaderView;

@end


@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
     self.title = @"新闻";
    // 请求“网络”数据
    [self performSelector:@selector(requestData) withObject:nil afterDelay:1];
}

#pragma mark - ViewController Life
- (void)loadView
{
//    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
//    self.view = view;
//    
//    // 初始化表视图
//    _newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49) style:UITableViewStylePlain];
//    _newsTableView.rowHeight = kRowHeight;
//    _newsTableView.dataSource = self;
//    _newsTableView.delegate = self;
//    _newsTableView.hidden = YES;
//    [self.view addSubview:_newsTableView];

    
    [super loadView];
    
    // 初始化表视图
    _newsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49) style:UITableViewStylePlain];
    _newsTableView.rowHeight = kRowHeight;
    _newsTableView.dataSource = self;
    _newsTableView.delegate = self;
    _newsTableView.hidden = YES;
    [self.view addSubview:_newsTableView];
}

#pragma mark - Private Mehtod
- (void)requestData
{
//    NSArray *data = [WXNetworkService newsData];
//
//    //使用了第三方框架
//    _newsArray=[[NSArray alloc]init];
//    _newsArray=[NewsModel modelArrayWithDictArray:data];
    
    
    //从本地服务器调用数据
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    [manager GET:@"http://localhost/news_list.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSArray *data =responseObject;
        
        //使用了第三方框架
        _newsArray=[[NSArray alloc]init];
        _newsArray=[NewsModel modelArrayWithDictArray:data];
        
        [self refreshUI];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];

    
    

   
}

- (void)refreshUI
{
    [self initHeaderView];
    
    [_newsTableView reloadData];
    
    _newsTableView.hidden = NO;
    _newsTableView.backgroundColor=[UIColor blackColor];
}



- (void)initHeaderView
{
//    // 初始化表视图的头部视图
//    ItemView *headerView = [[ItemView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 166)];
//    // 设置子视图的属性
//    headerView.item.frame = CGRectMake(0, 0, headerView.width, headerView.height);
//    headerView.title.frame = CGRectMake(0, headerView.height-kHeaderLabelHeight, headerView.width, kHeaderLabelHeight);
//    headerView.title.font = [UIFont boldSystemFontOfSize:16];
//    headerView.title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
//    // 添加到表视图
//    _newsTableView.tableHeaderView = headerView;
//    // 赋值
//    NewsModel *newsModel = _newsArray[0];
//    headerView.title.text = newsModel.title;
//    [headerView.item setImageWithURL:[NSURL URLWithString:newsModel.image]];
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 166)];
    _newsTableView.tableHeaderView = view;
    
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 166)];
    scrollView.tag=900;
    [view addSubview:scrollView];
    
    UIPageControl *pageControl=[[UIPageControl alloc]initWithFrame:CGRectMake(140, 150, 106, 16)];
    pageControl.tag=901;
    [view addSubview:pageControl];
    
    
    
    CGFloat imageW = scrollView
    .frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    CGFloat imageY = 0;
    
    for (int i = 0; i<5; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        
        // 设置frame
        CGFloat imageX = i * imageW;
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        
        // 设置图片
        NSString *name = [NSString stringWithFormat:@"img_0%d", i + 1];
        imageView.image = [UIImage imageNamed:name];
        
        [scrollView
         addSubview:imageView];
    }
    
    // 2.设置内容尺寸
    CGFloat contentW = 5 * imageW;
    scrollView.contentSize = CGSizeMake(contentW, 0);
    
    // 3.隐藏水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    
    // 4.分页
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    
    // 5.设置pageControl的总页数
    pageControl.numberOfPages = 5;
    
    // 6.添加定时器(每隔2秒调用一次self 的nextImage方法)
    NSTimer *time=[[NSTimer alloc]init];
    time = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
 
    
}
- (void)nextImage

{
    UIPageControl *pageControl = (UIPageControl *)[_newsTableView.tableHeaderView viewWithTag:901];
     UIScrollView *scrollView = (UIScrollView *)[_newsTableView.tableHeaderView viewWithTag:900];
        // 1.增加pageControl的页码
    int page = 0;
    if (pageControl.currentPage == 5 - 1) {
        page = 0;
    } else {
        page = pageControl.currentPage + 1;
    }
    
    pageControl.currentPage =  page;
    
    // 2.计算scrollView滚动的位置
    CGFloat offsetX = page * scrollView.frame.size.width;
    CGPoint offset = CGPointMake(offsetX, 0);
    [scrollView setContentOffset:offset animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 根据scrollView的滚动位置决定pageControl显示第几页
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (scrollView.contentOffset.x + scrollW * 0.5) / scrollW;
    UIPageControl *pageControl = (UIPageControl *)[_newsTableView.tableHeaderView viewWithTag:901];
    pageControl.currentPage = page;
}








#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //第一个元素作为表头了
    return [_newsArray count]-1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义静态标识符
    static NSString *cellIdentifier = @"cell";
    
    // 检查表视图中是否存在闲置的单元格
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        
        // 图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 50, 50)];
        imgView.tag = 2013;
        [cell.contentView addSubview:imgView];
        
        // 主标题
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+5, imgView.top, 240, 25)];
        title.font = [UIFont boldSystemFontOfSize:16];
        title.tag = 2014;
        [cell.contentView addSubview:title];
        
        // 副标题
        UILabel *detail = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+5, title.bottom, 220, 25)];
        detail.font = [UIFont systemFontOfSize:14];
        detail.textColor = [UIColor lightGrayColor];
        detail.tag = 2015;
        [cell.contentView addSubview:detail];
        
        // 类型logo
        UIImageView *type = [[UIImageView alloc] initWithFrame:CGRectMake(imgView.right+5, title.bottom+5, 16, 14)];
        type.tag = 2016;
        type.hidden = YES;
        [cell.contentView addSubview:type];
        
        // 设置辅助图标
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    // 取出数据
    NewsModel *newsModel = _newsArray[indexPath.row+1];
    
    // 取出子视图
    UILabel *title  = (UILabel *)[cell.contentView viewWithTag:2014];
    UILabel *detail = (UILabel *)[cell.contentView viewWithTag:2015];
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:2013];
    UIImageView *typeView = (UIImageView *)[cell.contentView viewWithTag:2016];
    
    title.text = newsModel.title;
    detail.text = newsModel.summary;
    [imgView setImageWithURL:[NSURL URLWithString:newsModel.image]];
    
    int type = [newsModel.type intValue];
    if (type == kWordType) {
        
        typeView.hidden = YES;
        detail.left = imgView.right+5;
        
    }else if (type == kImageType) {
        
        typeView.hidden = NO;
        typeView.image = [UIImage imageNamed:@"sctpxw"];
        detail.left = typeView.right+5;
        
    }else {
        typeView.hidden = NO;
        typeView.image = [UIImage imageNamed:@"scspxw"];
        detail.left = typeView.right+5;
    }
    
    return cell;
}


#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsModel *newsModel = _newsArray[indexPath.row+1];
    
    if ([newsModel.type intValue] == kWordType)
    {//文本
        
//        UIViewController *view=[[UIViewController alloc]init];
//        
//        [self.navigationController pushViewController:view animated:YES];
//        
//        UIView *v=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
//        [view setView:v];
//        
//        UIWebView *myWebView=[[UIWebView alloc]init];
//        myWebView.frame=v.frame;
//        [v addSubview:myWebView];
//        
//        //NSURL表示一个网址对象 myTextField.text表示将文本框中的内容作为一个网址的参数
//        NSURL * url = [NSURL URLWithString:@"http://www.baidu.com"];
//        //基于NSURL对象来构建一个NSURLRequest对象
//        NSURLRequest * request = [NSURLRequest requestWithURL:url];
//        //通过调用 UIWebView的方法loadRequest发出请求
//        //请求完成就会回调webViewDidFinishLoad方法
//        [myWebView loadRequest:request];
                
        
        
        
        //利用webViewcontroller
        NewsModel *newsModel=_newsArray[indexPath.row+1];
        if ([newsModel.type intValue]==kWordType) {
            WebViewController *web=[[WebViewController alloc] init];
            [self.navigationController pushViewController:web animated:YES];
            MainViewController *main=[[MainViewController alloc] init];
            [main showOrHiddenTabBarView:YES];
    }
    else if ([newsModel.type intValue] == kImageType) {//图片
        
        AblumViewController *ablumVC = [[AblumViewController alloc] init];
        [self.navigationController pushViewController:ablumVC animated:YES];
        
        MainViewController *mainVC = (MainViewController *)self.tabBarController;
        [mainVC showOrHiddenTabBarView:YES];
        
    }
    else {//视频
        NSString *urlstring=@"http://vf1.mtime.cn/Video/2012/06/21/mp4/120621112404690593.mp4";
        
        MPMoviePlayerViewController *player=[[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:urlstring]];
        
        [self presentViewController:player animated:YES completion:nil];
        
    }
}
}


@end

