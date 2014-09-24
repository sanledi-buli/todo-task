//
//  FacebookManager.m
//  todo-task
//
//  Created by MacBook Pro on 9/24/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "FacebookManager.h"
#import "AppDelegate.h"

@implementation FacebookManager

+ (Facebook *)newStatus{
    NSManagedObjectContext * managedObjectContext = [((AppDelegate *) [[UIApplication sharedApplication] delegate]) managedObjectContext];
    Facebook *status = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Facebook class]) inManagedObjectContext:managedObjectContext];
    return status;
}

+ (void)saveStatus:(Facebook *)status{
    NSError *error;
    if (![[status managedObjectContext] save:&error]) {
        NSLog(@"In %@,\nerror: %@\n(%@)",
              NSStringFromClass([self class]),
              [error localizedDescription],
              [error localizedFailureReason]);
    }
}

+ (NSArray *)getAllRecords{
    NSManagedObjectContext * managedObjectContext = [((AppDelegate *) [[UIApplication sharedApplication] delegate]) managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([Facebook class]) inManagedObjectContext:managedObjectContext];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:NSStringFromSelector(@selector(createdAt)) ascending:NO];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];
    NSError *error;
    NSArray *statuses = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!statuses) {
        NSLog(@"%@", [error localizedDescription]);
        return nil;
    } else if([statuses count] > 0){
        return statuses;
    }else{
        NSLog(@"No record in %@",NSStringFromClass([Facebook class]));
    }
    return nil;
}

+ (Facebook *)getByStatusId:(NSNumber *)statusId{
    NSManagedObjectContext * managedObjectContext = [((AppDelegate *) [[UIApplication sharedApplication] delegate]) managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:NSStringFromClass([Facebook class]) inManagedObjectContext:managedObjectContext];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"statusId = %@",statusId];
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entityDescription];
    [fetchRequest setPredicate:predicate];
    NSError *error;
    NSArray *statuses = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (!statuses) {
        NSLog(@"%@", [error localizedDescription]);
        return nil;
    }else if([statuses count] > 0){
        return [statuses lastObject];
    }
    return nil;
}

+ (void)deleteStatus:(Facebook *)status{
    NSManagedObjectContext *context = status.managedObjectContext;
    [context deleteObject:status];
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"%@", error.localizedDescription);
    }
}

+ (void)deleteAll{
    NSArray *statuses = [self getAllRecords];
    for (Facebook *status in statuses){
        [self deleteStatus:status];
    }
}

@end
