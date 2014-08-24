//
//  IntroTableViewController.m
//  Hackathon2014
//
//  Created by Simon on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "IntroTableViewController.h"
#import "MapViewController.h"

@interface IntroTableViewController ()

@end

@implementation IntroTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"currentStory"];

    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"currentTask"];

    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"currentLocation"];
    
    [[NSUserDefaults standardUserDefaults] setInteger:100 forKey:@"locationTask"];

//    self.tableView.backgroundColor = [UIColor whiteColor];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 2) {
//        NSInteger currentStory = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentStory"];
//        NSInteger currentTask = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentTask"];
//        NSInteger currentLocation = [[NSUserDefaults standardUserDefaults] integerForKey:@"currentLocation"];
//        
//        if (currentLocation > currentStory) {
//            if (currentLocation > currentTask) {
//                // current Location der grösste Wert
//                [self performSegueWithIdentifier:@"segueStory" sender:self];
//            } else {
//                [self performSegueWithIdentifier:@"segueStory" sender:self];
//                // current Task der grösste Wert
//            }
//        } else if (currentTask > currentStory) {
//            [self performSegueWithIdentifier:@"segueStory" sender:self];
//            // current Task der grösste Wert
//        } else {
//            [self performSegueWithIdentifier:@"segueStory" sender:self];
//            // current currentStory der grösste Wert
//        }
//        if (currentStory == currentLocation && currentStory == currentTask) {
//            [self performSegueWithIdentifier:@"segueStory" sender:self];
//        }
//    }
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
