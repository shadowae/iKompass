//
//  ViewController.h
//  Locator
//
//  Created by ASatish Kumar on 14/12/14.
//  Copyright (c) 2014 i3Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "MapAnnotation.h"

@interface ViewController : UIViewController<CLLocationManagerDelegate>
@property CLLocationManager *locationManager;
@property CLLocation *location;

// to control on and off switch
@property BOOL isUpdatingLocation;


// text view to show location data
@property (weak, nonatomic) IBOutlet UITextView *locationTextView;
- (IBAction)onLocationButtonPressed:(id)sender;


// use later
@property CLLocation *previousPoint;
@property CLLocationDistance totalMovementDistance;




@end

