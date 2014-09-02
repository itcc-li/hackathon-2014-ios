//
//  SecondStoryViewController.m
//  Hackathon2014
//
//  Created by Elwin on 24/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "SecondStoryViewController.h"

static NSString * const kCurrentView = @"locationTask";

@interface SecondStoryViewController ()
@property (strong, nonatomic) IBOutlet UITextView *secondView;
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSArray *stories;

@end

@implementation SecondStoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self loadData];
//	[self.view setBackgroundColor:[UIColor colorWithRed:0.898 green:0.941 blue:0.952 alpha:1]];
	[self assignData];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneButton:(id)sender {
	//NSInteger integer = [[NSUserDefaults standardUserDefaults] integerForKey:kCurrentView] + 1;
	//[[NSUserDefaults standardUserDefaults] setInteger:integer forKey:kCurrentView];
	[self dismissViewControllerAnimated:YES completion:nil];
	
}

#pragma mark - data handling

- (void)assignData {
	NSInteger currentView = [[NSUserDefaults standardUserDefaults] integerForKey:kCurrentView];
	self.stories = self.array[0];
	
	if (currentView >= ([self.stories count] - 1) || currentView < 0) {
		NSLog(@"Fucking out of bounds!");
		return;
	}
	
	NSDictionary *story = self.stories[currentView];
	self.title = [story valueForKey:kTitleKey];
	self.secondView.text = [story valueForKey:kBodyKey];
//	self.secondView.textColor = [UIColor darkGrayColor];
}

- (void)loadData {
	NSString *filePath = [[NSBundle mainBundle] pathForResource:@"tour2" ofType:@"plist"];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		self.array = [[NSArray alloc] initWithContentsOfFile:filePath];
	} else {
		NSLog(@"No file found!");
	}
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
