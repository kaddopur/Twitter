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

- (void)addMenuPanel {
    self.menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuViewController"];
    [self.view insertSubview:self.menuVC.view atIndex:0];
    [self addChildViewController:self.menuVC];
    [self.menuVC didMoveToParentViewController:self];
    self.tweetsNavigationVC.view.layer.shadowOpacity = 0.8;
}

- (void)openMenu {
    if (!self.menuVC) {
        [self addMenuPanel];
    }
    
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.tweetsNavigationVC.view.frame;
        CGFloat targetX = CGRectGetWidth(self.tweetsNavigationVC.view.frame) - 48;
        frame.origin.x = targetX;
        self.tweetsNavigationVC.view.frame = frame;
    } completion:^(BOOL finished) {
        self.isMenuOpen = YES;
    }];
}

- (void)closeMenu {
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = self.tweetsNavigationVC.view.frame;
        frame.origin.x = 0;
        self.tweetsNavigationVC.view.frame = frame;
        self.tweetsNavigationVC.view.layer.shadowOpacity = 0.0;
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
            center = self.tweetsNavigationVC.view.center;
            center.x = center.x + [recognizer translationInView:self.view].x;
            self.tweetsNavigationVC.view.center = center;
            
            [recognizer setTranslation:CGPointZero inView:self.view];
            break;
        case UIGestureRecognizerStateEnded:
            movedGreaterThanHalfWay = fabs(self.tweetsNavigationVC.view.center.x) > recognizer.view.center.x * 1.5;
            
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
