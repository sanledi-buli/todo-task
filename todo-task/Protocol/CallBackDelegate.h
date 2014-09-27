//
//  CallBackDelegate.h
//  todo-task
//
//  Created by MacBook Pro on 9/27/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CallBackDelegate <NSObject>
@optional

- (void)afterSave;

@end
