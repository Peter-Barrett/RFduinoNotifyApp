//
//  PBViewController.h
//  Notify
//
//  Created by Peter Barrett on 07/12/2013.
//  Copyright (c) 2013 Peter Barrett. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RFduino.h>
#import <RfduinoManager.h>
#import <RFduinoManagerDelegate.h>

@interface PBViewController : UIViewController <RFduinoDelegate,RFduinoManagerDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *rfduinoProximityLabel;
@property (strong, nonatomic) IBOutlet UILabel *rfDuinoLabel;
@property (strong, nonatomic) IBOutlet UIButton *twitterButton;
@property (strong, nonatomic) IBOutlet UIButton *rfduinoConnectButton;
@property (strong, nonatomic) IBOutlet UILabel *tweetsLabel;
- (IBAction)twitterButtonPressed:(id)sender;
- (IBAction)connectToRFduinoPressed:(id)sender;
- (IBAction)stopStreamPressed:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tweetTableView;

@end
