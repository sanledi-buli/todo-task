//
//  TweetDetailsController.m
//  todo-task
//
//  Created by MacBook Pro on 9/23/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "TweetDetailsController.h"
#import "TwitterManager.h"
#import "TwitterAccountManager.h"

@interface TweetDetailsController ()

@end

@implementation TweetDetailsController

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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"twitterDetailsTableViewCell";
    TwitterDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    Twitter *tweet = [TwitterManager getByTweetId:[defaults objectForKey:@"currentTweet"]];
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
    
    return cell;
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
