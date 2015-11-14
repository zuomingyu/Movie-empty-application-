//
//  TopView.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/25.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemView.h"

@class RatingView, TopModel;
@interface TopView : UIView <ItemViewDelegate>
{
@private
    ItemView   *_itemView;
    RatingView *_ratingView;
}

@property (nonatomic, retain) TopModel *topModel;

@end


