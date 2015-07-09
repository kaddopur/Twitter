//
//  ContainerViewController.m
//  Twitter
//
//  Created by Jason Huang on 7/9/15.
//  Copyright (c) 2015 Jason Huang. All rights reserved.
//

#import "ContainerViewController.h"
#import "TweetsViewController.h"
#import "MenuViewController.h"

@interface ContainerViewController ()

@property (strong, nonatomic) UINavigationController *tweetsNavigationVC;
@property (strong, nonatomic) TweetsViewController *tweetsVC;
@property (strong, nonatomic) MenuViewController *menuVC;
@property (assign, nonatomic) BOOL isMenuOpen;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isMenuOpen = NO;
    
    self.tweetsNavigationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TweetsNavigationController"];
    self.tweetsVC = self.tweetsNavigationVC.childViewControllers[0];
    self.tweetsVC.delegate = self;
    
    [self.view addSubview:self.tweetsNavigationVC.view];
    [self addChildViewController:self.tweetsNavigationVC];
    
    [self.tweetsNavigationVC didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tweetsViewController:(TweetsViewController *)tweetsViewController didClickMenu:(NSDictionary *)params {
    BOOL shouldMenuOpen = !self.isMenuOpen;
    
    if (shouldMenuOpen) {
        [self openMenu];
    } else {
        [self closeMenu];
    }
}

- (void)openMenu {
    self.menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    [self.view insertSubview:self.menuVC.view atIndex:0];
    [self addChildViewController:self.menuVC];
    [self.menuVC didMoveToParentViewController:self];
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.tweetsNavigationVC.view.frame;
        CGFloat targetX = CGRectGetWidth(self.tweetsNavigationVC.view.frame) - 48;
        frame.origin.x = targetX;
        self.tweetsNavigationVC.view.frame = frame;
        self.tweetsNavigationVC.view.layer.shadowOpacity = 0.8;
    } completion:^(BOOL finished) {
        self.isMenuOpen = !self.isMenuOpen;
    }];
}

- (void)closeMenu {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.tweetsNavigationVC.view.frame;
        frame.origin.x = 0;
        self.tweetsNavigationVC.view.frame = frame;
        self.tweetsNavigationVC.view.layer.shadowOpacity = 0.0;
    } completion:^(BOOL finished) {
        self.isMenuOpen = !self.isMenuOpen;
        [self.menuVC.view removeFromSuperview];
        self.menuVC = nil;
    }];
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
