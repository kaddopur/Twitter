//
//  LoginViewController.m
//  Twitter
//
//  Created by Jason Huang on 6/30/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"twittercjhuang://oauth"] scope:nil success:^(BDBOAuth1Credential *requestToken) {
        NSLog(@"request token %@", requestToken);
        
        NSURL *authURL = [NSURL URLWithString: [NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        
        
        NSLog(@"%@", authURL);
        [[UIApplication sharedApplication] openURL:authURL];
    }
  failure:^(NSError *error) {
        NSLog(@"failed to get request token");
    }];
}

@end
