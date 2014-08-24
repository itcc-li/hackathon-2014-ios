//
//  UserInputTaskViewController.m
//  Hackathon2014
//
//  Created by Yannick Hutter on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "UserInputTaskViewController.h"
#import "Task.h"
#import "UserScoreHelper.h"

@interface UserInputTaskViewController ()

@end

@implementation UserInputTaskViewController {
    NSMutableArray* _taskObservers;
    Task* _currentTask;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        _taskObservers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
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

- (IBAction)didEndOnExitAction:(id)sender {
    [self resignFirstResponder];
}

- (IBAction)btnConfirmAction:(id)sender {
    
    
    if ([self isAnswerValid]) {
        
        [UserScoreHelper updateUserScoreWithValue:_currentTask.ScoreCountCorrect];
        
        for (id observer in _taskObservers) {
            [observer taskIsCompleted:_currentTask WithScore:[UserScoreHelper getCurrentUserScore]];
        }
    }
    else {
        [UserScoreHelper updateUserScoreWithValue:_currentTask.ScoreCountIncorrect];
        for (id observer in _taskObservers) {
            [observer taskIsFailed:_currentTask WithScore:[UserScoreHelper getCurrentUserScore]];
        }
        
        
    }
    
    
}

- (void) showWithTask:(Task *)task
{
    _currentTask = task;
}

- (BOOL) isAnswerValid
{
    NSString* correctAnswer = [_currentTask.Choices objectAtIndex:[_currentTask.SolutionIndex integerValue]];
    
    if ([self.txtUserInput.text length] == 0) {
        return NO;
    }
    return [self.txtUserInput.text isEqualToString:correctAnswer];
}

- (void) SubscribeTaskObserver:(id<TaskObserver>)observer
{
    if (![_taskObservers containsObject:observer]) {
        [_taskObservers addObject:observer];
    }
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if (touch.phase == UITouchPhaseBegan) {
        [self.txtUserInput resignFirstResponder];
    }
}
- (void) UnsubscribeTaskObserver:(id<TaskObserver>)observer
{
    if ([_taskObservers containsObject:observer]) {
        [_taskObservers removeObject:observer];
    }
}
@end
