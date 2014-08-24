//
//  SecondMapViewController.h
//  Hackathon2014
//
//  Created by Swiss App Innovation on 24.08.14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Adress.h"

@interface SecondMapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, UIActionSheetDelegate>


// hearts : tag 0 letztes Leben Tag 3 gleich erstes Leben
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *hearts;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *locations;
@property (nonatomic) NSInteger points;

@property (nonatomic, strong) IBOutlet UIBarButtonItem *checkLocationButton;
@property (nonatomic) NSInteger anzahlVersuche;
- (IBAction)checkStao:(id)sender;
- (IBAction)showAufgabe:(id)sender;


@end
