//
//  NewTweetViewController.h
//  Twitter
//
//  Created by Jason Huang on 7/1/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewTweetViewController : UIViewController

- (IBAction)onCancel:(id)sender;
- (IBAction)onTweet:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
