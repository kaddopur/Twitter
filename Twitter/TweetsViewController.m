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
#import "TweetDetailsViewController.h"
#import "NewTweetViewController.h"
#import "ProfileViewController.h"


@interface TweetsViewController ()

@property (strong, nonatomic) NSArray *tweets;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Pull to refresh
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:self.refreshControl];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];

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
    cell.screenNameLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    cell.tweetTextLabel.text = tweet.text;
    [cell.profileImage setImageWithURL:tweet.user.profileImageURL];
    cell.createdAtLabel.text = [Tweet timeAgoStringWith:tweet];
    
    // setup profile image click
    cell.profileImage.userInteractionEnabled = YES;
    cell.profileImage.tag = indexPath.row;

    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileClicked:)];
    tapped.numberOfTapsRequired = 1;
    [cell.profileImage addGestureRecognizer:tapped];
    
    return cell;
}

- (void)profileClicked:(id)sender {
    UITapGestureRecognizer *tapped = (UITapGestureRecognizer *)sender;
    Tweet *tweet = self.tweets[tapped.view.tag];
    
    [self performSegueWithIdentifier:@"segueToProfile" sender:tweet.user];
    
    NSLog(@"asdf %@", tweet.user.screenName);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"segueToTweetDetails" sender:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)refreshTable {
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        self.tweets = tweets;
        [self.refreshControl endRefreshing];
        [self.tableView reloadData];
    }];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueToTweetDetails"]) {
        TweetDetailsViewController *vc = segue.destinationViewController;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        vc.tweet = self.tweets[indexPath.row];
    }
    
    if ([segue.identifier isEqualToString:@"segueToProfile"]) {
        ProfileViewController *vc = segue.destinationViewController;

        vc.navigationItem.leftBarButtonItem = vc.navigationItem.backBarButtonItem;
        vc.currentUser = sender;
    }
}

- (IBAction)onSignout:(id)sender {
    [[TwitterClient sharedInstance] signOut];
    
    LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)onMenuClick:(id)sender {
    [self.delegate tweetsViewController:self didClickMenu:nil];
}

@end
