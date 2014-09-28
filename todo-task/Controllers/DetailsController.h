//
//  TweetDetailsController.h
//  todo-task
//
//  Created by MacBook Pro on 9/23/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "ApplicationController.h"
#import "DetailsTableViewCell.h"

@interface DetailsController : ApplicationController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *detailsTableView;

@end
