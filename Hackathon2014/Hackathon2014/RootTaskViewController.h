//
//  TaskViewController.h
//  Hackathon2014
//
//  Created by Yannick Hutter on 22/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObserver.h"

@interface RootTaskViewController : UIViewController <TaskObserver>
{
    
}
// Public properties
@property (weak, nonatomic) IBOutlet UILabel * TaskQuestion;            // Question of a task.
@property (weak, nonatomic) IBOutlet UIView *TaskContent;               // Custom content of the task for various question types
@property (weak, nonatomic) IBOutlet UILabel *lblUserInfo;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextButton;

- (IBAction)btnNextAction:(id)sender;                                   // Action for the next button in the tool bar.
@property (weak, nonatomic) IBOutlet UIProgressView *taskProgressBar;


//
// Shows the custom task content with the current task number.
// The current task number is saved in NSUserDefaults for simplicity reasons.
//
-(void) showWithCurrentTaskNumber;
@end
