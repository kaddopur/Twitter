//
//  NewTweetViewController.m
//  Twitter
//
//  Created by Jason Huang on 7/1/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "NewTweetViewController.h"
#import "UIImageVIew+AFNetworking.h"
#import "User.h"

@interface NewTweetViewController ()

@end

@implementation NewTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *user = [User currentUser];
    
    [self updateViewWithUser:user];
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Helpers

- (void)updateViewWithUser:(User *)user {
    self.nameLabel.text = user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", user.screenName];
    self.textView.text = @"";
    [self.imageView setImageWithURL:user.profileImageURL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onTweet:(id)sender {
}
@end
