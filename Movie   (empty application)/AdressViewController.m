//
//  AdressViewController.m
//  Movie   (empty application)
//
//  Created by scsys on 15/10/28.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "AdressViewController.h"
#define kPosterItemTag 101
#define kListItemTag   102
#import "common.h"
#import "WXNetworkService.h"
#import "MovieModel.h"
#import "MJExtension.h"
#import "USACell.h"
#import "ItemView.h"
#import "WXAnation.h"
#import "CinemaViewController.h"
#import "MainViewController.h"

@interface AdressViewController ()


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

@implementation AdressViewController

#pragma mark - ViewController Life
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
    view.backgroundColor = [UIColor blackColor];
    
  
    
    // 加载海报视图
    [self loadPosterView];
    // 加载表视图
    [self loadListView];
    
    // 添加NavigationItem
    [self loadNavigationItem];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"影院";
    
        [self performSelector:@selector(requestData) withObject:nil afterDelay:0];
    
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
    _poserView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49)];
    [self loadmap];
    [_poserView addSubview:self.mapView];
    [self.view addSubview:_poserView];
}// 加载海报视图
-(void)loadmap
{
    self.mapView=[[MKMapView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-20-44-49)];
    self.mapView.showsUserLocation = YES;
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    //坐标,这是地图初始化的时候显示的坐标
    CLLocationCoordinate2D coord = {39.904299,116.22169};
    //显示的返回，数值越大，范围就越大  数值越小范围就越小但详细
    MKCoordinateSpan span = {0.1,0.1};//10,10
    
    MKCoordinateRegion region = {coord,span};
    //地图初始化的时候显示的区域
    [self.mapView setRegion:region];
    //创建anation对象
    CLLocationCoordinate2D showCoord = {39.904299,116.22169};
    WXAnation *anation1 = [[WXAnation alloc] initWithCoordinate2D:showCoord];
    anation1.title = @"万达电影院";
    anation1.subtitle = @"小标题";
    //创建anation对象
    CLLocationCoordinate2D showCoord2 = {39.914299,116.25169};
    WXAnation *anation2 = [[WXAnation alloc] initWithCoordinate2D:showCoord2];
    anation2.title = @"万达电影院2";
    anation2.subtitle = @"小标题2";
    CLLocationCoordinate2D showCoord3 = {39.924299,116.20169};
    WXAnation *anation3 = [[WXAnation alloc] initWithCoordinate2D:showCoord3];
    anation3.title = @"万达电影院3";
    anation3.subtitle = @"小标题3";
    
    [self.mapView addAnnotation:anation1];
    [self.mapView addAnnotation:anation2];
    [self.mapView addAnnotation:anation3];

}
- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation {
    
    
    //判断是否为当前设备位置的annotation
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        //返回nil，就使用默认的标注视图
        return nil;
    } static NSString *identifier = @"Annotation";
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        
        //MKPinAnnotationView 是大头针视图
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        
        //设置是否显示标题视图
        annotationView.canShowCallout = YES;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
        
        //标题右边视图
        annotationView.rightCalloutAccessoryView = button;
        //标题左边视图
        //        annotationView.leftCalloutAccessoryView
    }
    
    
    annotationView.annotation = annotation;
    //设置大头针的颜色
    annotationView.pinColor = MKPinAnnotationColorRed;
    //从天上落下的动画
    annotationView.animatesDrop = YES;
    
    return annotationView;
    
    
    
}
- (void)buttonAction {
    CinemaViewController *commentVC = [[CinemaViewController alloc] init];
    [self.navigationController pushViewController:commentVC animated:YES];
}
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
    
    NSArray *result = [WXNetworkService northUSBData];
    
    //为了满足第三方框架方法，将数组定义为不可变数组
    _subjectsArray = [[NSArray alloc] init];
    
   
    _subjectsArray=[MovieModel modelArrayWithDictArray:result];
    
    [self refreshUI];
    
    
}// 请求数据


- (void)refreshUI
{
    [_listView reloadData];
 
    
}// 刷新UI

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 定义静态标识符
    static NSString *cellIdentifier = @"cell";
    
  
    
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
#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CinemaViewController *commentVC = [[CinemaViewController alloc] init];
    [self.navigationController pushViewController:commentVC animated:YES];

}
@end
