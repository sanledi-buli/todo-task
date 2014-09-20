//
//  Twitter.h
//  todo-task
//
//  Created by MacBook Pro on 9/19/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Twitter : NSManagedObject

@property (nonatomic, retain) NSString * tweetBody;
@property (nonatomic, retain) NSString * tweetId;
@property (nonatomic, retain) NSDate * tweetDate;
@property (nonatomic, retain) NSNumber * countRetweet;
@property (nonatomic, retain) NSSet *replays;
@end

@interface Twitter (CoreDataGeneratedAccessors)

- (void)addReplaysObject:(NSManagedObject *)value;
- (void)removeReplaysObject:(NSManagedObject *)value;
- (void)addReplays:(NSSet *)values;
- (void)removeReplays:(NSSet *)values;

@end
