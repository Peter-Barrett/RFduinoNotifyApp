//
//  PBTwitterTableCell.h
//  Notify
//
//  Created by Peter Barrett on 12/12/2013.
//  Copyright (c) 2013 Peter Barrett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PBTwitterTableCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *usersImage;
@property (strong, nonatomic) IBOutlet UILabel *fromLabel;
@property (strong, nonatomic) IBOutlet UILabel *tweetTextLabel;

@end
