//
//  PBTweetObject.h
//  Notify
//
//  Created by Peter Barrett on 12/12/2013.
//  Copyright (c) 2013 Peter Barrett. All rights reserved.
//

#import "MTLModel.h"
#import <Mantle/Mantle.h>

@interface PBTweetObject : MTLModel <MTLJSONSerializing, NSCoding>
@property (strong, nonatomic) NSString * name;
@property (strong, nonatomic) NSString * tweet;
@property (strong, nonatomic) UIImage * profileImage;
@property (strong, nonatomic) NSString * profileImageUrl;

+ (id) tweetFromJSON:(NSDictionary *)json;
@end
