//
//  MainViewController.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "MainViewController.h"
#import "USAViewController.h"
#import "NewsViewController.h"
#import "TopViewController.h"
#import "CinemaViewController.h"
#import "MoreViewController.h"
#import "BaseNavigationController.h"
#import "common.h"
#import "AdressViewController.h"



@interface MainViewController ()
// 装载子视图控制器
- (void)loadViewControllers;

// 自定义tabBar视图
- (void)customTabBarView;

// 改变视图控制
- (void)changeViewController:(NSInteger)index;

// 移除、添加更多页面视图
- (void)addOrRemoveMoreView;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //隐藏导航栏
    self.tabBar.hidden=YES;
    
    // 装载子视图控制器
    [self loadViewControllers];
    
    // 自定义tabBar视图
    [self customTabBarView];
}


#pragma mark - Private Method
- (void)loadViewControllers
{
    /**
     *  @ 1 创建tabBar视图控制器
     *    2 创建tabBarItem->ViewController
     *    3 ViewController作为NavigationController根视图(基栈)
     *    4 NavigationController -> array 将各个导航控制器添加到数组中去
     *    5 通过setViewControllers:animated:
     */
    
    // 北美
    USAViewController *usaViewController = [[USAViewController alloc] init];
    BaseNavigationController *usaNavigation = [[BaseNavigationController alloc] initWithRootViewController:usaViewController];
    
    // 新闻
    NewsViewController *newsViewController = [[NewsViewController alloc] init];
    BaseNavigationController *newsNavigation = [[BaseNavigationController alloc] initWithRootViewController:newsViewController];
    
    
    // Top
    TopViewController *topViewController = [[TopViewController alloc] init];
    BaseNavigationController *topNavigation = [[BaseNavigationController alloc] initWithRootViewController:topViewController];
    
    
    // 影院
    AdressViewController *cinemaViewController = [[AdressViewController alloc] init];
    UINavigationController *cinemaNavigation = [[BaseNavigationController alloc] initWithRootViewController:cinemaViewController];
    
    
    // 更多
    MoreViewController *moreViewController = [[MoreViewController alloc] init];
    BaseNavigationController *moreNavigation = [[BaseNavigationController alloc] initWithRootViewController:moreViewController];
    
    
    // 内存管理的基本原则(没有看到这几个关键字眼时，alloc copy retain，没有拥有对象的所有权)
    NSArray *viewControllers = @[usaNavigation, newsNavigation, topNavigation, cinemaNavigation, moreNavigation];
    
    
    [self setViewControllers:viewControllers animated:YES];
    
}

- (void)customTabBarView
{
    // 自定义tabBar背景视图 tabBar高49
    _tabBarBG = [[UIImageView alloc] initWithFrame:CGRectMake(0, kDeviceHeight-49, kDeviceWidth, 49)];
    _tabBarBG.userInteractionEnabled = YES;
    _tabBarBG.image = [UIImage imageNamed:@"tab_bg_all"];
    [self.view addSubview:_tabBarBG];
    
    // 选中视图  _tabBarBG.height 是调用了 UIViewExt实现
    _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(5, _tabBarBG.height/2.0-45.0/2, 50, 45)];
    _selectView.image = [UIImage imageNamed:@"selectTabbar_bg_all1"];
    [_tabBarBG addSubview:_selectView];
    
    // 整理数据
    NSArray *imgs   = @[@"movie_home", @"msg_new", @"start_top250", @"icon_cinema", @"more_setting"];
    NSArray *titles = @[@"电影", @"新闻", @"top", @"影院", @"更多"];
    
    int x = 0;
    for (int index = 0; index < 5; index++) {
        
        ItemView *itemView = [[ItemView alloc] initWithFrame:CGRectMake(5+x, _tabBarBG.height/2.0-45.0/2, 50, 45)];
        itemView.tag = index;
        
        itemView.delegate = self; // 设置委托
        
        itemView.item.image = [UIImage imageNamed:imgs[index]];
        itemView.title.text = titles[index];
        [_tabBarBG addSubview:itemView];
        
        x += 65;//320-5*50=70  70=5+15*4+5
    }
}



