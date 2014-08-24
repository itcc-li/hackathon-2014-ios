//
//  UserInputTaskViewController.h
//  Hackathon2014
//
//  Created by Yannick Hutter on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaskObservable.h"

@interface UserInputTaskViewController : UIViewController <TaskObservable>
@property (weak, nonatomic) IBOutlet UITextField *txtUserInput;
- (IBAction)didEndOnExitAction:(id)sender;

- (IBAction)btnConfirmAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;

- (void) showWithTask:(Task*)task;

@end
