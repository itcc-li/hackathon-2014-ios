//
//  UserScoreHelper.h
//  Hackathon2014
//
//  Created by Yannick Hutter on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import <Foundation/Foundation.h>


//
// Class for handling the user score.
//
@interface UserScoreHelper : NSObject

//
// Updates the user score with a value.
//
+(void) updateUserScoreWithValue:(NSNumber*) value;

//
// Gets the current user score.
//
+(NSNumber*) getCurrentUserScore;
@end
