//
//  ColorNavigationController.m
//  Hackathon2014
//
//  Created by Simon on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "ColorNavigationController.h"

@interface ColorNavigationController ()

@end

@implementation ColorNavigationController



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [self.navigationBar setBarTintColor:[UIColor colorWithRed:30.f/255.f green:159.f/255.f blue:217.f/255.f alpha:1.0f]];
    
    // Do any additional setup after loading the view.
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

@end
