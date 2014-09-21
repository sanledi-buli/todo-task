//
//  WebServiceController.m
//  todo-task
//
//  Created by MacBook Pro on 9/18/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "WebServiceController.h"
#import "WebService.h"

@interface WebServiceController ()

@end

@implementation WebServiceController

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* GET tweets */

- (void)getTweets
{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType
                                     options:nil
                                  completion:^(BOOL granted, NSError *error) {
                                      if (granted == YES) {
                                          NSLog(@"granted");
                                          NSArray *arrayOfAccounts = [account
                                                                      accountsWithAccountType:accountType];
                                          if ([arrayOfAccounts count] > 0) {
                                              ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                                              NSURL *requestURL = [NSURL URLWithString:TWITTER_API_TIMELINE_URI];
                                              NSDictionary *params = @{
                                                                       @"screen_name": TWITTER_SCREEN_NAME,
                                                                       @"include_rts": @"0",
                                                                       @"trim_user": @"1",
                                                                       @"count": @"100"
                                                                       };
                                              SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                                                          requestMethod:SLRequestMethodGET
                                                                                                    URL:requestURL
                                                                                             parameters:params];
                                              postRequest.account = twitterAccount;
                                              
                                              [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                                  NSArray *dataSource = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                                        options:NSJSONReadingMutableLeaves error:&error];
                                                  if (dataSource && [dataSource count] > 0) {
                                                      [WebService parserResourcesTwitter:dataSource];
                                                  }
                                              }];
                                          }
                                          else{
                                              NSLog(@"No account on accountStore");
                                          }
                                      }
                                      else{
                                          NSLog(@"Not granted");
                                      }
                                  }];
}

/* GET twitter account details */

- (void)getTwitterAccountDetails{
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [account requestAccessToAccountsWithType:accountType
                                     options:nil
                                  completion:^(BOOL granted, NSError *error) {
                                      if (granted == YES) {
                                          NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
                                          if ([arrayOfAccounts count] > 0) {
                                              ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                                              NSURL *requestURL = [NSURL URLWithString:TWITTER_API_SHOW_URI];
                                              NSDictionary *params = @{
                                                                       @"screen_name": TWITTER_SCREEN_NAME};
                                              SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:params];
                                              postRequest.account = twitterAccount;
                                              [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                                  NSDictionary *dataSource = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                                        options:NSJSONReadingMutableLeaves error:&error];
                                                  if (dataSource && [dataSource count] > 0) {
                                                      [WebService parserResourcesTwitterAccount:dataSource];
                                                  }
                                              }];
                                              
                                              
                                          } else {
                                              NSLog(@"No account on accountStore");
                                          }
                                      } else {
                                          NSLog(@"Not granted");
                                      }
                                      
                                  }];
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
