//
//  Tweet.m
//  Twitter
//
//  Created by Jason Huang on 7/1/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "Tweet.h"


@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        self.text = dictionary[@"text"];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";

        self.createdAt = [formatter dateFromString:createdAtString];
    }
    
    return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];
    
    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
    }
    
    return tweets;
}

+ (NSString *)timeAgoStringWith:(Tweet *)tweet {
    NSDate *now = [NSDate date];
    NSTimeInterval ago = [now timeIntervalSinceDate:tweet.createdAt];
    
    if (ago > 86400) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"d/M/y";
        return [formatter stringFromDate:tweet.createdAt];
    } else if (ago > 3600) {
        return [NSString stringWithFormat:@"%dh", (int)ago/3600];
    } else if (ago > 60) {
        return [NSString stringWithFormat:@"%dm", (int)ago/60];
    } else {
        return @"just now";
    }
}

@end