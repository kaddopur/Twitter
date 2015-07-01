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
    _nameLabel.text = _tweet.user.name;
    _screenNameLabel.text = [NSString stringWithFormat:@"@%@", _tweet.user.screenName];
    [_profileImage setImageWithURL:_tweet.user.profileImageURL];
    
    _textView.text = self.tweet.text;
    _textView.font = [UIFont systemFontOfSize:16];
    _constraintTextViewHeight.constant = ceilf([_textView sizeThatFits:CGSizeMake(_textView.frame.size.width, FLT_MAX)].height);
    
    [_textView layoutIfNeeded];
    [_textView updateConstraints];
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
