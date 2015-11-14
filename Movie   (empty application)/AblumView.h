//
//  AblumView.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/27.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AblumView;
@protocol AblumViewDelegate <NSObject>

@optional
- (void)hiddenOrShow:(AblumView *)ablumView;

@end

@interface AblumView : UIView <UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView  *_imgView;
}

@property (nonatomic, assign) id <AblumViewDelegate> delegate;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, readonly) UIScrollView *scrollView;

- (void)downloadImage;

@end


