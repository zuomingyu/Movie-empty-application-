//
//  CinemaViewController.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CinemaViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
@private
    UITableView *_cinemaTableView;
    NSArray *_cinemaArray;
}

@end


