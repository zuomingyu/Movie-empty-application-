//
//  TopCell.m
//  Movie   (empty application)
//
//  Created by scsys on 15/9/25.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import "TopCell.h"
#import "TopView.h"
#import "RatingView.h"
#import "ItemView.h"
#import "TopModel.h"

@implementation TopCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
        
        //默认选中1行后是 蓝色背景
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)initSubviews
{
    int x = 0;
    for (int index = 0; index < 3; index++) {
        TopView *topView = [[TopView alloc] initWithFrame:CGRectMake(15+x, 20, 90, 130)];
        topView.tag = 101+index;
        topView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:topView];
        
        x += 100;
    }
}

- (void)setImagesArray:(NSArray *)imagesArray
{
    if (_imagesArray != imagesArray) {
        
        _imagesArray = imagesArray;
        
        for (int index = 0; index < 3; index++) {
            TopView *topView = (TopView *)[self.contentView viewWithTag:101+index];
            topView.hidden = YES;
        }
    }
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int index = 0; index < self.imagesArray.count; index++) {
        TopView *topView = (TopView *)[self.contentView viewWithTag:101+index];
        topView.topModel = self.imagesArray[index];
        topView.hidden = NO;
        
        
    }
    
    

    
   
}


@end
