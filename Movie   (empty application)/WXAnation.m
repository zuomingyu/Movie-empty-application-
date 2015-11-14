//
//  WXAnation.m
//  Movie   (empty application)
//
//  Created by scsys on 15/10/28.
//  Copyright (c) 2015年 scsys. All rights reserved.
//
#import "WXAnation.h"

@implementation WXAnation
- (id)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate {
    self = [super init];
    if (self != nil) {
        _coordinate = coordinate;
    }
    return self;
}
@end
