//
//  ItemView.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ItemView;
@protocol ItemViewDelegate <NSObject>

@optional
- (void)didItemView:(ItemView *)itemView atIndex:(NSInteger)index;

@end

@interface ItemView : UIView

@property (nonatomic, readonly) UIImageView *item;
@property (nonatomic, readonly) UILabel     *title;
@property (nonatomic, assign) id <ItemViewDelegate> delegate;

@end

