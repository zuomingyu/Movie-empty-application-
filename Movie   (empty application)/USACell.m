//
//  USACell.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/23.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "USACell.h"
#import "common.h"
#import "UIImageView+WebCache.h"
#import "MovieModel.h"
#import "RatingView.h"

@implementation USACell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        [self initSubviews];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return self;
    
}

- (void)initSubviews
{
    // 图片
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _imgView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_imgView];
    
    // 标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor orangeColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self.contentView addSubview:_titleLabel];
    
    // 副标题
    _yearLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _yearLabel.backgroundColor = [UIColor clearColor];
    _yearLabel.textColor = [UIColor whiteColor];
    _yearLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_yearLabel];
    
    // 评级
    _ratingView = [[RatingView alloc] initWithFrame:CGRectZero];
    _ratingView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_ratingView];
    
}

//当视图将要显示的时候调用
//排版
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 取出数据
    NSDictionary *contentDic = self.movieModel.subject;
    
    // 图片
    _imgView.frame = CGRectMake(10, 10, 40, 60);
    NSString *imgURL = [[contentDic objectForKey:@"images"] objectForKey:@"medium"];
    
    
    /* 在不使用同步方式 网络中在详细说明使用方法
     NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imgURL]];
     _imgView.image = [UIImage imageWithData:data];
     */
    
    // 异步请求图片 UIImageView+WebCache.h
    //可以离线缓存图片  可以异步请求图片
    [_imgView setImageWithURL:[NSURL URLWithString:imgURL]];
    
    // 标题
    _titleLabel.frame = CGRectMake(_imgView.right+10, 10, 220, 30);
    _titleLabel.text = [contentDic objectForKey:@"title"];
    
    // 年份
    _yearLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom, _titleLabel.width/2, 30);
    _yearLabel.text = [NSString stringWithFormat:@"年份:%@", [contentDic objectForKey:@"year"]];
    
    
    // 评级
    _ratingView.frame = CGRectMake(_yearLabel.right, _titleLabel.bottom+10, 0, 0);
    _ratingView.style = kSmallStyle;
    _ratingView.ratingScore = [[[contentDic objectForKey:@"rating"] objectForKey:@"average"] floatValue];

    
}


@end
