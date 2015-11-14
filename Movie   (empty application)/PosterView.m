//
//  PosterView.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/24.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "PosterView.h"
#import "MovieModel.h"
#import "RatingView.h"
#import "common.h"
#import "UIImageView+WebCache.h"

#define kFooterViewHeight 40
#define kContentWidth     260
#define kHiddenHeaderViewHeight 100
#define kHiddenHeaderViewGap 0
#define kSmallImageViewWidth 60
#define kSmallImageViewHeight 90

@interface PosterView ()

- (void)initHeaderView;

- (void)initContentView;

- (void)initFooterView;

- (void)setContentSize;

- (void)initMaskView;

- (void)downloadSmallImage;

- (void)_scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@implementation PosterView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main"]];
        
        // 初始化头部视图及子视图
        [self initHeaderView];
        
        // 初始化中间的内容及子视图
        [self initContentView];
        
        // 初始化中间的内容及子视图
        [self initFooterView];
        
        // 调整视图的关系
        [self bringSubviewToFront:_headerView];
    }
    return self;
    
}


#pragma mark - Private Method
- (void)initHeaderView
{
    // 初始化头部视图
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, -kHiddenHeaderViewHeight, kDeviceWidth, 26+kHiddenHeaderViewHeight)];
    UIImage *original = [UIImage imageNamed:@"indexBG_home"];
    _headerView.userInteractionEnabled = YES;
    
    UIImage *newImage = [original stretchableImageWithLeftCapWidth:original.size.width/2 topCapHeight:1];//以中心点拉伸图片
    
    _headerView.image = newImage;
    [self addSubview:_headerView];
    
    // 初始化按钮
    _pullButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _pullButton.frame = CGRectMake(160-35/2.0+3, 2+kHiddenHeaderViewHeight, 35, 20);
    [_pullButton setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [_pullButton addTarget:self action:@selector(pullUpOrPullDown) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:_pullButton];
    
    _indexScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, kHiddenHeaderViewHeight)];
    _indexScrollView.delegate = self;
    _indexScrollView.decelerationRate = 0.1;
    _indexScrollView.showsHorizontalScrollIndicator = NO;
    [_headerView addSubview:_indexScrollView];
}// 初始化头部视图及子视图

- (void)pullUpOrPullDown
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    if (_headerView.top == kHiddenHeaderViewGap) {
        
        [_pullButton setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
        _headerView.top = -100;
        
        // 移除遮罩视图
        _maskView.backgroundColor = [UIColor clearColor];
        [_maskView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.2];
        
    }// “隐藏”缩略图
    else {
        
        _headerView.top = 0;
        [_pullButton setImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateNormal];
        
        // 添加遮罩视图
        [self initMaskView];
        
        // 下载小图片
        //ScrollView本身就有一个ImageView的控件，所以哪怕没有数据，内容也不为0
        if (_indexScrollView.subviews.count == 1) {
            [self downloadSmallImage];
        }
    }// 显示缩略图
    [UIView commitAnimations];
}

- (void)initMaskView
{
    self.maskView = [[UIView alloc] initWithFrame:self.bounds];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self insertSubview:_maskView aboveSubview:_contentView];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pullUpOrPullDown)];
    [_maskView addGestureRecognizer:singleTap];
}



- (void)downloadSmallImage
{
    int x = 0;
    for (int index = 0; index < self.posterData.count; index++) {
        
        UIImageView *smallView = [[UIImageView alloc] initWithFrame:CGRectMake(130+x, 5, kSmallImageViewWidth, kSmallImageViewHeight)];
        smallView.backgroundColor = [UIColor orangeColor];
        [_indexScrollView addSubview:smallView];
        
        MovieModel *model = self.posterData[index];
        NSString *imgURL = [[model.subject objectForKey:@"images"] objectForKey:@"medium"];
        [smallView setImageWithURL:[NSURL URLWithString:imgURL]];
        
        x += (kSmallImageViewWidth + 10);
    }
    _indexScrollView.contentSize = CGSizeMake(130*2+self.posterData.count*70-10, 100);
}




// 滑动减速停止时调用
- (void)_scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获得索引位置
    NSInteger index = 0;
    
    if (scrollView == _indexScrollView) {
        
        // 获得索引位置
        index = floor((_indexScrollView.contentOffset.x - 35) / 70 + 1);
        // 更改滑动大图的偏移量
        [_contentScrollView setContentOffset:CGPointMake(kContentWidth * index, 0) animated:YES];
        
    }// 滑动缩略图
    else {
        
        // 获得索引位置260
        index = scrollView.contentOffset.x / kContentWidth;
        
    }// 滑动大图
    
    // 更改缩略图的偏移量
    [_indexScrollView setContentOffset:CGPointMake((kSmallImageViewWidth+10) * index, 0) animated:YES];
    
    if (index < 0 || index >= [self.posterData count]) {
        return;
    } // 防止数组越界
    
    // 更改海报视图标题
    MovieModel *movieModel = self.posterData[index];
    _titleLabel.text = [movieModel.subject objectForKey:@"title"];
}

#pragma mark - ScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self _scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate && scrollView == _indexScrollView) {
        [self _scrollViewDidScroll:scrollView];
    }
}







