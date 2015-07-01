//
//  Tweet.h
//  Twitter
//
//  Created by Jason Huang on 7/1/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) User *user;
@property (assign, nonatomic) NSUInteger favoriteCount;
@property (assign, nonatomic) NSUInteger retweetCount;
@property (strong, nonatomic) NSDate *createdAt;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

@end
