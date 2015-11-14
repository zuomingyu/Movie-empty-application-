//
//  CommentCell.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/27.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#import "common.h"
#import "UIImageView+WebCache.h"

@implementation CommentCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubViews];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)initSubViews
{
    // 用户头像
    _headerView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _headerView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:_headerView];
    
    // 背景
    _cellBG = [[UIImageView alloc] initWithFrame:CGRectZero];
    UIImage *img = [UIImage imageNamed:@"movieDetail_comments_frame"];
    UIImage *newImage = [img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    _cellBG.image = newImage;
    [self.contentView addSubview:_cellBG];
    
    // 昵称
    _nickName = [[UILabel alloc] initWithFrame:CGRectZero];
    _nickName.backgroundColor = [UIColor clearColor];
    _nickName.textColor = [UIColor grayColor];
    _nickName.font = [UIFont systemFontOfSize:12];
    [_cellBG addSubview:_nickName];
    
    // 评分
    _ratingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _ratingLabel.backgroundColor = [UIColor clearColor];
    _ratingLabel.textColor = [UIColor grayColor];
    _ratingLabel.font = [UIFont systemFontOfSize:12];
    [_cellBG addSubview:_ratingLabel];
    
    // 评论
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _contentLabel.backgroundColor = [UIColor clearColor];
    _contentLabel.numberOfLines = 0; // 行数没有限制
    _contentLabel.font = [UIFont boldSystemFontOfSize:16];
    [_cellBG addSubview:_contentLabel];
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 头像
    _headerView.frame = CGRectMake(10, 5, 30, 30);
    [_headerView setImageWithURL:[NSURL URLWithString:_commentModel.userImage]];
    
    // 昵称
    _nickName.frame = CGRectMake(30, 2, 110, 20);
    _nickName.text = _commentModel.nickname;
    
    // 评分
    _ratingLabel.frame = CGRectMake(_cellBG.right-80, 0, 80, 20);
    _ratingLabel.text = _commentModel.rating;
    
    // 评论
    CGSize size = [_commentModel.content sizeWithFont:_contentLabel.font constrainedToSize:CGSizeMake(220, 10000)];
    _contentLabel.frame = CGRectMake(_nickName.left, _nickName.bottom, 220, size.height);
    _contentLabel.text = _commentModel.content;
    
    // 背景
    _cellBG.frame = CGRectMake(_headerView.right, 5, 260, _contentLabel.height+_nickName.height+10);
}



@end
