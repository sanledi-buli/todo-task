//
//  Boot.h
//  todo-task
//
//  Created by MacBook Pro on 9/18/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>

NSUserDefaults *defaults;

#define CURRENT_DEVICE() (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad?@"IPAD":@"NONIPAD")

// Twitter API
#define TWITTER_API_URI @"https://api.twitter.com/1.1/statuses/user_timeline.json"
#define TWITTER_SCREEN_NAME @"7Langit"

@interface Boot : NSObject

@end
