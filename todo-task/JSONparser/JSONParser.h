//
//  WebService.h
//  todo-task
//
//  Created by MacBook Pro on 9/19/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterManager.h"
#import "TwitterAccountManager.h"
#import "FacebookManager.h"

@interface JSONParser : NSObject

+ (Twitter *)parserResourcesTwitter:(NSDictionary *)source;
+ (TwitterAccount *)parserResourcesTwitterAccount:(NSDictionary *)source;
+ (Facebook *)parserResourcesFacebookStatuses:(NSDictionary *)source;

@end
