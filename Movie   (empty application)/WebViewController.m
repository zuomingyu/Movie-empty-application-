//
//  WebViewController.m
//  影院框架
//
//  Created by scsys on 15/9/28.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "WebViewController.h"
#import "MainViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count==2) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (self.navigationController.viewControllers.count==1) {
        [self.navigationController setNavigationBarHidden:NO animated:NO];
        MainViewController *main=(MainViewController *)self.tabBarController;
        [main showOrHiddenTabBarView:NO];
    }
}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self=[super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        UIView *view=[[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        view.backgroundColor=[UIColor blackColor];
        
        self.view=view;
        _webview=[[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 320, 480-49)];
        _webview.backgroundColor=[UIColor blackColor];
        
        [self.view addSubview:_webview];
        [self addSome];
        [self addWeb];
        
        
    }
    return self;
}
-(void)addSome
{
     UIImageView   *navigationItem=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    navigationItem.image=[UIImage imageNamed:@"nav_bg_all"];
    navigationItem.userInteractionEnabled=YES;
    [self.view addSubview:navigationItem];
    
    UIButton *backBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame=CGRectMake(2, 5, 40, 40);
    [backBtn setImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
    
    [backBtn addTarget:self action:@selector(backRootVC) forControlEvents:UIControlEventTouchUpInside];
    [navigationItem addSubview:backBtn];
                        
     
    
    
    UILabel *lable=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    lable.backgroundColor=[UIColor clearColor];
    
    lable.textAlignment=NSTextAlignmentCenter;
    lable.textColor=[UIColor whiteColor];
    lable.text=@"网页";
    lable.font=[UIFont boldSystemFontOfSize:22];
    [navigationItem addSubview:lable];
}
-(void)addWeb
{
 
    NSURL *url1=[NSURL URLWithString:@"http://m.baidu.com"];
    NSURLRequest *request=[[NSURLRequest alloc] initWithURL:url1];
    [_webview  loadRequest:request];
    

}
-(void)backRootVC
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
