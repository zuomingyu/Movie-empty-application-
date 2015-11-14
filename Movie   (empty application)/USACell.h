//
//  USACell.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/23.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieModel,RatingView;
@interface USACell : UITableViewCell
{
@private
    UIImageView *_imgView;
    UILabel     *_titleLabel;
    UILabel     *_yearLabel;
    RatingView  *_ratingView;
    
    MovieModel  *_movieModel;
    
}

@property (nonatomic, retain) MovieModel *movieModel;

- (void)layoutSubviews;
@end

