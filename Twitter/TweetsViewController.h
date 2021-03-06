//
//  TweetsViewController.h
//  Twitter
//
//  Created by Jason Huang on 7/1/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@class TweetsViewController;

@protocol TweetsViewControllerDelegate <NSObject>

- (void)tweetsViewController:(TweetsViewController *)tweetsViewController didClickMenu:(NSDictionary *)params;

@end


@interface TweetsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) id<TweetsViewControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)onSignout:(id)sender;

@end
