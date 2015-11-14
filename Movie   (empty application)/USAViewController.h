//
//  USAViewController.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PosterView;

@interface USAViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
@private
    UITableView    *_listView;
    PosterView     *_poserView;
    NSArray *_subjectsArray;
}

@end
