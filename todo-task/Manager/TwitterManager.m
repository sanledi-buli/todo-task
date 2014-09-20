//
//  TwitterManager.m
//  todo-task
//
//  Created by MacBook Pro on 9/19/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "TwitterManager.h"
#import "AppDelegate.h"

@implementation TwitterManager

+ (Twitter *)newTweet{
    NSManagedObjectContext * managedObjectContext = [((AppDelegate *) [[UIApplication sharedApplication] delegate]) managedObjectContext];
    Twitter *tweet = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Twitter class]) inManagedObjectContext:managedObjectContext];
    [self saveTweet:tweet];
    return tweet;
}

+ (void)saveTweet:(Twitter *)tweet{
    NSError *error;
    if (![[tweet managedObjectContext] save:&error]) {
        NSLog(@"In %@,\nerror: %@\n(%@)",
              NSStringFromClass([self class]),
              [error localizedDescription],
              [error localizedFailureReason]);
    }
}

+ (NSArray *)getAllRecords{
    NSManagedObjectContext * managedObjectContext = [((AppDelegate *) [[UIApplication sharedApplication] delegate]) managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([Twitter class]) inManagedObjectContext:managedObjectContext];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:NSStringFromSelector(@selector(tweetDate)) ascending:YES];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSError *error;
    NSArray *tweets = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!tweets) {
        NSLog(@"%@", [error localizedDescription]);
        return nil;
    } else if(tweets && [tweets count] > 0){
        NSLog(@"Twitter count is %lu",(unsigned long) [tweets count]);
        return tweets;
    }else{
        NSLog(@"No record in %@",NSStringFromClass([Twitter class]));
    }
    return nil;
}

+ (void)deleteTweet:(Twitter *)tweet{
    NSManagedObjectContext *context = tweet.managedObjectContext;
    [context deleteObject:tweet];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"%@", error.localizedDescription);
    }
}

+ (void)deleteAll{
    NSArray *tweets = [self getAllRecords];
    for (Twitter *tweet in tweets){
        [self deleteTweet:tweet];
    }
}

@end
