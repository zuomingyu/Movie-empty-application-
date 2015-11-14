//
//  RatingView.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/23.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum kRatingViewStyle {
    kSmallStyle  = 0,
    kNormalStyle = 1
}kRatingViewStyle;

@interface RatingView : UIView
{
@private
    UIView  *_baseView;
    UILabel *_ratingLabel;
    NSMutableArray *_yellowStarsArray;
    NSMutableArray *_grayStarsArray;
    
}

@property (nonatomic, assign) kRatingViewStyle style;
@property (nonatomic, assign) CGFloat ratingScore;

@end
