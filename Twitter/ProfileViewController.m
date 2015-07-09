//
//  ProfileViewController.m
//  Twitter
//
//  Created by Jason Huang on 7/9/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageVIew+AFNetworking.h"
#import "TwitterClient.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.currentUser) {
        self.currentUser = [User currentUser];
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:self.currentUser.screenName forKey:@"screen_name"];
    
    [[TwitterClient sharedInstance] showUserWithParams:params completion:^(User *user, NSError *error) {
        [self.profileImage setImageWithURL:user.profileImageURL];
        self.tweetsLabel.text = [NSString stringWithFormat:@"%ld", user.statusesCount];
        self.followingLabel.text = [NSString stringWithFormat:@"%ld", user.friendsCount];
        self.followersLabel.text = [NSString stringWithFormat:@"%ld", user.followersCount];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onMenuClick:(id)sender {
    [self.delegate profileViewController:self didClickMenu:nil];
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
