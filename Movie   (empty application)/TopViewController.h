//
//  TopViewController.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/22.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
@private
    UITableView    *_topTableView;
    NSMutableArray *_rowsArray;
}

@end
