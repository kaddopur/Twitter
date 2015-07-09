//
//  ProfileViewController.h
//  Twitter
//
//  Created by Jason Huang on 7/9/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class ProfileViewController;

@protocol ProfileViewControllerDelegate <NSObject>

- (void)profileViewController:(ProfileViewController *)profileViewController didClickMenu:(NSDictionary *)params;

@end


@interface ProfileViewController : UIViewController

@property (weak, nonatomic) id<ProfileViewControllerDelegate> delegate;
@property (strong, nonatomic) User *currentUser;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *followingLabel;
@property (weak, nonatomic) IBOutlet UILabel *followersLabel;

@end
