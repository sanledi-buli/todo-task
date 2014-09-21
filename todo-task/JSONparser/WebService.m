//
//  WebService.m
//  todo-task
//
//  Created by MacBook Pro on 9/19/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "WebService.h"
#import "TwitterManager.h"
#import "Twitter.h"
#import "TwitterAccountManager.h"
#import "TwitterAccount.h"

@interface WebService (){
    NSArray *resourceData;
}
@end

@implementation WebService

+ (void)parserResourcesTwitter:(NSArray *)dataSource{
    [TwitterManager deleteAll];
    for (id data in dataSource) {
        Twitter *tweet = [TwitterManager newTweet];
        [tweet setTweetBody:data[@"text"]];
        [tweet setTweetId:data[@"id_str"]];
        [tweet setTweetDate:[self toDate:data[@"created_at"]]];
        [tweet setCountRetweet:data[@"retweeted"]];
        [TwitterManager saveTweet:tweet];
    }
}

+ (void)parserResourcesTwitterAccount:(NSDictionary *)dataSource{
    [TwitterAccountManager deleteAll];
    TwitterAccount *twitterAccount = [TwitterAccountManager newTwitterAccount];
        [twitterAccount setAccountName:dataSource[@"name"]];
        [twitterAccount setAccountProfilePicture:dataSource[@"profile_image_url_https"]];
        [TwitterAccountManager saveTwitterAccount:twitterAccount];
}

+ (NSDate *)toDate:(id)createdAt{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:locale];
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"];
    NSDate *date = [dateFormatter dateFromString:createdAt];
    
    return date;
}

@end
