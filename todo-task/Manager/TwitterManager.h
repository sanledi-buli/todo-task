//
//  TwitterManager.h
//  todo-task
//
//  Created by MacBook Pro on 9/19/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Twitter.h"

@interface TwitterManager : NSObject

+ (Twitter *)newTweet;
+ (void)saveTweet:(Twitter *)tweet;
+ (NSArray *)getAllRecords;
+ (void)deleteAll;



@end
