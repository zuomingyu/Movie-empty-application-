//
//  AdressViewController.h
//  Movie   (empty application)
//
//  Created by scsys on 15/10/28.
//  Copyright (c) 2015年 scsys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
@interface AdressViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,MKMapViewDelegate>
{
@private
    UITableView    *_listView;
    UIView     *_poserView;
    NSArray *_subjectsArray;
}
@property (retain, nonatomic) MKMapView *mapView;
@end
