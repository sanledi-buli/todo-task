//
//  Facebook.h
//  todo-task
//
//  Created by MacBook Pro on 9/24/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Facebook : NSManagedObject

@property (nonatomic, retain) NSString * statusFB;
@property (nonatomic, retain) NSString * accountFB;
@property (nonatomic, retain) NSDate * createdAt;
@property (nonatomic, retain) NSString * statusId;

@end
