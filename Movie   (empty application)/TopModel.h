//
//  TopModel.h
//  Movie   (empty application)
//
//  Created by scsys on 15/9/25.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopModel : NSObject

@property (nonatomic, retain) NSNumber *topID;
@property (nonatomic, retain) NSNumber *rating;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSDictionary *images;


@end
