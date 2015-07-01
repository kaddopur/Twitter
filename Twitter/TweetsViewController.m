//
//  TweetsViewController.m
//  Twitter
//
//  Created by Jason Huang on 7/1/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "TweetsViewController.h"
#import "TwitterClient.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "Tweet.h"
#import "UIImageVIew+AFNetworking.h"

@interface TweetsViewController ()

@property (strong, nonatomic) NSArray *tweets;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 54.0;
    
    self.tweets = @[];
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.tableView reloadData];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:NO];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    Tweet *tweet = self.tweets[indexPath.row];
    
    cell.nameLabel.text = tweet.user.name;
    cell.screenNameLabel.text = tweet.user.screenName;
    cell.tweetTextLabel.text = tweet.text;
    [cell.profileImage setImageWithURL:tweet.user.profileImageURL];
    cell.createdAtLabel.text = [Tweet timeAgoStringWith:tweet];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onSignout:(id)sender {
    [[TwitterClient sharedInstance] signOut];
    
    LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
