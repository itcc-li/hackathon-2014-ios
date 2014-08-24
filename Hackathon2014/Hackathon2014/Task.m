//
//  Task.m
//  Hackathon2014
//
//  Created by Yannick Hutter on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "Task.h"

@implementation Task
{
    NSString* _solution;
}

-(id) initWithPlistNamed:(NSString *) plistName AndIndex:(NSNumber*) index
{
    self = [super init];
    if (self)
    {
        // Get the plist file which contains the information about questions etc.
        NSString* plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
        NSArray* root = [[NSArray alloc] initWithContentsOfFile:plistPath];
        NSArray* tasks = (NSArray*) [root objectAtIndex:1];
        
        // Get the relevant tasks.
        NSDictionary* currentTaskInformation = (NSDictionary*) [tasks objectAtIndex:[index integerValue]];
        
        // Fill up values.
        self.ScoreCountCorrect = [currentTaskInformation objectForKey:@"scoreCountCorrect"];
        self.ScoreCountIncorrect = [currentTaskInformation objectForKey:@"scoreCountIncorrect"];
        self.Choices = (NSArray*)[currentTaskInformation objectForKey:@"choices"];
        self.Question = [currentTaskInformation objectForKey:@"question"];
        self.SolutionIndex = [currentTaskInformation objectForKey:@"solutionIndex"];
        self.Modul = [currentTaskInformation objectForKey:@"modul"];
    }
    return self;
}
@end
