//
//  TaskObservable.h
//  Hackathon2014
//
//  Created by Yannick Hutter on 23/08/14.
//  Copyright (c) 2014 IT Crowd Club. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskObserver.h"

@protocol TaskObservable <NSObject>
- (void) SubscribeTaskObserver:(id<TaskObserver>) observer;
- (void) UnsubscribeTaskObserver:(id<TaskObserver>) observer;
@end
