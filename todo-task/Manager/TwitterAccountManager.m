//
//  TwitterAccountManager.m
//  todo-task
//
//  Created by MacBook Pro on 9/21/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "TwitterAccountManager.h"
#import "AppDelegate.h"

@implementation TwitterAccountManager

+ (TwitterAccount *)newTwitterAccount{
    NSManagedObjectContext * managedObjectContext = [((AppDelegate *) [[UIApplication sharedApplication] delegate]) managedObjectContext];
    TwitterAccount *twitterAccount = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([TwitterAccount class]) inManagedObjectContext:managedObjectContext];
    [self saveTwitterAccount:twitterAccount];
    return twitterAccount;
    
}

+ (void)saveTwitterAccount:(TwitterAccount *)twitterAccount{
    NSError *error;
    if (![[twitterAccount managedObjectContext] save:&error]) {
        NSLog(@"In %@,\nerror: %@\n(%@)",
              NSStringFromClass([self class]),
              [error localizedDescription],
              [error localizedFailureReason]);
    }
}

+ (NSArray *)getAllRecords{
    NSManagedObjectContext * managedObjectContext = [((AppDelegate *) [[UIApplication sharedApplication] delegate]) managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([TwitterAccount class]) inManagedObjectContext:managedObjectContext];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    NSError *error;
    NSArray *twitterAccounts = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!twitterAccounts) {
        NSLog(@"%@", [error localizedDescription]);
        return nil;
    } else if(twitterAccounts && [twitterAccounts count] > 0){
        return twitterAccounts;
    }else{
        NSLog(@"No record in %@",NSStringFromClass([TwitterAccount class]));
    }
    return nil;
}

+ (void)deleteTwitterAccount:(TwitterAccount *)twitterAccount{
    NSManagedObjectContext *context = twitterAccount.managedObjectContext;
    [context deleteObject:twitterAccount];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"%@", error.localizedDescription);
    }
}

+ (void)deleteAll{
    NSArray *twitterAccounts = [self getAllRecords];
    for (TwitterAccount *twitterAccount in twitterAccounts){
        [self deleteTwitterAccount:twitterAccount];
    }
}

@end
