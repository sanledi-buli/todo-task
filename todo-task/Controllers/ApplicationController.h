//
//  ApplicationController.h
//  todo-task
//
//  Created by MacBook Pro on 9/18/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMProgressHUD.h"
#import "MMProgressHUDOverlayView.h"

@interface ApplicationController : UIViewController

- (NSString *)dateFormatter:(NSDate *)sourceDate;
- (void)showHUDProgress;
- (IBAction)replyTweet:(id)sender;
- (IBAction)reTweet:(id)sender;
- (IBAction)commentStatus:(id)sender;
- (IBAction)likeStatus:(id)sender;


@end
