//
//  ApplicationController.m
//  todo-task
//
//  Created by MacBook Pro on 9/18/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "ApplicationController.h"

@interface ApplicationController ()

@end

@implementation ApplicationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* pragma date */

- (NSString *)dateFormatter:(NSDate *)sourceDate{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Jakarta"]];
    [dateFormat setDateFormat:@"dd/MM/YYYY HH:mm:ss"];
    NSString *stringFromDate = [dateFormat stringFromDate:sourceDate];
    return stringFromDate;
}

/* pragma selector action */

- (IBAction)replyTweet:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reply" message:@"Please enter text to replay." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (IBAction)reTweet:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Retweet" message:@"Do you want retweet this tweet ?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    [alert show];
}

- (IBAction)commentStatus:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Comment" message:@"Please enter text to comment." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (IBAction)likeStatus:(id)sender{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Like" message:@"Do you want to like this status ?" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Cancel", nil];
    [alert show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
