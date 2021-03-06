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
#import "TwitterClient.h"

@interface NewTweetViewController ()

@end

@implementation NewTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User *user = [User currentUser];
    
    [self defaultViewWithUser:user];
    [self handleReplyInfo];
    
    self.textView.delegate = self;
    [self.textView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Helpers

- (void)defaultViewWithUser:(User *)user {
    self.nameLabel.text = user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", user.screenName];
    self.textView.text = @"";
    self.lengthLabel.text = @"140";
    [self.imageView setImageWithURL:user.profileImageURL];
}

- (void)handleReplyInfo {
    if (_replyInfo) {
        _textView.text = [NSString stringWithFormat:@"@%@ ", _replyInfo[@"author"]];
        _sendButton.title = @"Reply";
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    return textView.text.length - range.length + text.length <= 140;
}

- (void)textViewDidChange:(UITextView *)textView {
    self.lengthLabel.text = [NSString stringWithFormat:@"%ld", 140 - textView.text.length];
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
    if (self.textView.text.length == 0) {
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.textView.text forKey:@"status"];
    
    if (_replyInfo) {
        [params setObject:_replyInfo[@"replyTo"] forKey:@"in_reply_to_status_id"];
    }
    
    [[TwitterClient sharedInstance] updateStatusWithParams:params completion:^(Tweet *tweet, NSError *error) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
