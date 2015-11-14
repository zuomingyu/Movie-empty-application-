//
//  MoreView.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/26.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "MoreView.h"
#import <QuartzCore/QuartzCore.h>
#import "common.h"

@implementation MoreView
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        //如果使用alpha会导致子视图也透明 即alpha是针对视图透明度设置 backgroundColor是针对背景色设置颜色的透明度
        self.backgroundColor = [UIColor colorWithRed:0 green:0.5 blue:0.5 alpha:0.5];
        
        
        _popView = [[UIImageView alloc] initWithFrame:CGRectMake(168, 480-49-182, 145, 182)];
        _popView.userInteractionEnabled = YES;
        _popView.image = [UIImage imageNamed:@"moreView_setting_new"];
        [self addSubview:_popView];
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _popView.width, _popView.height-9) style:UITableViewStylePlain];
        
        //cornerRadius圆弧 ---QuartzCore
        _tableView.layer.cornerRadius = 5;
        
        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_popView addSubview:_tableView];
        
    }
    
    return self;
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //reuseIdentifier:nil 不可被重用
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if (indexPath.row == 0) {
        
        cell.imageView.image = [UIImage imageNamed:@"more_search"];
        cell.textLabel.text = @"搜索";
        
    }else if (indexPath.row == 1) {
        
        cell.imageView.image = [UIImage imageNamed:@"more_fav"];
        cell.textLabel.text = @"收藏";
        
    }else if (indexPath.row == 2) {
        
        cell.imageView.image = [UIImage imageNamed:@"more_set"];
        cell.textLabel.text = @"设置";
        
    }else {
        cell.imageView.image = [UIImage imageNamed:@"more_info"];
        cell.textLabel.text = @"关于";
    }
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}


#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(didSelectTableViewCellIndex:)]) {
        [self.delegate didSelectTableViewCellIndex:indexPath.row];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //点击遮罩，相当于连续点击了两次更多选项
    if ([self.delegate respondsToSelector:@selector(didMoreViewBackgoundWithTag:)]) {
        [self.delegate didMoreViewBackgoundWithTag:self.tag];
    }
}


@end
