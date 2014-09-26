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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* GET tweets */

- (void)getTweets
{
    [self showHUDProgress];
    ACAccountStore *account = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [account
                                  accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [account requestAccessToAccountsWithType:accountType
                                     options:nil
                                  completion:^(BOOL granted, NSError *error) {
                                      if (granted) {
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
                                                  if (!error) {
                                                      NSArray *dataSource = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                                            options:NSJSONReadingMutableLeaves error:&error];
                                                      if ([dataSource count] > 0) {
                                                          [WebService parserResourcesTwitter:dataSource];
                                                          [MMProgressHUD dismissWithSuccess:@"Completed" title:nil afterDelay:3];
                                                      }
                                                  } else {
                                                      NSLog(@"%@",error);
                                                      [MMProgressHUD dismissWithError:[error localizedDescription] title:@"Failure" afterDelay:3];
                                                  }
                                              }];
                                          }
                                          else{
                                              [MMProgressHUD dismissWithError:@"No account available" title:@"Failure" afterDelay:3];
                                          }
                                      }
                                      else{
                                          [MMProgressHUD dismissWithError:@"Access Denied" title:@"Failure" afterDelay:3];
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
                                      if (granted) {
                                          NSArray *arrayOfAccounts = [account accountsWithAccountType:accountType];
                                          if ([arrayOfAccounts count] > 0) {
                                              ACAccount *twitterAccount = [arrayOfAccounts lastObject];
                                              NSURL *requestURL = [NSURL URLWithString:TWITTER_API_SHOW_URI];
                                              NSDictionary *params = @{
                                                                       @"screen_name": TWITTER_SCREEN_NAME};
                                              SLRequest *postRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:requestURL parameters:params];
                                              postRequest.account = twitterAccount;
                                              [postRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                                                  if (!error) {
                                                      NSDictionary *dataSource = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                                                 options:NSJSONReadingMutableLeaves error:&error];
                                                      if ([dataSource count] > 0) {
                                                          [WebService parserResourcesTwitterAccount:dataSource];
                                                      }
                                                  } else {
                                                      NSLog(@"==== Twitter Account API ====");
                                                      NSLog(@"[%@]",[error localizedDescription]);
                                                  }
                                              }];
                                              
                                              
                                          }
                                      }
                                  }];
}

/* GET Facebook status */

- (void)getStatusFB{
    [self showHUDProgress];
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountTypeFacebook =
    [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    NSDictionary *options = @{
                              ACFacebookAppIdKey: FACEBOOK_APP_ID,
                              ACFacebookPermissionsKey: @[@"read_stream",@"publish_actions"],
                              ACFacebookAudienceKey: ACFacebookAudienceFriends
                            };
    [accountStore requestAccessToAccountsWithType:accountTypeFacebook
                                          options:options
                                       completion:^(BOOL granted, NSError *error){
                                           if(granted){
                                               ACAccount *facebookAccount;
                                               NSArray *accounts = [accountStore accountsWithAccountType:accountTypeFacebook];
                                               if ([accounts count] > 0) {
                                                   facebookAccount = [accounts lastObject];
                                                   NSURL *feedURL = [NSURL
                                                                     URLWithString:[NSString
                                                                                    stringWithFormat:@"%@/%@/statuses?limit=10&access_token=%@",FACEBOOK_API_URI,FACEBOOK_USER_ID,facebookAccount.credential.oauthToken]];
                                                   
                                                   SLRequest *feedRequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                                                                               requestMethod:SLRequestMethodGET
                                                                                                         URL:feedURL
                                                                                                  parameters:nil];
                                                   [feedRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                                                    {
                                                        if (!error) {
                                                            NSDictionary *rawData = [NSJSONSerialization JSONObjectWithData:responseData
                                                                                                                    options:NSJSONReadingMutableLeaves
                                                                                                                      error:&error];
                                                            if (rawData) {
                                                                NSDictionary *sourceData = rawData[@"data"];
                                                                [WebService parserResourcesFacebookStatuses:sourceData];
                                                            }
                                                            [MMProgressHUD dismissWithSuccess:@"Completed" title:nil afterDelay:3];
                                                        } else {
                                                            [MMProgressHUD dismissWithError:[error localizedDescription] title:@"Failure" afterDelay:3];
                                                        }
                                                    }];
                                               } else {
                                                   [MMProgressHUD dismissWithError:@"No account available" title:nil afterDelay:3];
                                               }
                                        
                                           } else {
                                               [MMProgressHUD dismissWithError:@"Access Denied" title:@"Failure" afterDelay:3];
                                           }
                                       }
     ];
}

@end