- (void)initContentView
{
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(30, _headerView.bottom, kContentWidth, kDeviceHeight-20-44-49-(_headerView.height-kHiddenHeaderViewHeight)-kFooterViewHeight)];
    [self addSubview:_contentView];
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kContentWidth, _contentView.height)];
    
    _contentScrollView.delegate = self;
    
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.clipsToBounds = NO;
    _contentScrollView.pagingEnabled = YES;
//    _contentScrollView.backgroundColor=[UIColor redColor];
    [_contentView addSubview:_contentScrollView];
    
}// 初始化中间的内容及子视图



- (void)initFooterView
{
    _footerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, _contentView.bottom, kDeviceWidth, kFooterViewHeight)];
    _footerView.image = [UIImage imageNamed:@"poster_title_home"];
    [self addSubview:_footerView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:_footerView.bounds];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_footerView addSubview:_titleLabel];
}// 初始化底部的内容及子视图




#pragma mark - Public Mehtod
- (void)reloadPosterData:(NSArray *)data
{
    self.posterData = data;
    //刷新数据
    [self setContentSize];
}




- (void)setContentSize
{
    // 设置首页页面标题
    _titleLabel.text = [[self.posterData[0] subject] objectForKey:@"title"];
    
    // 内容视图，gap和width用于适配
    int x = 0,
        gap = 20,
        width = 220;
    for (int index = 0; index < self.posterData.count; index++) {
        
        // 取出数据
        MovieModel *movieModel = self.posterData[index];
        
        
        // 初始化翻转的基视图
        UIView *flipBaseView = [[UIView alloc] initWithFrame:CGRectMake(x+gap, 10, width, _contentScrollView.height-20)];
        flipBaseView.backgroundColor = [UIColor cyanColor];
        [_contentScrollView addSubview:flipBaseView];
        
        // 添加一个单击事件
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(flipImageView:)];
        [flipBaseView addGestureRecognizer:singleTap];
        
        // 详细页面视图
        UIView *detailView = [[UIView alloc] initWithFrame:flipBaseView.bounds];
        detailView.backgroundColor = [UIColor blueColor];
        [flipBaseView addSubview:detailView];
        
        // 详细页小图图片
        UIImageView *smallView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20, 100, 150)];
        NSString *mediumURL = [[movieModel.subject objectForKey:@"images"] objectForKey:@"medium"];
        [smallView setImageWithURL:[NSURL URLWithString:mediumURL]];
        [detailView addSubview:smallView];
        
        // 中文名称
        UILabel *chinese = [[UILabel alloc] initWithFrame:CGRectMake(smallView.right+10, smallView.top, detailView.width-smallView.width-30, 45)];
        chinese.numberOfLines = 0;
        chinese.backgroundColor = [UIColor clearColor];
        chinese.text = [NSString stringWithFormat:@"中文: %@", [movieModel.subject objectForKey:@"title"]];
        chinese.font = [UIFont boldSystemFontOfSize:16];
        [detailView addSubview:chinese];
        
        // 英文名称
        UILabel *english = [[UILabel alloc] initWithFrame:CGRectMake(smallView.right+10, chinese.bottom+5, detailView.width-smallView.width-30, 45)];
        english.numberOfLines = 0;
        english.backgroundColor = [UIColor clearColor];
        english.text = [NSString stringWithFormat:@"英文: %@", [movieModel.subject objectForKey:@"original_title"]];
        english.font = [UIFont boldSystemFontOfSize:16];
        [detailView addSubview:english];
        
        // 年份
        UILabel *year = [[UILabel alloc] initWithFrame:CGRectMake(smallView.right+10, english.bottom+5, detailView.width-smallView.width-30, 45)];
        year.numberOfLines = 0;
        year.backgroundColor = [UIColor clearColor];
        year.text = [NSString stringWithFormat:@"年份: %@", [movieModel.subject objectForKey:@"year"]];
        year.font = [UIFont boldSystemFontOfSize:16];
        [detailView addSubview:year];
        
        // 评级视图
        RatingView *ratingView = [[RatingView alloc] initWithFrame:CGRectMake(10, detailView.height/1.5, 0, 0)];
        ratingView.style = kNormalStyle;
        ratingView.ratingScore = [[[movieModel.subject objectForKey:@"rating"] objectForKey:@"average"] floatValue];
        [detailView addSubview:ratingView];
        
        ///////////////////////////////////////////////////////////
        
        // 浏览页大图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:flipBaseView.bounds];
        [flipBaseView addSubview:imgView];
        NSString *largeImgURL = [[movieModel.subject objectForKey:@"images"] objectForKey:@"large"];
        [imgView setImageWithURL:[NSURL URLWithString:largeImgURL]];
        
        x += kContentWidth;
    }
    
    _contentScrollView.contentSize = CGSizeMake(x, _contentScrollView.height);
}

#pragma mark - Target Actions
- (void)flipImageView:(UITapGestureRecognizer *)tap
{
    UIView *flipView = [tap view];
    
    [UIView beginAnimations:@"Flip" context:nil];
    
    [UIView setAnimationDuration:0.5];
    [flipView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    if (flipView.tag == 0) {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:flipView cache:YES];
        flipView.tag = 1;
    }else {
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:flipView cache:YES];
        flipView.tag = 0;
    }
    
    [UIView commitAnimations];
}


@end
