//
//  FacebookManager.h
//  todo-task
//
//  Created by MacBook Pro on 9/24/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Facebook.h"

@interface FacebookManager : NSObject

+ (Facebook *)newStatus;
+ (void)saveStatus:(Facebook *)status;
+ (NSArray *)getAllRecords;
+ (Facebook *)getByStatusId:(NSString *)statusId;
+ (void)deleteAll;

@end
