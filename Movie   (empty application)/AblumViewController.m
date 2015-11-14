//
//  AblumViewController.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/27.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "AblumViewController.h"
#import "MainViewController.h"
#import "ImageModel.h"
#import "WXNetworkService.h"
#import "common.h"
#import "NSObject+MJKeyValue.h"
#import <MediaPlayer/MediaPlayer.h>


#define kScrollViewGap 15



@interface AblumViewController ()

- (void)loadNavigationBar;

- (void)loadBaseScrollView;

- (void)loadTitleView;

- (void)requestData;

- (void)refreshUI;

- (void)downloadData:(NSInteger)i;

@end



@implementation AblumViewController

#pragma mark - ViewController Life
- (void)loadView
{
    [super loadView];
    // 创建滑动视图
    [self loadBaseScrollView];
    
    // 自定义导航栏视图
    [self loadNavigationBar];
    
    // 创建标题视图（底部视图）
    [self loadTitleView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
   
    // 请求"网络"数据
    [self requestData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.navigationController.viewControllers.count == 2) {
        
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.navigationController.viewControllers.count == 1) {
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        
        MainViewController *mainVC = (MainViewController *)self.tabBarController;
        [mainVC showOrHiddenTabBarView:NO];
    }
}


#pragma mark - Private Method
- (void)loadNavigationBar
{
    _navigationBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, 44)];
    _navigationBar.userInteractionEnabled = YES;
    _navigationBar.image = [UIImage imageNamed:@"nav_bg_all"];
    [self.view addSubview:_navigationBar];
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(2, 0, 44, 44);
    [backButton setBackgroundImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backRootVC:) forControlEvents:UIControlEventTouchUpInside];
    [_navigationBar addSubview:backButton];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, 200, 44)];
    title.text = @"电影图片";
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.backgroundColor = [UIColor clearColor];
    title.font = [UIFont boldSystemFontOfSize:22];
    [_navigationBar addSubview:title];
}

- (void)loadBaseScrollView
{
    _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kDeviceWidth+kScrollViewGap, kDeviceHeight-20)];
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    //INT_MAX整数最大值，为了使这个界面的tag值不会与其他相同
    _contentScrollView.tag = INT_MAX;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_contentScrollView];
}

- (void)loadTitleView
{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kDeviceHeight-49-20, kDeviceWidth, 49)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.backgroundColor = [UIColor blackColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.view addSubview:_titleLabel];
}

////////////////////////////////////////////////////////////////////////

- (void)requestData
{
    
 
    NSArray *data = [WXNetworkService newsImageData];
    
    _imagesData=[[NSArray alloc]init];

    _imagesData=[ImageModel modelArrayWithDictArray:data];
    

    
   
    
    [self refreshUI];
}

- (void)refreshUI
{
    // 设置滑动视图的内容大小
    _contentScrollView.contentSize = CGSizeMake((kDeviceWidth + kScrollViewGap) * _imagesData.count, 0);
    
    // 设置第一个标题的内容
    ImageModel *imageModel = _imagesData[0];
    _titleLabel.text = imageModel.title;
    
    int x = 0;
    for (int index = 0; index < _imagesData.count; index++) {
        
        // 取出数据
        ImageModel *imageModel = _imagesData[index];
        
        // 创建视图
        AblumView *ablumView = [[AblumView alloc] initWithFrame:CGRectMake(0+x, 0, kDeviceWidth, kDeviceHeight-20)];
        ablumView.tag = index;
        if (index < 2) {
            
            ablumView.url = imageModel.url2;
            [ablumView downloadImage];
        }
        ablumView.delegate = self;
        [_contentScrollView addSubview:ablumView];
        
        x += (kDeviceWidth + kScrollViewGap);
    }
}


- (void)downloadData:(NSInteger)i
{
    AblumView *_ablumView = (AblumView *)[_contentScrollView viewWithTag:i];
    ImageModel *imageModel = _imagesData[i];
    _ablumView.url = imageModel.url2;
    [_ablumView downloadImage];
}





#pragma mark - Action Method
- (void)backRootVC:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ScrollView Delegate
static int lastIndex = 0;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    //内存优化，加载图片只加载当前的图片的前一张和后一张
    int index = scrollView.contentOffset.x / (kDeviceWidth+kScrollViewGap);
    
    if (index >= _imagesData.count || index < 0) {
        return;
    }
    
    // 设置标题
    ImageModel *imageModel = _imagesData[index];
    _titleLabel.text = imageModel.title;
    
    // 还原上一个视图比例
    AblumView *ablumView = (AblumView *)[_contentScrollView viewWithTag:lastIndex];
    if (ablumView.scrollView.zoomScale >= 1 && lastIndex != index) {
        
        ablumView.scrollView.zoomScale = 1;
    }
    
    if (index == 0) {
        // ... noting 2张图片（1， 2）
        for (int i = 0; i <= index+1; i++) {
            // NSLog(@"before : %d", i);
            
        }
        
    }else if (index == _imagesData.count-1) {
        // 2张图片（最后一张和倒数第二章）
        for (int i = index; i >= index-1; i--) {
            NSLog(@"end :i : %d", i);
            [self downloadData:i];
        }
    }else {
        // 3 4 5
        for (int i = index+1; i >= index-1; i--) {
            NSLog(@"middle : %d", i);
            [self downloadData:i];
        }
    }
    
    lastIndex = index;
}

#pragma mark - AblumView Delegate
- (void)hiddenOrShow:(AblumView *)ablumView
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.35];
    if (_navigationBar.alpha == 1 && _titleLabel.alpha == 1) {
        _navigationBar.alpha = 0;
        _titleLabel.alpha = 0;
    }else {
        _navigationBar.alpha = 1;
        _titleLabel.alpha = 1;
    }
    [UIView commitAnimations];
}




@end
