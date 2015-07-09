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
#import "ProfileViewController.h"
#import "MentionsViewController.h"

@interface ContainerViewController ()

@property (strong, nonatomic) UINavigationController *tweetsNavigationVC;
@property (strong, nonatomic) TweetsViewController *tweetsVC;
@property (strong, nonatomic) UINavigationController *profileNavigationVC;
@property (strong, nonatomic) ProfileViewController *profileVC;
@property (strong, nonatomic) UINavigationController *mentionsNavigationVC;
@property (strong, nonatomic) MentionsViewController *mentionsVC;

@property (strong, nonatomic) MenuViewController *menuVC;
@property (assign, nonatomic) BOOL isMenuOpen;

@property (weak, nonatomic) UIViewController *currentVC;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupHomeTimeline];
}

- (void)setupProfile {
    self.isMenuOpen = NO;
    self.profileNavigationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileNavigationController"];
    self.currentVC = self.profileNavigationVC;
    
    self.profileVC = self.profileNavigationVC.childViewControllers[0];
    self.profileVC.delegate = self;
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:self.profileNavigationVC.view];
    
    [self addChildViewController:self.profileNavigationVC];
    [self.profileNavigationVC didMoveToParentViewController:self];
}

- (void)setupHomeTimeline {
    self.isMenuOpen = NO;
    self.tweetsNavigationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"TweetsNavigationController"];
    self.currentVC = self.tweetsNavigationVC;
    
    self.tweetsVC = self.tweetsNavigationVC.childViewControllers[0];
    self.tweetsVC.delegate = self;
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:self.tweetsNavigationVC.view];
    
    [self addChildViewController:self.tweetsNavigationVC];
    [self.tweetsNavigationVC didMoveToParentViewController:self];
}

- (void)setupMentions {
    self.isMenuOpen = NO;
    self.mentionsNavigationVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MentionsNavigationController"];
    self.currentVC = self.mentionsNavigationVC;
    
    self.mentionsVC = self.mentionsNavigationVC.childViewControllers[0];
    self.mentionsVC.delegate = self;
    
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.view addSubview:self.mentionsNavigationVC.view];
    
    [self addChildViewController:self.mentionsNavigationVC];
    [self.mentionsNavigationVC didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleMenuClick {
    BOOL shouldMenuOpen = !self.isMenuOpen;
    
    if (shouldMenuOpen) {
        [self openMenu];
    } else {
        [self closeMenu];
    }
}

- (void)tweetsViewController:(TweetsViewController *)tweetsViewController didClickMenu:(NSDictionary *)params {
    [self handleMenuClick];
}

- (void)profileViewController:(ProfileViewController *)profileViewController didClickMenu:(NSDictionary *)params {
    [self handleMenuClick];
}

- (void)mentionsViewController:(MentionsViewController *)mentionsViewController didClickMenu:(NSDictionary *)params {
    [self handleMenuClick];
}

- (void)addMenuPanel {
    self.menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [self.view insertSubview:self.menuVC.view atIndex:0];
    [self addChildViewController:self.menuVC];
    [self.menuVC didMoveToParentViewController:self];
    self.currentVC.view.layer.shadowOpacity = 0.5;
}

- (void)openMenu {
    if (!self.menuVC) {
        [self addMenuPanel];
    }
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.currentVC.view.frame;
        CGFloat targetX = CGRectGetWidth(self.currentVC.view.frame) - 48;
        frame.origin.x = targetX;
        self.currentVC.view.frame = frame;
    } completion:^(BOOL finished) {
        self.isMenuOpen = YES;
    }];
}

- (void)closeMenu {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.currentVC.view.frame;
        frame.origin.x = 0;
        self.currentVC.view.frame = frame;
        self.currentVC.view.layer.shadowOpacity = 0.0;
    } completion:^(BOOL finished) {
        [self.menuVC.view removeFromSuperview];
        self.menuVC = nil;
        self.isMenuOpen = NO;
    }];
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    BOOL draggingFromLeftToRight = ([recognizer velocityInView:(self.view)].x > 0);
    BOOL movedGreaterThanHalfWay;
    CGPoint center;

    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self addMenuPanel];
            break;
        case UIGestureRecognizerStateChanged:
            center = self.currentVC.view.center;
            center.x = center.x + [recognizer translationInView:self.view].x;
            self.currentVC.view.center = center;
            
            [recognizer setTranslation:CGPointZero inView:self.view];
            break;
        case UIGestureRecognizerStateEnded:
            movedGreaterThanHalfWay = fabs(self.currentVC.view.center.x) > recognizer.view.center.x * 1.5;
            
            if (!draggingFromLeftToRight && !self.isMenuOpen) {
                [self closeMenu];
                break;
            }

            if (draggingFromLeftToRight) {
                if (movedGreaterThanHalfWay && !self.isMenuOpen) {
                    [self openMenu];
                } else {
                    [self closeMenu];
                }
            } else {
                if (movedGreaterThanHalfWay) {
                    [self closeMenu];
                } else {
                    [self openMenu];
                }
            }
            break;
        default:
            break;
    }

    
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
