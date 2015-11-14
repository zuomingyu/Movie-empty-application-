//
//  LauchViewController.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/26.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "LauchViewController.h"
#import "MainViewController.h"
#import "common.h"

#define kLogoViewWidth 80

@interface LauchViewController ()

- (void)setProperty;

- (void)loadLogoView;

- (void)showLogoView;

@end

@implementation LauchViewController


#pragma mark - ViewController Life
- (void)loadView
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
    
    // 设置启动页面的属性
    [self setProperty];
    
    // 加载logo视图
    [self loadLogoView];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
    // 递归显示logo图片
    [self showLogoView];
}




#pragma mark - Private Method
- (void)setProperty
{
    UIImageView *bgView = (UIImageView *)self.view;
    
    bgView.image = [UIImage imageNamed:@"Default"];
    _count = 16;
    _maxRow=6;
    
    
}

- (void)loadLogoView
{
    int x = 0, y = 0;
    
    _logosArray = [[NSMutableArray alloc] initWithCapacity:_count];
    for (int index = 0; index < _count; index++) {
        
        UIImageView *logoView = [[UIImageView alloc] init];
        logoView.alpha = 0;
        NSString *imgName = [NSString stringWithFormat:@"%d", index+1];
        logoView.image = [UIImage imageNamed:imgName];
        [self.view addSubview:logoView];
        
        // set frame
        logoView.width = 80;
        logoView.height = 80;
        logoView.left += x; // 2
        logoView.top += y;
        
        //设置第一行的位置，每一张图X相差80
        if (index < 3) {
            x += logoView.width;
        }
        //设置右边那一列的位置，每一张图Y相差80
        else if (index >= 3 && index < _maxRow+2) {
            y += logoView.height;
        }else if (index >= _maxRow+2/*9*/ && index < _maxRow+5) {
            x -= logoView.width;
        }else {
            y -= logoView.height;
        }
        
        [_logosArray addObject:logoView];
    }
}

static int i = 0;
- (void)showLogoView
{
    if (i >= [_logosArray count]) {
        
        /*
         if ([self.delegate respondsToSelector:@selector(loadLogoViewEnd)]) {
         [self.delegate loadLogoViewEnd];
         }
         */
        
        // 加载主视图控制器
        MainViewController *mainViewController = [[MainViewController alloc] init];
        self.view.window.rootViewController = mainViewController;
        
        return;
    }// 跳出递归
    
    UIImageView *logoView = _logosArray[i];
    NSLog(@"%@",logoView);
    logoView.backgroundColor  = [UIColor  redColor];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    logoView.alpha = 1;
    [UIView commitAnimations];
    
    [self performSelector:@selector(showLogoView) withObject:nil afterDelay:0.2];
    i++;
}

//隐藏该控制器的状态栏
//-(BOOL)perfersStatusBarHidden
//{
//    return YES;
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
