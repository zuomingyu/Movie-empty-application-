//
//  ItemView.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "ItemView.h"
#import "common.h"

@implementation ItemView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initSubviews];
        
        [self addGesture];
    }
    return self;
}

- (void)initSubviews
{
    // 小图片
    _item = [[UIImageView alloc] initWithFrame:CGRectMake(self.width/2.0-11, 5, 22, 22)];
    _item.contentMode = UIViewContentModeScaleAspectFit;//合适比例
    _item.userInteractionEnabled = YES;
    [self addSubview:_item];
    
    // 小标题
    _title = [[UILabel alloc] initWithFrame:CGRectMake(0, _item.bottom+5, self.width, 10)];
    _title.backgroundColor = [UIColor clearColor];
    _title.textColor = [UIColor whiteColor];
    _title.font = [UIFont boldSystemFontOfSize:10];
    _title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_title];
}

- (void)addGesture
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didItemView:)];
    [self addGestureRecognizer:tap];
    
}

#pragma mark - Target Actions
- (void)didItemView:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(didItemView:atIndex:)]) {
        
        [self.delegate didItemView:self atIndex:self.tag];
    }
}

@end
