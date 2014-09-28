//
//  HomeController.h
//  todo-task
//
//  Created by MacBook Pro on 9/18/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import "ApplicationController.h"
#import "HomeTableViewCell.h"

@interface HomeController : ApplicationController<UITableViewDelegate,UITableViewDataSource,CallBackDelegate>
@property (weak, nonatomic) IBOutlet UITableView *homeTableView;

- (IBAction)menuTapped:(id)sender;

@end
