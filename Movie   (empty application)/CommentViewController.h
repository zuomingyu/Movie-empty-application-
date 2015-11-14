//
//  CommentViewController.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/27.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MovieInfoModel;
@interface CommentViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
@private
    UITableView    *_commentTableView;
    UIView         *_headerView;
    MovieInfoModel *_movieInfoModel;
    NSArray *_commentsArray;
}

@end

