//
//  ContainerViewController.h
//  Twitter
//
//  Created by Jason Huang on 7/9/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetsViewController.h"
#import "ProfileViewController.h"

@interface ContainerViewController : UIViewController <TweetsViewControllerDelegate, ProfileViewControllerDelegate>

- (void)setupProfile;
- (void)setupHomeTimeline;

@end
