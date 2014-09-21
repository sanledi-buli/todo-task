//
//  WebServiceController.h
//  todo-task
//
//  Created by MacBook Pro on 9/18/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "ApplicationController.h"
#import <Accounts/Accounts.h>
#import <Social/Social.h>

@interface WebServiceController : ApplicationController
- (void)getTweets;
- (void)getTwitterAccountDetails;
@end
