//
//  ProfileViewController.h
//  Twitter
//
//  Created by Jason Huang on 7/9/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ProfileViewController;

@protocol ProfileViewControllerDelegate <NSObject>

- (void)profileViewController:(ProfileViewController *)profileViewController didClickMenu:(NSDictionary *)params;

@end


@interface ProfileViewController : UIViewController

@property (weak, nonatomic) id<ProfileViewControllerDelegate> delegate;

@end
