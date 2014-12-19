//
//  MapAnnotation.h
//  Locator
//
//  Created by ASatish Kumar on 14/12/14.
//  Copyright (c) 2014 i3Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject<MKAnnotation>

@property NSString *title; // cannot change the annotation class attributes for it to work
@property NSString *subtitle; // cannot change the annotation class attributes for it to work
@property CLLocationCoordinate2D coordinate;

@end
