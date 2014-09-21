//
//  TwitterAccount.h
//  todo-task
//
//  Created by MacBook Pro on 9/21/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TwitterAccount : NSManagedObject

@property (nonatomic, retain) NSString * accountName;
@property (nonatomic, retain) NSString * accountProfilePicture;

@end
