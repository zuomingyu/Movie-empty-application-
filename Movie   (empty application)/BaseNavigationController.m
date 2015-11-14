//
//  BaseNavigationController.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    自定义TabBar视图(代码解耦合)
//    
//    思路：
//    
//    1. 隐藏系统自带的TabBar
//    
//    2. 自定义TabBar视图
//    
//    3. 选择背景视图
//    
//    4. 创建相应的ItemView

    //自定义导航栏
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_all"] forBarMetrics:UIBarMetricsDefault];//横屏

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
