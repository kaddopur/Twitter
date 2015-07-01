//
//  TwitterClient.h
//  Twitter
//
//  Created by Jason Huang on 6/30/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

@property (strong, nonatomic) void (^loginCompletion)(User *user, NSError *error);

+ (TwitterClient *)sharedInstance;

- (void)loginWithCompletion:(void (^)(User *user, NSError *error))completion;

- (void)signOut;

- (void)openURL:(NSURL *)url;

@end
