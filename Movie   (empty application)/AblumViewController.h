//
//  AblumViewController.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/27.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "AblumView.h"

@interface AblumViewController : BaseViewController <AblumViewDelegate, UIScrollViewDelegate>
{
@private
    UIImageView    *_navigationBar;
    UIScrollView   *_contentScrollView;
    UILabel        *_titleLabel;
    NSArray *_imagesData;
}

@end
