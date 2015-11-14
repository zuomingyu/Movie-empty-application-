//
//  MovieInfoModel.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/27.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieInfoModel : NSObject

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *titleCn;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, retain) NSArray *types;
@property (nonatomic, retain) NSArray *directors;
@property (nonatomic, retain) NSArray *actors;
@property (nonatomic, retain) NSDictionary *release2;
@property (nonatomic, retain) NSArray *images;
@property (nonatomic, retain) NSArray *videos;

@end
