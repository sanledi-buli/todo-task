//
//  TwitterAccountManager.h
//  todo-task
//
//  Created by MacBook Pro on 9/21/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterAccount.h"

@interface TwitterAccountManager : NSObject

+ (TwitterAccount *)newTwitterAccount;
+ (void)saveTwitterAccount:(TwitterAccount *)twitterAccount;
+ (NSArray *)getAllRecords;
+ (void)deleteAll;

@end
