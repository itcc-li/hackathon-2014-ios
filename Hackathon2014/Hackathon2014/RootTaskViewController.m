//
//  TaskViewController.m
//  Hackathon2014
//
//  Created by Yannick Hutter on 22/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "RootTaskViewController.h"

#import "MultipleChoiceTaskViewController.h"
#import "UserInputTaskViewController.h"
#import "UserScoreHelper.h"
#import "Constants.h"


@interface RootTaskViewController ()

@end

@implementation RootTaskViewController {
    
    // Private instance members
    
    NSNumber* _currentTaskNumber;                                           // The current task number.
    MultipleChoiceTaskViewController* _multipleChoiceTaskViewController;    // Represents the multiple choice question.
    UserInputTaskViewController* _userInputTaskViewController;              // Represents a user input question.
    Task* _currentTask;                                                     // The currently active task.
    NSNumber* _numberOfTasks;                                               // The total numbers of tasks.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Enable disable necessary gui elements.
    self.nextButton.enabled = NO;
    _multipleChoiceTaskViewController.btnConfirm.enabled = YES;
    _multipleChoiceTaskViewController.Choices.enabled = YES;
    _userInputTaskViewController.txtUserInput.enabled = YES;
    _userInputTaskViewController.btnConfirm.enabled = YES;
    
    // The path to the data plist which contains various questions and other app related data.
    NSString* plistPath = [[NSBundle mainBundle] pathForResource:@"tour1" ofType:@"plist"];
    NSArray* root = [[NSArray alloc] initWithContentsOfFile:plistPath];
    NSArray* tasks = (NSArray*) [root objectAtIndex:1];
    
    // The number of tasks. The current task is zero based.
    _numberOfTasks = [[NSNumber alloc] initWithInteger:[tasks count] - 1];
    
    // Get necessary view controllers.
    _multipleChoiceTaskViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"multipleChoiceTaskViewController"];
    _userInputTaskViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"userInputTaskViewController"];
    
    // Register to sub view controllers so that we now when a task is completed.
    [_multipleChoiceTaskViewController SubscribeTaskObserver:self];
    [_userInputTaskViewController SubscribeTaskObserver:self];
    
    // Show first pending task.
    [self showWithCurrentTaskNumber];
}


- (void) viewDidDisappear:(BOOL)animated
{
    // Unregister from sub view controllers.
    [_multipleChoiceTaskViewController UnsubscribeTaskObserver:self];
    [_userInputTaskViewController UnsubscribeTaskObserver:self];
}


- (IBAction)btnNextAction:(id)sender {
    [self performSegueWithIdentifier:@"segueLocation" sender:self];
}

//
// Updates the task progressbar with the given task count.
//
- (void) updateTaskProgressWithCurrentTaskCount:(NSNumber*) taskCount
{
    float currentProgress = (1.0f / ([_numberOfTasks integerValue])) * ([taskCount integerValue]+1);
    [self.taskProgressBar setProgress:currentProgress animated:YES];
}

-(void) showWithCurrentTaskNumber
{
    NSNumber* currentTaskNumber = [[NSUserDefaults standardUserDefaults] valueForKey:kCurrentTaskNumber];
    
    // Update progress bar
    [self updateTaskProgressWithCurrentTaskCount:currentTaskNumber];
    
    // As long as we are in bounds of the numbers of pending tasks.
    if ([currentTaskNumber integerValue] <= [_numberOfTasks integerValue]) {
        
        // Get the pending task.
        _currentTask = [[Task alloc] initWithPlistNamed:@"tour1" AndIndex:currentTaskNumber];
        
        // Set task question.
        self.TaskQuestion.text = _currentTask.Question;
        
        // Check of which type of task it is.
        if ([_currentTask.Modul isEqualToString:kModuleMultipleChoice]) {
            [self.TaskContent addSubview:_multipleChoiceTaskViewController.view];
            [_multipleChoiceTaskViewController showWithTask:_currentTask];
        }
        
        else if ([_currentTask.Modul isEqualToString:KModuleUserInput])
        {
            [self.TaskContent addSubview:_userInputTaskViewController.view];
            [_userInputTaskViewController showWithTask:_currentTask];
        }
    }
    else {
        // No pending tasks we are finished.
        [self performSegueWithIdentifier:@"segueGamecenter" sender:self];
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//
// Updates the user information according to the given score and success state.
//
- (void) updateUserInfoWithScore:(NSNumber*)score AndSuccess:(BOOL) success
{
    if (success) {
        self.lblUserInfo.textColor = [[UIColor alloc] initWithRed:0.478f green:0.709f blue:0.105f alpha:1.0f];
        self.lblUserInfo.text = [[NSString alloc] initWithFormat:@"Richtig, Punkte: %@", score];
    }
    else {
        self.lblUserInfo.text = [[NSString alloc] initWithFormat:@"Falsch, Punkte: %@", score];
    }
}


//
// Implemented TaskObserver Methods
//

-(void) taskIsCompleted:(Task*)completedTask WithScore:(NSNumber*) score
{
    
    // Update the user information.
    self.lblUserInfo.hidden = NO;
    
    // Get next pending task.
    NSNumber* currentTaskNumber = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentTaskNumber];
    NSInteger newTaskNumber = [currentTaskNumber integerValue];
    newTaskNumber++;
    
    // Set up gui elements.
    self.nextButton.enabled = YES;
    _multipleChoiceTaskViewController.btnConfirm.enabled = NO;
    _multipleChoiceTaskViewController.Choices.enabled = NO;
    _userInputTaskViewController.txtUserInput.enabled = NO;
    _userInputTaskViewController.btnConfirm.enabled = NO;
    
    // Save current task number and current score.
    [[NSUserDefaults standardUserDefaults] setObject:[[NSNumber alloc] initWithInteger:newTaskNumber]forKey:kCurrentTaskNumber];
    [self updateUserInfoWithScore:[UserScoreHelper getCurrentUserScore] AndSuccess:YES];
}

-(void) taskIsFailed:(Task *)failedTask WithScore:(NSNumber *)score
{
    // Update the user information.
    self.lblUserInfo.hidden = NO;
    [self updateUserInfoWithScore:[UserScoreHelper getCurrentUserScore] AndSuccess:NO];
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
