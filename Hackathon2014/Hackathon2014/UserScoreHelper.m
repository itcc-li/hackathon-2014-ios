//
//  UserScoreHelper.m
//  Hackathon2014
//
//  Created by Yannick Hutter on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import "UserScoreHelper.h"
#import "Constants.h"


@implementation UserScoreHelper
    

+(void) updateUserScoreWithValue:(NSNumber*) value
{
    // Get the current user score.
    NSNumber* currentUserScore = (NSNumber*) [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserScore];
    
    // Calculate the new user score.
    NSInteger newUserScore = [currentUserScore integerValue];
    newUserScore = newUserScore + [value integerValue];
    
    // Make the current user score the new user score.
    currentUserScore = [[NSNumber alloc] initWithInteger:newUserScore];
    
    // Save current user score.
    [[NSUserDefaults standardUserDefaults] setObject:currentUserScore forKey:kCurrentUserScore];
}

+(NSNumber*) getCurrentUserScore
{
    NSNumber* currentUserScore = (NSNumber*) [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserScore];
    return currentUserScore;
}
@end
