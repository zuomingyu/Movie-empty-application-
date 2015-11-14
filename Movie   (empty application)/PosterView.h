//
//  PosterView.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/24.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PosterView : UIView<UIScrollViewDelegate>
{
@private
    UIScrollView *_indexScrollView;
    
    UIImageView  *_headerView;//header视图
    UIButton     *_pullButton;
    
    UIView       *_contentView;//content视图
    UIScrollView *_contentScrollView;
    
    UIImageView  *_footerView;//footer视图
    UILabel      *_titleLabel;
    
    
}

@property (nonatomic, retain) NSArray *posterData;
@property (nonatomic, retain) UIView  *maskView;//遮罩视图

- (void)reloadPosterData:(NSArray *)data;

@end