//
//  RHAddChildViewController.m
//  TestMutiViewsSwitching
//
//  Created by DaFenQI on 2017/11/20.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHAddChildViewController.h"
#import "RHFirstViewController.h"
#import "RHSecondViewController.h"
#import "RHThirdViewController.h"

@interface RHAddChildViewController ()

@property(nonatomic, strong) UIViewController *currentVC;
@property(nonatomic, strong) RHFirstViewController *firstVC;
@property(nonatomic, strong) RHSecondViewController *secondVC;
@property(nonatomic, strong) RHThirdViewController *thirdVC;

@end

@implementation RHAddChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildViewController:self.firstVC];
    [self setVCFrame:self.firstVC];
    self.currentVC = self.firstVC;
    [self.firstVC didMoveToParentViewController:self];
    [self.view addSubview:self.firstVC.view];
}

- (void)setVCFrame:(UIViewController *)vc {
    vc.view.frame = CGRectMake(0, 0, 200, 200);
    vc.view.center = self.view.center;
}

- (RHFirstViewController *)firstVC {
    if (!_firstVC) {
        _firstVC = [[RHFirstViewController alloc] init];
    }
    return _firstVC;
}

- (RHSecondViewController *)secondVC {
    if (!_secondVC) {
        _secondVC = [[RHSecondViewController alloc] init];
    }
    return _secondVC;
}

- (RHThirdViewController *)thirdVC {
    if (!_thirdVC) {
        _thirdVC = [[RHThirdViewController alloc] init];
    }
    return _thirdVC;
}

- (IBAction)segementAction:(id)sender {
    UISegmentedControl *segment = (UISegmentedControl *)sender;
    switch (segment.selectedSegmentIndex) {
        case 0:
            [self transitionFromViewController:self.currentVC toViewController:self.firstVC];
            break;
        case 1:
            [self transitionFromViewController:self.currentVC toViewController:self.secondVC];
            break;
        case 2:
            [self transitionFromViewController:self.currentVC toViewController:self.thirdVC];
            break;
            
        default:
            break;
    }
}

- (void)transitionFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController {
    if (fromViewController == toViewController) return;
    
    [self addChildViewController:toViewController];
    [self setVCFrame:toViewController];
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:.8f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
       
    } completion:^(BOOL finished) {
        if (finished) {
            [toViewController didMoveToParentViewController:self];
            [fromViewController willMoveToParentViewController:nil];
            [fromViewController removeFromParentViewController];
            self.currentVC = toViewController;
        } else {
            [toViewController willMoveToParentViewController:nil];
            [toViewController removeFromParentViewController];
            self.currentVC = fromViewController;
        }
    }];
}

@end
