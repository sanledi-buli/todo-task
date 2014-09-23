//
//  TweetDetailsController.h
//  todo-task
//
//  Created by MacBook Pro on 9/23/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "ApplicationController.h"
#import "TwitterDetailsTableViewCell.h"

@interface TweetDetailsController : ApplicationController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tweetDetailsTableView;

@end
