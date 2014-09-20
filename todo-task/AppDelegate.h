//
//  AppDelegate.h
//  todo-task
//
//  Created by MacBook Pro on 9/18/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readwrite,strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readwrite,strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readwrite,strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;

@end
