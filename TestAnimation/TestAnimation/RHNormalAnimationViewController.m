//
//  RHNormalAnimationViewController.m
//  TestAnimation
//
//  Created by DaFenQI on 2017/10/13.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHNormalAnimationViewController.h"

#define kStartFrame CGRectMake(100, 100, 200, 200)
#define kEndFrame   CGRectMake(100, 300, 100, 100)

@interface RHNormalAnimationViewController ()

@end

@implementation RHNormalAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // frame 变化动画
    UILabel *frameChangedAnimationLabel = [[UILabel alloc] initWithFrame:kStartFrame];
    frameChangedAnimationLabel.text = @"frame changed 动画";
    frameChangedAnimationLabel.backgroundColor = [UIColor redColor];
    frameChangedAnimationLabel.textAlignment = NSTextAlignmentCenter;
    frameChangedAnimationLabel.userInteractionEnabled = YES;
    [self.view addSubview:frameChangedAnimationLabel];
    
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFrameChangedAnimation:)];
    [frameChangedAnimationLabel addGestureRecognizer:tap];
    
    // transform 动画 个人推荐使用
    UILabel *transformAnimationLabel = [[UILabel alloc] initWithFrame:CGRectMake(400, 100, 200, 200)];
    transformAnimationLabel.text = @"transform changed 动画";
    transformAnimationLabel.backgroundColor = [UIColor redColor];
    transformAnimationLabel.textAlignment = NSTextAlignmentCenter;
    transformAnimationLabel.userInteractionEnabled = YES;
    [self.view addSubview:transformAnimationLabel];
    
    UIGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTransformAnimation:)];
    [transformAnimationLabel addGestureRecognizer:tap1];
}

- (void)tapTransformAnimation:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:0.8 animations:^{
        if (tap.view.frame.origin.y == 100) {
            tap.view.transform = CGAffineTransformScale(tap.view.transform, 0.6, 0.6);
            tap.view.transform = CGAffineTransformTranslate(tap.view.transform, 100, 100);
            tap.view.transform = CGAffineTransformRotate(tap.view.transform, M_PI);
        } else {
            tap.view.transform = CGAffineTransformIdentity;
        }
    }];
}

- (void)tapFrameChangedAnimation:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:0.8 animations:^{
        if (CGRectEqualToRect(tap.view.frame, kStartFrame)) {
            tap.view.frame = kEndFrame;
        } else if (CGRectEqualToRect(tap.view.frame, kEndFrame)) {
            tap.view.frame = kStartFrame;
        }
    }];
}

@end
