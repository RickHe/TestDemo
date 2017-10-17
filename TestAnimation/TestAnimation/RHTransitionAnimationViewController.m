//
//  RHTransitionAnimationViewController.m
//  TestAnimation
//
//  Created by DaFenQI on 2017/10/12.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHTransitionAnimationViewController.h"

@interface RHTransitionAnimationViewController () {
    UILabel *_transitionLabelA;
    UILabel *_transitionLabelB;
}

@end

@implementation RHTransitionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // 单个视图的过度动画
    UILabel *singleViewTransitionLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    singleViewTransitionLabel.text = @"单个视图过度动画";
    singleViewTransitionLabel.backgroundColor = [UIColor redColor];
    singleViewTransitionLabel.textAlignment = NSTextAlignmentCenter;
    singleViewTransitionLabel.userInteractionEnabled = YES;
    [self.view addSubview:singleViewTransitionLabel];
    
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTranistion:)];
    [singleViewTransitionLabel addGestureRecognizer:tap];
    
    // 两个视图的过度动画
    // 动画效果作用于 视图的父视图frame
    // A->B 实际效果 父视图移除 A， 父视图添加 B
    _transitionLabelA = [[UILabel alloc] initWithFrame:CGRectMake(400, 100, 200, 200)];
    _transitionLabelA.text = @"A视图";
    _transitionLabelA.textAlignment = NSTextAlignmentCenter;
    _transitionLabelA.backgroundColor = [UIColor redColor];
    _transitionLabelA.userInteractionEnabled = YES;
    [self.view addSubview:_transitionLabelA];
    
    UIGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTranistionFromAToB:)];
    [_transitionLabelA addGestureRecognizer:tap1];
    
    _transitionLabelB = [[UILabel alloc] initWithFrame:CGRectMake(400, 100, 200, 200)];
    _transitionLabelB.text = @"B视图";
    _transitionLabelB.textAlignment = NSTextAlignmentCenter;
    _transitionLabelB.backgroundColor = [UIColor greenColor];
    _transitionLabelB.userInteractionEnabled = YES;

    UIGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTranistionFromAToB:)];
    [_transitionLabelB addGestureRecognizer:tap2];
}

/*
 typedef NS_OPTIONS(NSUInteger, UIViewAnimationOptions) {
 UIViewAnimationOptionLayoutSubviews            = 1 <<  0,
 UIViewAnimationOptionAllowUserInteraction      = 1 <<  1, // turn on user interaction while animating
 UIViewAnimationOptionBeginFromCurrentState     = 1 <<  2, // start all views from current value, not initial value
 UIViewAnimationOptionRepeat                    = 1 <<  3, // repeat animation indefinitely
 UIViewAnimationOptionAutoreverse               = 1 <<  4, // if repeat, run animation back and forth
 UIViewAnimationOptionOverrideInheritedDuration = 1 <<  5, // ignore nested duration
 UIViewAnimationOptionOverrideInheritedCurve    = 1 <<  6, // ignore nested curve
 UIViewAnimationOptionAllowAnimatedContent      = 1 <<  7, // animate contents (applies to transitions only)
 UIViewAnimationOptionShowHideTransitionViews   = 1 <<  8, // flip to/from hidden state instead of adding/removing
 UIViewAnimationOptionOverrideInheritedOptions  = 1 <<  9, // do not inherit any options or animation type
 
 UIViewAnimationOptionCurveEaseInOut            = 0 << 16, // default
 UIViewAnimationOptionCurveEaseIn               = 1 << 16,
 UIViewAnimationOptionCurveEaseOut              = 2 << 16,
 UIViewAnimationOptionCurveLinear               = 3 << 16,
 
 UIViewAnimationOptionTransitionNone            = 0 << 20, // default
 UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
 UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
 UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
 UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
 UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
 UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
 UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
 
 UIViewAnimationOptionPreferredFramesPerSecondDefault     = 0 << 24,
 UIViewAnimationOptionPreferredFramesPerSecond60          = 3 << 24,
 UIViewAnimationOptionPreferredFramesPerSecond30          = 7 << 24,
 
 } NS_ENUM_AVAILABLE_IOS(4_0);
 */
- (void)tapTranistion:(UITapGestureRecognizer *)tap {
    [UIView transitionWithView:tap.view duration:1.0f options:UIViewAnimationOptionTransitionCurlDown | UIViewAnimationOptionCurveEaseOut animations:^{
        tap.view.backgroundColor = [UIColor greenColor];
    } completion:^(BOOL finished) {
        tap.view.backgroundColor = [UIColor redColor];
    }];
}

- (void)tapTranistionFromAToB:(UITapGestureRecognizer *)tap {
    UIView *toView = nil;
    if (tap.view == _transitionLabelA) {
        toView = _transitionLabelB;
    }
    if (tap.view == _transitionLabelB) {
        toView = _transitionLabelA;
    }
    [UIView transitionFromView:tap.view toView:toView duration:1.0f options:UIViewAnimationOptionTransitionCurlDown | UIViewAnimationOptionCurveEaseOut completion:^(BOOL finished) {
        
    }];
}

@end
