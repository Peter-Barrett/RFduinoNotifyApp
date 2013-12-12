//
//  PBViewController.m
//  Notify
//
//  Created by Peter Barrett on 07/12/2013.
//  Copyright (c) 2013 Peter Barrett. All rights reserved.
//

#import "PBViewController.h"
#import "PBTwitterTableCell.h"
#import <STTwitter.h>
#import "PBTweetObject.h"

#define CONSUMER_KEY @"qxRIrj41XkJxENzJB0PICQ"
#define CONSUMER_SECRET @"CMATUbPniUuVEPnm4yeno4NYrkQYeucoiHllu6E8Gk"
#define AUTH_TOKEN @"42272508-qTWCRcD2t0JHjcSfjbJXmpZEEV3whvO9eKwQHzM6t"
#define AUTH_SECRET @"553Xf4BFyhxvbTt1SSJcVpVcAPNR9dGjgyDbDC0U7hDOI"

@interface PBViewController (){
    id stream;
}
@property (nonatomic, strong) STTwitterAPI *twitterConnection;
@property (nonatomic, strong) RFduino *rfduino;
@property (nonatomic, strong) RFduinoManager *manager;
@property (nonatomic, strong) NSMutableArray * tweets;
@property BOOL rfduinoConnected, twitterConnected;
@end

@implementation PBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.tweetTableView.dataSource = self;
    self.tweetTableView.delegate = self;
    self.tweets = [[NSMutableArray alloc] init];
    self.rfduinoConnected = false;
    self.twitterConnected = false;
    [self.rfduino setDelegate:self];
    self.manager = [RFduinoManager sharedRFduinoManager];
    [self.manager setDelegate:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)streamTweets{
    [_twitterConnection verifyCredentialsWithSuccessBlock:^(NSString *username) {
        NSLog(@"Stream Started");
        self.tweetsLabel.text = @"Revieving Tweets";
        id request = [_twitterConnection getUserStreamDelimited:[NSNumber numberWithBool:false] stallWarnings:[NSNumber numberWithBool:false]includeMessagesFromFollowedAccounts:nil includeReplies:[NSNumber numberWithBool:false] keywordsToTrack:nil locationBoundingBoxes:nil progressBlock:^(id response) {
            PBTweetObject * tweet = [PBTweetObject tweetFromJSON:(NSDictionary *)response];
            [self.tweets insertObject:tweet atIndex:0];
            [self.tweetTableView reloadData];
            [self sendDataToRFduino:1];
        } stallWarningBlock:^(NSString *code, NSString *message, NSUInteger percentFull) {
            NSLog(@"%@",message);
        } errorBlock:^(NSError *error) {
            NSLog(@"ERROR %@", [error localizedDescription]);
        }];
        stream = request;
    } errorBlock:^(NSError *error) {
        NSLog(@"ERROR %@", [error localizedDescription]);
    }];
    
}

- (IBAction)twitterButtonPressed:(id)sender {
    self.twitterConnection = [STTwitterAPI twitterAPIWithOAuthConsumerKey:CONSUMER_KEY
                            consumerSecret:CONSUMER_SECRET
                            oauthToken:AUTH_TOKEN
                            oauthTokenSecret:AUTH_SECRET
                            ];
    
    [self streamTweets];
}

- (IBAction)connectToRFduinoPressed:(id)sender {
    [self.manager connectRFduino:self.rfduino];
    self.rfDuinoLabel.text = [NSString stringWithFormat:@"Connected to %@",self.rfduino.name];
    
}

- (IBAction)stopStreamPressed:(id)sender {
    if(stream){
        [stream cancel];
    }
}

- (void)didDiscoverRFduino:(RFduino *)rfduino{
    self.rfduino = rfduino;
    self.rfduinoProximityLabel.text = @"RFduino Nearby";
}

-(void)didConnectRFduino:(RFduino *)rfduino{
    NSLog(@"CONNECTED to %@",rfduino.name);
}

-(void)sendDataToRFduino:(uint8_t)message{
    uint8_t tx[1] = {message};
    NSData *data = [NSData dataWithBytes:(void*)&tx length:1];
    [self.rfduino send:data];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tweets count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PBTwitterTableCell *cell = (PBTwitterTableCell *)[self.tweetTableView dequeueReusableCellWithIdentifier:@"TwitterTableCell"];
    if(cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"twitterTableCell" owner:self options:nil];
        cell = (PBTwitterTableCell *)[nib objectAtIndex:0];
    }
    
    PBTweetObject *tweet = self.tweets[indexPath.row];
    cell.fromLabel.text = tweet.name;
    cell.usersImage.image =  tweet.profileImage;
    cell.tweetTextLabel.text = tweet.tweet;
    return cell;
}


@end
