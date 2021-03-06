//
//  LoginViewController.m
//  Twitter
//
//  Created by Jason Huang on 6/30/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "LoginViewController.h"
#import "TwitterClient.h"
#import "TweetsViewController.h"
#import "ContainerViewController.h"

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

- (IBAction)onLogin:(id)sender {
    [[TwitterClient sharedInstance] loginWithCompletion:^(User *user, NSError *error) {
        if (user != nil) {
            NSLog(@"user with clean api call: %@", user.name);
            
            ContainerViewController *containerVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ContainerViewController"];
            [self presentViewController:containerVC animated:YES completion:nil];
        } else {
            NSLog(@"user not logged in!");
        }
    }];
}

@end
