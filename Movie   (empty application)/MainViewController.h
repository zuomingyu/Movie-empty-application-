//
//  MainViewController.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemView.h"
#import "MoreView.h"

@interface MainViewController : UITabBarController <ItemViewDelegate,MoreViewDelegate>
{
@private
    UIImageView *_tabBarBG;
    UIImageView *_selectView;
    MoreView    *_moreView;
}


- (void)showOrHiddenTabBarView:(BOOL)isHidden;
@end
