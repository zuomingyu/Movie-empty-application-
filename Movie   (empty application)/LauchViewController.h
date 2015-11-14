//
//  LauchViewController.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/26.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LaunchViewControllerDelegate <NSObject>

- (void)loadLogoViewEnd;

@end

@interface LauchViewController : UIViewController
{
@private
    int   _count;
    int   _maxRow;
    float _height;
    NSMutableArray *_logosArray;
}

@property (nonatomic, assign) id <LaunchViewControllerDelegate> delegate;

@end
