//
//  TweetDetailsViewController.m
//  Twitter
//
//  Created by Jason Huang on 7/1/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageVIew+AFNetworking.h"

@interface TweetDetailsViewController ()

@end

@implementation TweetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self defaultViewWithTweet];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View Helpers

- (void)defaultViewWithTweet {
    self.nameLabel.text = self.tweet.user.name;
    self.screenNameLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    [self.profileImage setImageWithURL:self.tweet.user.profileImageURL];
    
    self.textView.text = self.tweet.text;
    [self.textView setFont:[UIFont systemFontOfSize:15]];
    [self.textView layoutIfNeeded];
    [self.textView updateConstraints];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
