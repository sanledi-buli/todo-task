//
//  WebService.m
//  todo-task
//
//  Created by MacBook Pro on 9/19/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "JSONParser.h"

@interface JSONParser ()
@end

@implementation JSONParser

+ (Twitter *)parserResourcesTwitter:(NSDictionary *)source{
    Twitter *tweet = [TwitterManager newTweet];
    [tweet setTweetBody:source[@"text"]];
    [tweet setTweetId:source[@"id_str"]];
    [tweet setTweetDate:[self toDate:source[@"created_at"] from:@"twitter"]];
    [tweet setCountRetweet:source[@"retweeted"]];
    return tweet;
}

+ (TwitterAccount *)parserResourcesTwitterAccount:(NSDictionary *)source{
    TwitterAccount *twitterAccount = [TwitterAccountManager newTwitterAccount];
    [twitterAccount setAccountName:source[@"name"]];
    [twitterAccount setAccountProfilePicture:source[@"profile_image_url_https"]];
    return twitterAccount;
}

+ (Facebook *)parserResourcesFacebookStatuses:(NSDictionary *)source{
    Facebook *status = [FacebookManager newStatus];
    [status setStatusFB:source[@"message"]];
    [status setStatusId:source[@"id"]];
    [status setAccountFB:source[@"from"][@"name"]];
    [status setCreatedAt:[self toDate:source[@"updated_time"] from:@"facebook"]];
    return status;
}

+ (NSDate *)toDate:(id)createdAt from:(NSString *)type{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:locale];
    [type isEqualToString:@"twitter"] ? [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss Z yyyy"] : [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZ"];
    
    NSDate *date = [dateFormatter dateFromString:createdAt];
    
    return date;
}

@end
