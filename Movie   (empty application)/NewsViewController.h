//
//  NewsViewController.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

typedef enum kCellType {
    kWordType = 0,
    kImageType = 1,
    kMovieType = 2
}kCellType;

@interface NewsViewController :  BaseViewController <UITableViewDataSource, UITableViewDelegate>
{
@private
    UITableView    *_newsTableView;
    NSArray *_newsArray;
}



@end
