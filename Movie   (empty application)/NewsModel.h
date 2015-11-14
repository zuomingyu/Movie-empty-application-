//
//  NewsModel.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/25.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsModel : NSObject

@property (nonatomic, retain) NSNumber *newsID;
@property (nonatomic, retain) NSNumber *type;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *summary;
@property (nonatomic, copy)   NSString *image;

@end
