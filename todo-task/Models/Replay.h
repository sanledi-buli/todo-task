//
//  Replay.h
//  todo-task
//
//  Created by MacBook Pro on 9/19/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Twitter;

@interface Replay : NSManagedObject

@property (nonatomic, retain) NSString * replayBody;
@property (nonatomic, retain) Twitter *twitter;

@end
