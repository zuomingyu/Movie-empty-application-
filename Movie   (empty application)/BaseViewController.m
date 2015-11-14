//
//  BaseViewController.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/27.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "BaseViewController.h"
#import "common.h"

@interface BaseViewController ()

@end

@implementation BaseViewController




#pragma mark - ViewController Life
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    self.view = view;
    
    if (self.navigationController.viewControllers.count >= 2 && _isBackItem) {
        
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(2, 0, 44, 44);
        [backButton setBackgroundImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(backRootVC:) forControlEvents:UIControlEventTouchUpInside];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
       }
                                                 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 当push时，隐藏掉tabBar视图
    self.hidesBottomBarWhenPushed = YES;
}
                                                 
- (void)backRootVC:(UIButton *)button
{
    [self.navigationController popViewControllerAnimated:YES];
}
                                                 
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
