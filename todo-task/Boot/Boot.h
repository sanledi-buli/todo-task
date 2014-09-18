//
//  Boot.h
//  todo-task
//
//  Created by MacBook Pro on 9/18/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <Foundation/Foundation.h>

NSUserDefaults *defaults;

#define CURRENT_DEVICE() (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad?@"IPAD":@"NONIPAD")

@interface Boot : NSObject

@end
