//
//  BaseViewController.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/27.
//  Copyright (c) 2015年 scsys. All rights reserved.
//



//作为一个公共类，对二级页面的界面进行设置，继承这个公共类，跳转的二级页面没有分栏，导航栏左侧会有一个出栈（pop）按钮，实现出栈


#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (assign, nonatomic) BOOL isBackItem;

@end
