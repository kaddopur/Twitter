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

@interface TweetsViewController ()

@end

@implementation TweetsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    User *user = [User currentUser];
    
    NSLog(@"user from LoginViewController %@", user.name);
    NSLog(@"user from LoginViewController %@", user.screenName);
    NSLog(@"user from LoginViewController %@", user.profileImageURL);
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

- (IBAction)onSignout:(id)sender {
    [[TwitterClient sharedInstance] signOut];
    
    LoginViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
