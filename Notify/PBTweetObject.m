//
//  PBTweetObject.m
//  Notify
//
//  Created by Peter Barrett on 12/12/2013.
//  Copyright (c) 2013 Peter Barrett. All rights reserved.
//

#import "PBTweetObject.h"

@implementation PBTweetObject
+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"name": @"user.name",
             @"tweet": @"text",
             @"profileImageUrl": @"user.profile_image_url"
             };
}

+ (id) tweetFromJSON:(NSDictionary *)json {
    NSError *error;
    PBTweetObject *tweet = [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:json error:&error];
    
    
    tweet.profileImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tweet.profileImageUrl]]];
    if(error != nil) {
        NSLog(@"Error parsing JSON: %@", error);
        return nil;
    }
    return tweet;
}

@end
