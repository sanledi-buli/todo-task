//
//  WebService.h
//  todo-task
//
//  Created by MacBook Pro on 9/19/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebService : NSObject

+ (void)parserResourcesTwitter:(NSArray *)dataSource;
+ (void)parserResourcesTwitterAccount:(NSDictionary *)dataSource;
+ (void)parserResourcesFacebookStatuses:(NSDictionary *)dataSource;

@end