#pragma mark - ItemView Delegate
- (void)didItemView:(ItemView *)itemView atIndex:(NSInteger)index
{
//    [UIView beginAnimations:nil context:NULL];
//    
//    _selectView.frame = CGRectMake(5 + 65 * index, _tabBarBG.height/2-45.0/2, 50, 45);
//    
//    [UIView commitAnimations];
//    
//    self.selectedIndex = index;
    
    [self changeViewController:index];
}




- (void)addOrRemoveMoreView
{
    if ([_moreView superview]) {
        
        // 先隐藏
        [UIView beginAnimations:nil context:NULL];
        _moreView.alpha = 0;
        [UIView commitAnimations];
        
        // 再移除
        [_moreView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.2];
        _moreView = nil;
    }
}



int _lastIndex = 0;
//当点击的不是更多的选项，1.要移除遮罩（没有遮罩也要运行方法，只是不满足条件不执行而已）2.切换对应的控制器3.改变选中小黑框的位置4.保留当前所点击的tag值赋给_lastIndex
//_lastIndex纪录了上一次点击的Item的tag值，当连续点击更多选项，移除遮罩（moreView），页面跳回到之前点击过的页面self.selectedIndex = location  location＝_lastIndex；
- (void)changeViewController:(NSInteger)index
{
    // 获取到位置信息，如果点击到了第四个Item，并且_moreView视图存在，location的值应该为上一次的值
    //只有连续点击两次更多选项，才能让这个条件成立
    int location = (index == 4 && [_moreView superview])? _lastIndex : index;
    
    if (index >= 4 && _moreView == nil) {
        
        _moreView = [[MoreView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, kDeviceHeight-49)];
        _moreView.delegate = self;
        _moreView.tag = index;
        [self.view addSubview:_moreView];
        
    }else {
        
        [self addOrRemoveMoreView];
        
        self.selectedIndex = location;
    }
    
    // 移动选中视图的位置
    [UIView beginAnimations:nil context:NULL];
    _selectView.frame = CGRectMake(5 + 65 * location, _tabBarBG.height/2-45.0/2, 50, 45);
    [UIView commitAnimations];
    
    // 记录上一次选中的状态（tag）
    _lastIndex = (index == 4) ? _lastIndex : index;
    
}

#pragma mark - MoreView Delegate
- (void)didMoreViewBackgoundWithTag:(NSInteger)tag
{
    [self changeViewController:tag];
}

- (void)didSelectTableViewCellIndex:(NSInteger)index
{
    [self addOrRemoveMoreView];
    
    // 得到tabBar视图控制器
    NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.viewControllers];
    
    // 如果有5个视图控制器，就删除掉最后一个视图控制，这里一定主要内存是否得到正确的释放
    if (self.viewControllers.count >= 5) {
        [vcs removeLastObject];
    }
    
    MoreViewController *moreVC = nil;
    if (index == 0) {
        moreVC = [[MoreViewController alloc] init];
        moreVC.view.backgroundColor=[UIColor redColor];
        moreVC.title = @"搜索";
        
    }else if (index == 1) {
        moreVC = [[MoreViewController alloc] init];
        moreVC.view.backgroundColor=[UIColor blueColor];
        moreVC.title = @"收藏";
        
    }else if (index == 2) {
        moreVC = [[MoreViewController alloc] init];
        moreVC.view.backgroundColor=[UIColor yellowColor];
        moreVC.title = @"设置";
        
    }else {
        moreVC = [[MoreViewController alloc] init];
        moreVC.view.backgroundColor=[UIColor whiteColor];
        moreVC.title = @"关于";
    }
    
    BaseNavigationController *moreNav = [[BaseNavigationController alloc] initWithRootViewController:moreVC];
    [vcs addObject:moreNav];
    
    [self setViewControllers:vcs animated:YES];
    
    self.selectedIndex = 4;
    _lastIndex = 4;
}



#pragma mark - Public Method
- (void)showOrHiddenTabBarView:(BOOL)isHidden
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.33];
    if (isHidden) {
        _tabBarBG.left = -320;
    }else {
        _tabBarBG.left = 0;
    }
    [UIView commitAnimations];
}


@end
