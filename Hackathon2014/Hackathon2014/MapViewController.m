//
//  MapViewController.m
//  Hackathon2014
//
//  Created by Swiss App Innovation on 23.08.14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "MapViewController.h"
#import "MathController.h"
#import "StoryViewController.h"

static NSString * const ktaskNo = @"tasknummer";
static NSString * const klg = @"laengengrad";
static NSString * const kbg = @"breitengrad";
static NSString * const kna = @"name";

@interface MapViewController ()

- (void)initializeMap;
- (void)getPins;
- (NSInteger)checkTaskNo;
- (void)getRouteForTask:(NSInteger)task;
- (void)checkDestinationforTask:(NSInteger)task;

@property (nonatomic, strong) NSArray *plistData;

@end

@implementation MapViewController
@synthesize mapView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locations = [NSMutableArray array];
    self.mapView.delegate = self;
    [self initializeMap];
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    [self getPins];
    [self getRouteForTask:[self checkTaskNo]];
    NSLog(@"%li", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"currentLocation"]);
}
- (void)initializeMap {
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(47.140405, 9.51916);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 1000 , 1000)];
    [mapView setRegion:adjustedRegion animated:YES];
}
- (void)checkDestinationforTask:(NSInteger)task {
    for (Adress *adress in self.locations) {
        if (adress.taskNo == task) {
            CLLocationCoordinate2D coord1 = self.mapView.userLocation.location.coordinate;
            
            CLLocation *P1 = [[CLLocation alloc] initWithLatitude:coord1.latitude longitude:coord1.longitude];
            CLLocation *P2 = [[CLLocation alloc] initWithLatitude:adress.laengengrad longitude:adress.breitengrad];
            CLLocationDistance  distance = [P1 distanceFromLocation:P2];
            
            if (distance < 15) {
                // Close enough
                NSLog(@"Nah Genug");
                self.startRaetselButton.tintColor = [UIColor colorWithRed:19.f/255.f green:119.f/255.f blue:255.f/255.f alpha:1];
                self.startRaetselButton.enabled = YES;
            } else {
                // Too fare away
                NSLog(@"Nicht Nah genug");
                self.startRaetselButton.tintColor = [UIColor grayColor];
                self.startRaetselButton.enabled = NO;
            }
        }
    }
}
        
- (void)getPins {
    if (self.locations.count == 0) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tour1" ofType:@"plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
            self.plistData = array[2];

        } else {
            NSLog(@"No file found!");
        }
        NSUInteger a = self.plistData.count;
        for (NSUInteger i = 0; i < a; i ++) {
            NSDictionary *data = self.plistData[i];
            float laeng = [[data valueForKey:klg] floatValue];
            float breit = [[data valueForKey:kbg] floatValue];
            NSInteger taskn = [[data valueForKey:ktaskNo] intValue];
            [self.locations addObject:[[Adress alloc] initWithTaskNo:taskn laengengrad:laeng name:[data valueForKey:kna] undbreitengrad:breit]];
        }
    }
    for (Adress * adress in self.locations) {
        CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(adress.laengengrad, adress.breitengrad);
        //MKPlacemark *placeM = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
        MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
        anno.coordinate = coordinate;
        anno.title = adress.name;
        [self.mapView addAnnotation:anno];
    }
}
- (NSInteger)checkTaskNo {
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"currentLocation"];
}
- (void)getRouteForTask:(NSInteger)task {
    for (Adress *adress in self.locations) {
        if (adress.taskNo == task) {
            
            MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
            request.source = [MKMapItem mapItemForCurrentLocation];
            request.requestsAlternateRoutes = NO;
            request.transportType = MKDirectionsTransportTypeWalking;
            CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(adress.laengengrad, adress.breitengrad);
            MKPlacemark *sourcePlacemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
            MKMapItem *adress = [[MKMapItem alloc] initWithPlacemark:sourcePlacemark];
            
            request.destination = adress;
            MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
            [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
                if (error) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warnung" message:@"Es konnte leider keine Route nach Vaduz gefunden" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alert show];
                    self.startRaetselButton.enabled = NO;
                } else {
                    [self showRoute:response];
                    [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"currentLocation"] +1 forKey:@"currentLocation"];
                    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"currentLocation"] > 8) {
                        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"currentLocation"];
                    }
                }
            }];
        }
    }
    
}
- (void)showRoute:(MKDirectionsResponse *)response {
    CLLocationCoordinate2D coord1 = self.mapView.userLocation.location.coordinate;
    
    CLLocation *P1 = [[CLLocation alloc] initWithLatitude:coord1.latitude longitude:coord1.longitude];
    CLLocation *P2 = [[CLLocation alloc] initWithLatitude:47.140405 longitude:9.51916];
    CLLocationDistance  distance = [P1 distanceFromLocation:P2];
    
    if (distance < 5000) {
        for (MKRoute *route in response.routes) {
            [self.mapView removeOverlays:self.mapView.overlays];
            [self.mapView addOverlay:route.polyline]; //level:MKOverlayLevelAboveRoads
        }
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Achtung" message:@"Sie sind mehr als 5km entfernt von Vaduz." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        self.startRaetselButton.enabled = NO;
    }
}
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolyline *route = overlay;
        MKPolylineRenderer *routeRenderer = [[MKPolylineRenderer alloc] initWithPolyline:route];
        routeRenderer.strokeColor = [UIColor blueColor];
        return routeRenderer;
    }
    else return nil;
}
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    [self checkDestinationforTask:[self checkTaskNo]];
}
- (IBAction)selfAction:(id)sender {
    [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}

- (IBAction)nextAction:(id)sender {
    [self getRouteForTask:[self checkTaskNo]];
}

- (IBAction)startRaetsel:(id)sender {
    
}
@end
