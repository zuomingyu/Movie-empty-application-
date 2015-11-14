//
//  MoreView.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/26.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreViewDelegate <NSObject>

// 用户点击背景视图
- (void)didMoreViewBackgoundWithTag:(NSInteger)tag;

// 用户点击表视图
- (void)didSelectTableViewCellIndex:(NSInteger)index;

@end

@interface MoreView : UIView <UITableViewDelegate, UITableViewDataSource>
{
@private
    UITableView *_tableView;
    UIImageView *_popView;//气泡视图
}

@property (nonatomic, assign) id <MoreViewDelegate> delegate;

@end

