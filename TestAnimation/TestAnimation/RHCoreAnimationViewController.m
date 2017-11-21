//
//  RHCoreAnimationViewController.m
//  TestAnimation
//
//  Created by DaFenQI on 2017/10/13.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHCoreAnimationViewController.h"

typedef NS_ENUM(NSUInteger, kRHAnimationType) {
    kRHAnimationTypeBounds,
    kRHAnimationTypeTransform,
    kRHAnimationTypePosition,
};

#define kStartFrame CGRectMake(100, 100, 200, 60)
#define kEndFrame   CGRectMake(100, 600, 200, 60)

@interface RHCoreAnimationViewController () <CAAnimationDelegate>

@end

@implementation RHCoreAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // frame 变化动画
    UILabel *basicAnimationLabel = [[UILabel alloc] initWithFrame:kStartFrame];
    basicAnimationLabel.text = @"basic Animation Bounds";
    basicAnimationLabel.backgroundColor = [UIColor redColor];
    basicAnimationLabel.textAlignment = NSTextAlignmentCenter;
    basicAnimationLabel.userInteractionEnabled = YES;
    [self.view addSubview:basicAnimationLabel];
    
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(basicAnimationAction:)];
    [basicAnimationLabel addGestureRecognizer:tap];
    
    // 关键帧帧动画
    UILabel *keyFrameAnimationLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 300, 200, 60)];
    keyFrameAnimationLabel.text = @"keyFrame Animation";
    keyFrameAnimationLabel.backgroundColor = [UIColor greenColor];
    keyFrameAnimationLabel.textAlignment = NSTextAlignmentCenter;
    keyFrameAnimationLabel.userInteractionEnabled = YES;
    [self.view addSubview:keyFrameAnimationLabel];
    
    UIGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyFrameAnimationAction:)];
    [keyFrameAnimationLabel addGestureRecognizer:tap1];
    
    // CAAnimationGroup
    UILabel *groupAnimationLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 00, 200, 60)];
    groupAnimationLabel.text = @"AnimationGroup";
    groupAnimationLabel.backgroundColor = [UIColor greenColor];
    groupAnimationLabel.textAlignment = NSTextAlignmentCenter;
    groupAnimationLabel.userInteractionEnabled = YES;
    [self.view addSubview:groupAnimationLabel];
    
    UIGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(groupAnimationAction:)];
    [groupAnimationLabel addGestureRecognizer:tap2];
}

#pragma mark - group

- (void)groupAnimationAction:(UITapGestureRecognizer *)tap {
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    
    animationGroup.animations = @[
                                  [self animation:kRHAnimationTypeBounds],
                                  [self animation:kRHAnimationTypePosition],
                                  [self animation:kRHAnimationTypeTransform]
                                  ];
    animationGroup.duration = 1;
    animationGroup.fillMode = kCAFillModeBackwards; // 恢复原态
    animationGroup.removedOnCompletion = NO;
    [tap.view.layer addAnimation:animationGroup forKey:@"animationGroup"];
}

- (CABasicAnimation *)animation:(kRHAnimationType) type {
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    
    switch (type) {
        case kRHAnimationTypeBounds:
            // 缩放动画
            basicAnimation.keyPath = @"bounds";
            basicAnimation.toValue = [NSValue valueWithCGRect:kEndFrame];
            break;
        case kRHAnimationTypeTransform:
            // 旋转动画
            basicAnimation.keyPath = @"transform";
            basicAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
            break;
        case kRHAnimationTypePosition:
            // 平移动画
            basicAnimation.keyPath = @"position";
            basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
        default:
            break;
    }
    basicAnimation.duration = .8f;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    return basicAnimation;
}

#pragma mark - 基础动画

- (void)basicAnimationAction:(UITapGestureRecognizer *)tap {
    [self doAnimation:kRHAnimationTypeBounds atView:tap.view];
}

- (void)doAnimation:(kRHAnimationType) type atView:(UIView *)view {
    CABasicAnimation *basicAnimation = [CABasicAnimation animation];
    
    switch (type) {
        case kRHAnimationTypeBounds:
            // 缩放动画
            basicAnimation.keyPath = @"bounds";
            basicAnimation.toValue = [NSValue valueWithCGRect:kEndFrame];
            break;
        case kRHAnimationTypeTransform:
            // 旋转动画
            basicAnimation.keyPath = @"transform";
            basicAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
            break;
        case kRHAnimationTypePosition:
            // 平移动画
            basicAnimation.keyPath = @"position";
            basicAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 400)];
        default:
            break;
    }
    basicAnimation.duration = .8f;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:basicAnimation forKey:nil];
}

#pragma mark - 关键帧动画
//// 按照所画的轨迹进行运动
//- (void)keyFrameAnimationAction:(UITapGestureRecognizer *)tap {
//    CAKeyframeAnimation * anim = [CAKeyframeAnimation animation];
//    
//    anim.keyPath = @"position";
//
//    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
//    [bezierPath moveToPoint:tap.view.center];
//    [bezierPath addCurveToPoint:CGPointMake(130, 600) controlPoint1:CGPointMake(30, 300) controlPoint2:CGPointMake(500, 500)];
//    anim.path = bezierPath.CGPath;
//    
//    // 动画的执行节奏
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    anim.duration = 2.0f;
//    anim.removedOnCompletion = NO;
//    anim.fillMode = kCAFillModeForwards;
//    anim.delegate = self;
//    [tap.view.layer addAnimation:anim forKey:nil];
//}


// 点的 value 轨迹运动
- (void)keyFrameAnimationAction:(UITapGestureRecognizer *)tap {
    CAKeyframeAnimation * anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"position";
    NSValue *v1 = [NSValue valueWithCGPoint:tap.view.center];
    NSValue *v2 = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    NSValue *v3 = [NSValue valueWithCGPoint:CGPointMake(100, 300)];
    NSValue *v4 = [NSValue valueWithCGPoint:tap.view.center];
    anim.values = @[v1,v2,v3,v4];
    
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    anim.duration = 2.0f;
    anim.removedOnCompletion = NO;
    anim.fillMode = kCAFillModeForwards;
    anim.delegate = self;
    [tap.view.layer addAnimation:anim forKey:nil];
}

#pragma mark - CAAnimationDelegate
/* Called when the animation begins its active duration. */
- (void)animationDidStart:(CAAnimation *)anim {

}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
}

@end
