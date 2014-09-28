//
//  ApplicationConfig.h
//  todo-task
//
//  Created by MacBook Pro on 9/28/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>

NSUserDefaults *defaults;

#define CURRENT_DEVICE() (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad?@"IPAD":@"NONIPAD")

// Twitter API
#define TWITTER_API_TIMELINE_URI @"https://api.twitter.com/1.1/statuses/user_timeline.json"
#define TWITTER_API_SHOW_URI @"https://api.twitter.com/1.1/users/show.json"
#define TWITTER_SCREEN_NAME @"7Langit"

// Facebook API
#define FACEBOOK_API_URI @"https://graph.facebook.com"
#define FACEBOOK_USER_ID @"177321525623964"
#define FACEBOOK_APP_ID @"577325145727529"
#define FACEBOOK_PROFILE_PICTURE @"http://graph.facebook.com/7Langit/picture"

@interface ApplicationConfig : NSObject

@end

@protocol CallBackDelegate <NSObject>

@optional
- (void) afterSync;

@end
