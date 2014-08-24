//
//  SecondMapViewController.m
//  Hackathon2014
//
//  Created by Swiss App Innovation on 24.08.14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "SecondMapViewController.h"

static NSString * const ktaskNo = @"tasknummer";
static NSString * const klg = @"laengengrad";
static NSString * const kbg = @"breitengrad";
static NSString * const kna = @"name";

@interface SecondMapViewController ()

- (void)initializeMap;
- (void)initializeHearts;
- (void)reloadHearts;
- (void)getDestinationForTaskNo:(NSInteger)task;
- (CLLocation *)getLocationForTask:(NSInteger)task;
- (NSInteger)checkTaskNo;

@property (nonatomic, strong) NSArray *plistData;

@end

@implementation SecondMapViewController

@synthesize mapView, hearts, anzahlVersuche;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locations = [NSMutableArray array];
    anzahlVersuche = -1000;
    self.mapView.delegate = self;
    [self initializeMap];
    [self initializeHearts];

    //[self getDestinationForTaskNo:[self checkTaskNo]];
    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated {
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"locationTask"] == 100) {
        [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"locationTask"];
        [self performSegueWithIdentifier:@"segueAufgabe" sender:self];
    } else {
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
    }
}
- (void)initializeHearts {
    if (anzahlVersuche <= 0) {
        anzahlVersuche = 4;
        for (UIImageView *uview in self.hearts) {
            uview.image = [UIImage imageNamed:@"hearts-128"];
        }
    }
}
- (void)initializeMap {
    if (self.locations.count == 0) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tour2" ofType:@"plist"];
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
            NSLog(@"%f %f %li", laeng, breit, (long)taskn);
        }
    }
    CLLocationCoordinate2D startCoord = CLLocationCoordinate2DMake(47.140405, 9.51916);
    MKCoordinateRegion adjustedRegion = [mapView regionThatFits:MKCoordinateRegionMakeWithDistance(startCoord, 1000 , 1000)];
    [mapView setRegion:adjustedRegion animated:YES];
}
- (CLLocation *)getLocationForTask:(NSInteger)task {
    for (Adress *adress in self.locations) {
        if (adress.taskNo == task) {
            CLLocation *destCo = [[CLLocation alloc] initWithLatitude:adress.laengengrad longitude:adress.breitengrad];
            return destCo;
        }
    }
    return nil;
}
- (void)getDestinationForTaskNo:(NSInteger)task {
    CLLocationCoordinate2D coord = self.mapView.userLocation.location.coordinate;
    CLLocation *userLoc = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
    CLLocation *destLoc = [self getLocationForTask:task];
    CLLocationDistance distance = [userLoc distanceFromLocation:destLoc];
    
    if (distance < 15) {
        NSLog(@"15m Radius");
        [self goToNextMission];
    } else {
        NSLog(@"%li", (long)anzahlVersuche);
        if (anzahlVersuche == 1) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Achtung" message:@"Letzte Chance" delegate:self cancelButtonTitle:@"Huch" otherButtonTitles:nil];
            [alert show];
        } else if (anzahlVersuche > 1) {
            UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Leider Nein" message:@"Sie befinden sich mehr als 15m entfernt vom Ziel" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert1 show];
        }
        [self reloadHearts];
    }
}
- (NSInteger)checkTaskNo {
    
    return [[NSUserDefaults standardUserDefaults] integerForKey:@"locationTask"];
}
- (void)reloadHearts {
        if (anzahlVersuche == 4) {
            for (UIImageView *uview in self.hearts) {
                if (uview.tag == 3) {
                    uview.image = [UIImage imageNamed:@"hearts-128-1"];
                    break;
                }
            }
            anzahlVersuche --;
        } else if (anzahlVersuche == 3) {
            for (UIImageView *uview in self.hearts) {
                if (uview.tag == 2) {
                    uview.image = [UIImage imageNamed:@"hearts-128-1"];
                    break;
                }
            }
            anzahlVersuche --;
        } else if (anzahlVersuche == 2) {
            for (UIImageView *uview in self.hearts) {
                if (uview.tag == 1) {
                    uview.image = [UIImage imageNamed:@"hearts-128-1"];
                    break;
                }
            }
            anzahlVersuche --;
        } else if (anzahlVersuche == 1) {
            for (UIImageView *uview in self.hearts) {
                if (uview.tag == 0) {
                    uview.image = [UIImage imageNamed:@"hearts-128-1"];
                    break;
                }
            }
            anzahlVersuche --;
        } else if (anzahlVersuche == 0) {
            [self goToNextMission];
            anzahlVersuche --;
            
        }
    }
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)goToNextMission {
            [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"locationTask"] +1 forKey:@"locationTask"];
                [self initializeHearts];
    [self performSegueWithIdentifier:@"segueSecondstory" sender:self];

}
- (IBAction)checkStao:(id)sender {
    [self getDestinationForTaskNo:[self checkTaskNo]];
}

- (IBAction)showAufgabe:(id)sender {
    [self performSegueWithIdentifier:@"segueAufgabe" sender:self];
}
@end
