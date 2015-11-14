//
//  RatingView.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/23.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#define kNormalWidth 35
#define kNormalHeight 33

#define kSmallWidth 15
#define kSmallHeight 14

#define kFullMark 10

#define kNormalFontSize 25
#define kSmallFontSize 12



#import "RatingView.h"

@implementation RatingView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self) {
        // 初始化灰色的星星
        [self initGrayStarView];
        
        // 初始化黄色的星星
        [self initYellowStarView];
        
        // 初始化评分标签
        [self initRatingLabel];
    }
    
    return self;
}



- (void)initGrayStarView
{
    _grayStarsArray = [[NSMutableArray alloc] initWithCapacity:5];
    for (int index = 0; index < 5; index++) {
        UIImageView *grayStarView = [[UIImageView alloc] initWithFrame:CGRectZero];
        grayStarView.image = [UIImage imageNamed:@"gray"];
        [self addSubview:grayStarView];
        
        [_grayStarsArray addObject:grayStarView];
    }
}

- (void)initYellowStarView
{
    _baseView = [[UIView alloc] initWithFrame:CGRectZero];
    _baseView.backgroundColor = [UIColor clearColor];
    
    //视图是否可以裁剪
    _baseView.clipsToBounds = YES;
    
    [self addSubview:_baseView];
    
    _yellowStarsArray = [[NSMutableArray alloc] initWithCapacity:5];
    for (int index = 0; index < 5; index++) {
        UIImageView *yellowStarView = [[UIImageView alloc] initWithFrame:CGRectZero];
        yellowStarView.image = [UIImage imageNamed:@"yellow"];
        [_baseView addSubview:yellowStarView];
        
        [_yellowStarsArray addObject:yellowStarView];
    }
}

- (void)initRatingLabel
{
    _ratingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _ratingLabel.backgroundColor = [UIColor clearColor];
    _ratingLabel.textColor = [UIColor purpleColor];
    [self addSubview:_ratingLabel];
}


#pragma mark - Setter Method
- (void)setRatingScore:(CGFloat)ratingScore
{
    _ratingScore = ratingScore;
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f", _ratingScore];
}



#pragma mark - Layout subviews
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 取出黄色、灰色的星星，改变frame
    int width = 0;
    for (int index = 0; index < 5; index++) {
        UIView *yellowStar = _yellowStarsArray[index];
        UIView *grayStar   = _grayStarsArray[index];
        
        if (self.style == kSmallStyle) {
            yellowStar.frame = CGRectMake(0+width, 0, kSmallWidth, kSmallHeight);
            grayStar.frame = CGRectMake(0+width, 0, kSmallWidth, kSmallHeight);
            width += kSmallWidth;
        }else {
            yellowStar.frame = CGRectMake(0+width, 0, kNormalWidth, kNormalHeight);
            grayStar.frame = CGRectMake(0+width, 0, kNormalWidth, kNormalHeight);
            width += kNormalWidth;
        }
    }
    
    // 初始化baseView的宽度
    float baseViewWidth = 0;
    
    // 根据分数计算baseView的宽度
    baseViewWidth = self.ratingScore / kFullMark * width;
    
    float height = 0;
    if (self.style == kSmallStyle) {
        _baseView.frame = CGRectMake(0, 0, baseViewWidth, kSmallHeight);
        _ratingLabel.font = [UIFont boldSystemFontOfSize:kSmallFontSize];
        height = kSmallHeight;
    }else {
        _baseView.frame = CGRectMake(0, 0, baseViewWidth, kNormalHeight);
        _ratingLabel.font = [UIFont boldSystemFontOfSize:kNormalFontSize];
        height = kNormalHeight;
    }
    
    // 设置评级Label的frame
    _ratingLabel.frame = CGRectMake(width, 0, 0, 0);
    [_ratingLabel sizeToFit];
    
    // 设置视图的frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width+_ratingLabel.frame.size.width, height);
    
}


@end
