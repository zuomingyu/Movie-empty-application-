//
//  WXAnation.h
//  Movie   (empty application)
//
//  Created by scsys on 15/10/28.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface WXAnation : NSObject<MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;



- (id)initWithCoordinate2D:(CLLocationCoordinate2D)coordinate;

@end

