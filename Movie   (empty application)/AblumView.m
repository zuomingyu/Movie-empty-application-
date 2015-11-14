//
//  AblumView.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/27.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "AblumView.h"
#import "UIImageView+WebCache.h"
#import "common.h"

@implementation AblumView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        _scrollView.minimumZoomScale = 1;
        _scrollView.maximumZoomScale = 2.5;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.scrollsToTop = NO;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = [UIColor blackColor];
        [self addSubview:_scrollView];
        
        _imgView = [[UIImageView alloc] initWithFrame:_scrollView.frame];
        _imgView.userInteractionEnabled = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [_scrollView addSubview:_imgView];
        
        UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(zoomOutOrIn:)];
        doubleTap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:doubleTap];
        
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenOrShow:)];
        [self addGestureRecognizer:singleTap];
        
        // 双击时忽略掉单击事件
        [singleTap requireGestureRecognizerToFail:doubleTap];
    }
    return self;
}

#pragma mark - Public Method
- (void)downloadImage
{
    if (_imgView.image == nil) {
        // 把图片异步请求下来
        [_imgView setImageWithURL:[NSURL URLWithString:_url]];
    }
}

#pragma mark - ScrollView Delegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _imgView;
}

#pragma mark - target Method
- (void)zoomOutOrIn:(UITapGestureRecognizer *)tap
{
    // 获取到用户点击位置
    CGPoint point = [tap locationInView:_imgView];
    
    // NSLog(@"%@", NSStringFromCGPoint(point));
    
    if (_scrollView.zoomScale == 1) {
        
        [_scrollView zoomToRect:CGRectMake(point.x-40, point.y-40, 80, 80) animated:YES];
        
    }else {
        [_scrollView setZoomScale:1 animated:YES];
    }
}


- (void)hiddenOrShow:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(hiddenOrShow:)]) {
        [self.delegate hiddenOrShow:self];
    }
}


@end
