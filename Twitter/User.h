//
//  User.h
//  Twitter
//
//  Created by Jason Huang on 7/1/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSURL *profileImageURL;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (User *)currentUser;

+ (void)setCurrentUser:(User *)currentUser;

@end
