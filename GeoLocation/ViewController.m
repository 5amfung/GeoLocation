//
//  ViewController.m
//  GeoLocation
//
//  Created by bbpan on 2/21/14.
//  Copyright (c) 2014 sfng.co. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *latitude;
@property (weak, nonatomic) IBOutlet UILabel *longitude;
@end

@implementation ViewController {
    CLLocationManager *_locationManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
}

- (IBAction)buttonPressed:(id)sender {
    if ([CLLocationManager locationServicesEnabled] == NO) {
        NSLog(@"Please enable Location Service.");
        return;
    }
    
    [_locationManager startUpdatingLocation];
}

#pragma mark CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Failed to get location: %@", error);
    
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    switch (authorizationStatus) {
        case kCLAuthorizationStatusDenied:
            NSLog(@"Denied");
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"Not determinded");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = locations.lastObject;
    self.latitude.text = [NSString stringWithFormat:@"%.8f", location.coordinate.latitude];
    self.longitude.text = [NSString stringWithFormat:@"%.8f", location.coordinate.longitude];
}

@end
