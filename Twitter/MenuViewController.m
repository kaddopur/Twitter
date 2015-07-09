//
//  MenuViewController.m
//  Twitter
//
//  Created by Jason Huang on 7/9/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "MenuViewController.h"
#import "User.h"
#import "UIImageVIew+AFNetworking.h"
#import "ContainerViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    User *user = [User currentUser];
    
    [self.profileImage setImageWithURL:user.profileImageURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)goToProfile:(id)sender {
    ContainerViewController *containerVC = (ContainerViewController *)self.parentViewController;
    
    [containerVC setupProfile];
}

- (IBAction)goToHomeTimeline:(id)sender {
    ContainerViewController *containerVC = (ContainerViewController *)self.parentViewController;
    
    [containerVC setupHomeTimeline];
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
