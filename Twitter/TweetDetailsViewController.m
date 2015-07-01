//
//  TweetDetailsViewController.m
//  Twitter
//
//  Created by Jason Huang on 7/1/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "TweetDetailsViewController.h"
#import "UIImageVIew+AFNetworking.h"
#import "TwitterClient.h"

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
    
    _textView.text = _tweet.text;
    _textView.font = [UIFont systemFontOfSize:16];
    _constraintTextViewHeight.constant = ceilf([_textView sizeThatFits:CGSizeMake(_textView.frame.size.width, FLT_MAX)].height);
    
    _retweetsLabel.text = [NSString stringWithFormat:@"%ld",_tweet.retweetCount];
    _favoritesLabel.text = [NSString stringWithFormat:@"%ld",_tweet.favoriteCount];
    
    if (_tweet.retweeted) {
        [_retweetButton setImage:[UIImage imageNamed:@"retweet-on.png"] forState:UIControlStateNormal];
    } else {
        [_retweetButton setImage:[UIImage imageNamed:@"retweet-default.png"] forState:UIControlStateNormal];
    }
    
    if (_tweet.favorited) {
        [_favoriteButton setImage:[UIImage imageNamed:@"favorite-on.png"] forState:UIControlStateNormal];
    } else {
        [_favoriteButton setImage:[UIImage imageNamed:@"favorite-default.png"] forState:UIControlStateNormal];
    }
    
    
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

- (IBAction)onReply:(id)sender {
}

- (IBAction)onRetweet:(id)sender {
    _tweet.retweeted = !_tweet.retweeted;
    if (_tweet.retweeted) {
        [_retweetButton setImage:[UIImage imageNamed:@"retweet-on.png"] forState:UIControlStateNormal];
    } else {
        [_retweetButton setImage:[UIImage imageNamed:@"retweet-default.png"] forState:UIControlStateNormal];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:_tweet.IDStr forKey:@"id_str"];
    [[TwitterClient sharedInstance] retweetWithParams:params completion:^(Tweet *tweet, NSError *error) {}];
}

- (IBAction)onFavorite:(id)sender {
}
@end
