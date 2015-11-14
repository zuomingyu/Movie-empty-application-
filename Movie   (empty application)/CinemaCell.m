//
//  CinemaCell.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/25.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "CinemaCell.h"
#import "CinemaModel.h"
#import "common.h"
#import "UIImageView+WebCache.h"

#define kGap 10
#define kImageViewWidth 60
#define kImageViewHeight 80
#define kLabelWidth  160
#define kLabelHeight 25


@implementation CinemaCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

- (void)initSubViews
{
    // 图片
    _imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:_imgView];
    
    // 标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_titleLabel];
    
    // 类型
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _typeLabel.backgroundColor = [UIColor clearColor];
    _typeLabel.font = [UIFont systemFontOfSize:14];
    _typeLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_typeLabel];
    
    // 导演
    _directorLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _directorLabel.font = [UIFont systemFontOfSize:14];
    _directorLabel.backgroundColor = [UIColor clearColor];
    _directorLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_directorLabel];
    
    // 日期
    _releaseDateView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _releaseDateView.image = [UIImage imageNamed:@"theater_coming"];
    [self.contentView addSubview:_releaseDateView];
    
    // 月
    _monthLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _monthLabel.textAlignment = NSTextAlignmentCenter;
    _monthLabel.backgroundColor = [UIColor clearColor];
    _monthLabel.textColor = [UIColor whiteColor];
    _monthLabel.font = [UIFont boldSystemFontOfSize:16];
    [_releaseDateView addSubview:_monthLabel];
    
    // 日
    _dayLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _dayLabel.textAlignment = NSTextAlignmentCenter;
    _dayLabel.backgroundColor = [UIColor clearColor];
    _dayLabel.font = [UIFont systemFontOfSize:14];
    _dayLabel.textColor = [UIColor blackColor];
    [_releaseDateView addSubview:_dayLabel];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 图片
    _imgView.frame = CGRectMake(kGap, kGap, kImageViewWidth, kImageViewHeight);
    [_imgView setImageWithURL:[NSURL URLWithString:self.cinemaModel.image]];
    
    // 标题
    _titleLabel.frame = CGRectMake(_imgView.right+kGap, _imgView.top, kLabelWidth, kLabelHeight);
    _titleLabel.text  = self.cinemaModel.title;
    
    // 类型
    _typeLabel.frame = CGRectMake(_titleLabel.left, _titleLabel.bottom, _titleLabel.width, _titleLabel.height);
    _typeLabel.text = self.cinemaModel.type;
    
    // 导演
    _directorLabel.frame = CGRectMake(_typeLabel.left, _typeLabel.bottom, _typeLabel.width, _typeLabel.height);
    _directorLabel.text = self.cinemaModel.director;
    
    // 上映日期
    _releaseDateView.frame = CGRectMake(_titleLabel.right, 25, 50, 50);
    _monthLabel.frame = CGRectMake(0, 0, 50, 25);
    _dayLabel.frame = CGRectMake(_monthLabel.left, _monthLabel.bottom, 50, 25);
    
    // 处理日期字符串
    char *date = (char *)[self.cinemaModel.releaseDate UTF8String];
    int month, day;
    // c语言函数 可以模拟用户输入
    
    // 指定一个过滤的格式化占位符 把日期中的月日保存到month, day
    sscanf(date, "%d月%d日", &month, &day);
    
    //NSLog(@"%d %d",month,day);
    
    // 月、日
    _monthLabel.text = [NSString stringWithFormat:@"%d月", month];
    _dayLabel.text = [NSString stringWithFormat:@"%d", day];
}


@end
