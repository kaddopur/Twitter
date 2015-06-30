//
//  TwitterClient.m
//  Twitter
//
//  Created by Jason Huang on 6/30/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "TwitterClient.h"

NSString * const kTwitterConsumerKey = @"pva14hI2FcMKTyuXU45JCSb1S";
NSString * const kTwitterConsumerSecret = @"Fydt9Ab1LzeoQmYKECnXL0LFxCstMdCdZgkjRJgCimsI3NUqMO";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@implementation TwitterClient

+ (TwitterClient *)sharedInstance {
    static TwitterClient *instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl]
                                                  consumerKey:kTwitterConsumerKey
                                               consumerSecret:kTwitterConsumerSecret];
        }
    });
    
    return instance;
}

@end
