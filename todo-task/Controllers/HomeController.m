//
//  HomeController.m
//  todo-task
//
//  Created by MacBook Pro on 9/18/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "HomeController.h"
#import "MFSideMenu.h"
#import "TwitterManager.h"
#import "TwitterAccountManager.h"
#import "FacebookManager.h"
#import "WebServiceController.h"

@interface HomeController (){
    NSString *currentPage;
}
@end

@implementation HomeController

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
    WebServiceController *webServiceController = [[WebServiceController alloc] init];
    if ([[defaults objectForKey:@"currentPage"] isEqualToString:@"twitter"]) {
        currentPage = @"twitter";
        [webServiceController getTweets];
        [webServiceController getTwitterAccountDetails];
    } else if([[defaults objectForKey:@"currentPage"] isEqualToString:@"facebook"]) {
        currentPage = @"facebook";
         [webServiceController getStatusFB];
    }else{
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* pragma table view */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([currentPage isEqualToString:@"twitter"]) {
        return [[TwitterManager getAllRecords] count];
    }else if ([currentPage isEqualToString:@"facebook"]){
        return [[FacebookManager getAllRecords] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *homeCellIdentifier = @"homeTableViewCell";
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeCellIdentifier];
    if ([currentPage isEqualToString:@"twitter"]) {
        NSArray *tweets = [TwitterManager getAllRecords];
        Twitter *tweet = [tweets objectAtIndex:indexPath.row];
        [defaults setObject:tweet.tweetBody forKey:@"currenContent"];
        [defaults synchronize];
        TwitterAccount *twitterAccount = [[TwitterAccountManager getAllRecords] lastObject];
        
        [cell.userName setText:twitterAccount.accountName];
        [cell.screenName setText:[NSString stringWithFormat:@"@%@",TWITTER_SCREEN_NAME]];
        cell.mainContent.lineBreakMode = NSLineBreakByWordWrapping;
        cell.mainContent.numberOfLines = 0;
        [cell.mainContent setText:tweet.tweetBody];
        [cell.dateCreated setText:[self dateFormatter:tweet.tweetDate]];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:twitterAccount.accountProfilePicture]];
        [cell.profilePicture setImage:[UIImage imageWithData:imageData]];
        [cell.replyBtn setImage:[UIImage imageNamed:@"reply-icon.png"] forState:UIControlStateNormal];
        [cell.replyBtn addTarget:self action:@selector(replyTweet:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
        [cell.replyBtn setTitle:@"" forState:UIControlStateNormal];
        [cell.likeBtn setImage:[UIImage imageNamed:@"retweet-128.png"] forState:UIControlStateNormal];
        [cell.likeBtn addTarget:self action:@selector(reTweet:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
        [cell.likeBtn setTitle:@"" forState:UIControlStateNormal];
    } else if([currentPage isEqualToString:@"facebook"]) {
        NSArray *statuses = [FacebookManager getAllRecords];
        Facebook *status = [statuses objectAtIndex:indexPath.row];
        [defaults setObject:status.statusFB forKey:@"currentContent"];
        [defaults synchronize];
        
        [cell.userName setText:status.accountFB];
        [cell.screenName setText:@""];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:FACEBOOK_PROFILE_PICTURE]];
        [cell.profilePicture setImage:[UIImage imageWithData:imageData]];
        cell.mainContent.lineBreakMode = NSLineBreakByWordWrapping;
        cell.mainContent.numberOfLines = 0;
        [cell.mainContent setText:status.statusFB];
        [cell.dateCreated setText:[self dateFormatter:status.createdAt]];
        [cell.replyBtn addTarget:self action:@selector(commentStatus:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
        [cell.likeBtn addTarget:self action:@selector(likeStatus:) forControlEvents:(UIControlEvents)UIControlEventTouchDown];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([currentPage isEqualToString:@"twitter"]) {
        Twitter *tweet = [[TwitterManager getAllRecords] objectAtIndex:indexPath.row];
        [defaults setObject:tweet.tweetId forKey:@"currentTweet"];
        [defaults synchronize];
        [self performSegueWithIdentifier:@"twitterDetails" sender:self];
    }
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

- (IBAction)menuTapped:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

@end
