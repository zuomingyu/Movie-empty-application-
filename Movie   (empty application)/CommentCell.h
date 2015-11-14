//
//  CommentCell.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/27.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentModel;
@interface CommentCell : UITableViewCell
{
@private
    UIImageView *_cellBG;
    UIImageView *_headerView;
    UILabel     *_nickName;
    UILabel     *_ratingLabel;
    UILabel     *_contentLabel;
}

@property (nonatomic, retain) CommentModel *commentModel;

@end


