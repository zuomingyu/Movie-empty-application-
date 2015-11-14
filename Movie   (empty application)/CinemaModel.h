//
//  CinemaModel.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/25.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CinemaModel : NSObject

@property (nonatomic, retain) NSNumber *CinemeID;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *image;
@property (nonatomic, copy)   NSString *releaseDate;
@property (nonatomic, copy)   NSString *director;
@property (nonatomic, copy)   NSString *type;

@end
