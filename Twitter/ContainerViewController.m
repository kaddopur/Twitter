//
//  ContainerViewController.m
//  Twitter
//
//  Created by Jason Huang on 7/9/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "ContainerViewController.h"
#import "TweetsViewController.h"

@interface ContainerViewController ()

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TweetsViewController *tweetsNavigationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TweetsNavigationController"];
    [self.view addSubview:tweetsNavigationVC.view];
    [self addChildViewController:tweetsNavigationVC];
    
    [tweetsNavigationVC didMoveToParentViewController:self];
    
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

@end
