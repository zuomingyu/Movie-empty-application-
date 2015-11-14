//
//  TopView.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/25.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "TopView.h"
#import "ItemView.h"
#import "RatingView.h"
#import "TopModel.h"
#import "common.h"
#import "UIImageView+WebCache.h"

@implementation TopView
-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self) {
        // 初始化ItemView
        _itemView = [[ItemView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height-15)];
        _itemView.delegate = self;
        _itemView.item.frame = CGRectMake(0, 0, _itemView.width, _itemView.height);
        _itemView.title.frame = CGRectMake(0, _itemView.height-20, _itemView.width, 20);
        _itemView.title.backgroundColor = [UIColor blackColor];
        _itemView.title.font = [UIFont boldSystemFontOfSize:11];
        [self addSubview:_itemView];
        
        // 初始化ratingView
        _ratingView = [[RatingView alloc] initWithFrame:CGRectMake(0, _itemView.bottom, self.width, 0)];
        _ratingView.style = kSmallStyle;
        [self addSubview:_ratingView];
    
    }
    return self;
}


#pragma mark - Setter Method
- (void)setTopModel:(TopModel *)topModel
{
    if (_topModel != topModel) {
        
        _topModel = topModel;
        
        // ID赋值
        _itemView.tag = [_topModel.topID integerValue];
        
        // itemView赋值
        [_itemView.item setImageWithURL:[NSURL URLWithString:[_topModel.images objectForKey:@"medium"]]];
        _itemView.title.text = topModel.title;
        
        // ratingView
        _ratingView.ratingScore = [_topModel.rating integerValue];
    }
}

#pragma mark - ItemViewDelegate
- (void)didItemView:(ItemView *)itemView atIndex:(NSInteger)index
{
    // 事件响应者链
    /*
     id next = [itemView nextResponder];
     while (next != nil) {
     
     next = [next nextResponder];
     
     if ([next isKindOfClass:[UIViewController class]]) {
     NSLog(@"didItemView : %@",next);
     // UIViewController *topVC = (UIViewController *)next;
     // [topVC.navigationController pushViewController:nil animated:YES];
     break;
     }
     }
     */
}

@end
