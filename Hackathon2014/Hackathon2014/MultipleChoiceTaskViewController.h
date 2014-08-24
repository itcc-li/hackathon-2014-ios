//
//  ExampleTaskViewController.h
//  Hackathon2014
//
//  Created by Yannick Hutter on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"
#import "TaskObservable.h"

//
// Represents a multiple choice task view controller.
//
@interface MultipleChoiceTaskViewController : UIViewController <TaskObservable>

// Public properties
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (strong, nonatomic) IBOutlet UISegmentedControl *Choices;

//
// Shows the view with a given task.
//
- (void) showWithTask:(Task*)task;

//
// Action for the confirm button.
//
- (IBAction)btnConfirmAction:(id)sender;

@end
