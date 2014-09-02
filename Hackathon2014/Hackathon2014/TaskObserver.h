//
//  TaskObserver.h
//  Hackathon2014
//
//  Created by Yannick Hutter on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Task.h"

@protocol TaskObserver <NSObject>
@required
-(void) taskIsCompleted:(Task*)completedTask WithScore:(NSNumber*) score;
-(void) taskIsFailed:(Task*)failedTask WithScore:(NSNumber*) score;
@end
