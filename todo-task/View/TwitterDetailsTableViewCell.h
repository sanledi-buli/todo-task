//
//  TwitterDetailsTableViewCell.h
//  todo-task
//
//  Created by MacBook Pro on 9/23/14.
//  Copyright (c) 2014 Task. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *screenName;
@property (weak, nonatomic) IBOutlet UILabel *mainContent;
@property (weak, nonatomic) IBOutlet UIButton *replyBtn;
@property (weak, nonatomic) IBOutlet UIButton *likeBtn;
@property (weak, nonatomic) IBOutlet UILabel *dateCreated;

@end
