//
//  CinemaCell.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/25.
//  Copyright (c) 2015年 scsys. All rights reserved.
//
#import <UIKit/UIKit.h>

@class CinemaModel;
@interface CinemaCell : UITableViewCell
{
@private
    UIImageView *_imgView;
    UILabel     *_titleLabel;
    UILabel     *_typeLabel;
    UILabel     *_directorLabel;
    UIImageView *_releaseDateView;
    UILabel     *_monthLabel;
    UILabel     *_dayLabel;
}

@property (nonatomic, retain) CinemaModel *cinemaModel;

@end
