//
//  Task.h
//  Hackathon2014
//
//  Created by Yannick Hutter on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// Represents a Task that the user must complete in order to advance
// in the story.
//
@interface Task : NSObject

// Public instance members
@property (strong, nonatomic) NSString* Question;               // The question.
@property (strong, nonatomic) NSString* Modul;                  // The type of question.
@property (strong, nonatomic) NSArray* Choices;                 // The choices.
@property (strong, nonatomic) NSNumber* SolutionIndex;          // The index of the solution inside the choices.
@property (strong, nonatomic) NSNumber* ScoreCountCorrect;      // The score count for a correct answer.
@property (strong, nonatomic) NSNumber* ScoreCountIncorrect;    // The score count for an incorrect answer.

//
// Inits a task from a given plist with a given info for the task inside the plist.
//
-(id) initWithPlistNamed:(NSString *) plistName AndIndex:(NSNumber*) index;
@end
