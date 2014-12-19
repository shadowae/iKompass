//
//  ViewController.m
//  Locator
//
//  Created by ASatish Kumar on 14/12/14.
//  Copyright (c) 2014 i3Tech. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation ViewController

@synthesize location,locationManager,isUpdatingLocation,locationTextView,previousPoint,totalMovementDistance;

- (void)viewDidLoad {
    [super viewDidLoad];
    // initialisation of the items
    isUpdatingLocation = NO;
    locationManager = [[CLLocationManager alloc]init];
    self.mapView.showsUserLocation = true;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onLocationButtonPressed:(id)sender {
    [self getMyLocation];
    
}

-(void)getMyLocation
{
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    
    // check if auth status has been asked.
    if (authStatus == kCLAuthorizationStatusNotDetermined) {
        [locationManager requestWhenInUseAuthorization];
        return;
    }
    
    // check if is rejected/denied or restricted access for location services
    if (authStatus == kCLAuthorizationStatusDenied || authStatus == kCLAuthorizationStatusRestricted) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please enable location services for this app in Setting." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        
        [alertView show];
    }
    if (isUpdatingLocation) {
        [self stopLocationManager];
    }
    else{
        location = nil;
        [self startLocationManager];
    }
    
}
-(void)stopLocationManager{
    if (isUpdatingLocation) {
        [locationManager stopUpdatingLocation];
        //clean coding when delegate is removed
        locationManager.delegate = nil;
        isUpdatingLocation = NO;
    }
    
}

-(void)startLocationManager{
    // can add improvement to add timer to let it updating location.
    if ([CLLocationManager locationServicesEnabled])
    {
        locationManager.delegate = self;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        [locationManager startUpdatingLocation];
        isUpdatingLocation = YES;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *newLocation = [locations lastObject];
    NSMutableString *locationInfo = [[NSMutableString alloc]init];
    NSString *latitudeString = [NSString stringWithFormat:@"%g\u00B0", newLocation.coordinate.latitude];
    NSString *longitudeString = [NSString stringWithFormat:@"%g\u00B0", newLocation.coordinate.longitude];
    NSString *altitudeString = [NSString stringWithFormat:@"%gm", newLocation.altitude];
    NSString *hAccuracyString = [NSString stringWithFormat:@"%gm", newLocation.horizontalAccuracy];
    NSString *vAccuracyString = [NSString stringWithFormat:@"%gm", newLocation.verticalAccuracy];
    
    if (previousPoint == nil) {
        self.totalMovementDistance = 0;
        
        //show the point on the map
        MapAnnotation *mapAnnotation = [[MapAnnotation alloc]init];
        mapAnnotation.coordinate = newLocation.coordinate;
        mapAnnotation.title = @"Start";
        mapAnnotation.subtitle = @"Initial point";
        [self.mapView addAnnotation:mapAnnotation];
        MKCoordinateRegion region;
        region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 100, 100);
        [self.mapView setRegion:region animated:YES];
        
    }
    else{
        self.totalMovementDistance += [newLocation distanceFromLocation:self.previousPoint];
            }

    self.previousPoint = newLocation;
    NSString *distanceString = [NSString stringWithFormat:@"%gm", self.totalMovementDistance];

    [locationInfo appendFormat:@"Latitude : %@\nLongitude : %@\nAltitude : %@\nHorizontal Accuracy : %@\nVertical Accuracy : %@", latitudeString,longitudeString,altitudeString,hAccuracyString,vAccuracyString];

    
    self.locationTextView.text = [NSString stringWithString:locationInfo];
}

@end
