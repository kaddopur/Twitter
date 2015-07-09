//
//  MentionsViewController.h
//  Twitter
//
//  Created by Jason Huang on 7/9/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MentionsViewController;

@protocol MentionsViewControllerDelegate <NSObject>

- (void)mentionsViewController:(MentionsViewController *)mentionsViewController didClickMenu:(NSDictionary *)params;

@end

@interface MentionsViewController : UIViewController

@property (weak, nonatomic) id<MentionsViewControllerDelegate> delegate;

@end
