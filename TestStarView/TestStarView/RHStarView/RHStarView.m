//
//  RHStarView.m
//  TestStarView
//
//  Created by DaFenQI on 2017/9/22.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHStarView.h"

@interface RHStarView () {
    UIView *_starBackgroundView;
    UIView *_starForgroundView;
}

@property (nonatomic, readwrite, assign) CGFloat numberOfStars;

@end

@implementation RHStarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaultInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self defaultInit];
    }
    return self;
}

- (void)defaultInit {
    [self setup];
    [self createSubviews];
    [self addGesture];
}

- (void)setup {
    _currentRate = 0.0f;
    _numberOfStars = 0;
    _needAnimation = YES;
    _starRateStyle = RHStarRateStyleAny;
}

- (void)setCurrentRate:(CGFloat)currentRate {
    _currentRate = currentRate;
    CGRect frame = _starForgroundView.frame;
    CGRect backgroundFrame = _starBackgroundView.frame;
    frame.size.width = backgroundFrame.size.width * currentRate;
    
    NSTimeInterval animationTimeInterval = _needAnimation ? 0.1 : 0;
    [UIView animateWithDuration:animationTimeInterval animations:^{
        _starForgroundView.frame = frame;
    }];
}

- (void)addGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGestureRecognizer:)];
    [self addGestureRecognizer:tap];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)];
    [self addGestureRecognizer:pan];
}

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer {
    [self p_setCurrentRate:gestureRecognizer];
}

- (void)p_setCurrentRate:(UIGestureRecognizer *)gesture {
    CGPoint hitPoint = [gesture locationInView:self];
    CGFloat currentRate = hitPoint.x / _starBackgroundView.bounds.size.width;
    
    if (currentRate > 1) {
        currentRate = 1;
    }
    
    if (currentRate < 0) {
        currentRate = 0;
    }
    
    CGFloat currentRatePlusNumberOfStars = currentRate * _numberOfStars;
    
    switch (_starRateStyle) {
        case RHStarRateStyleWhole:
            currentRate = ceilf(currentRatePlusNumberOfStars) / _numberOfStars;
            break;
        case RHStarRateStyleHalf:
            if (currentRatePlusNumberOfStars - roundf(currentRatePlusNumberOfStars) > 0) {
                currentRate = roundf(currentRatePlusNumberOfStars) / _numberOfStars;
            } else {
                currentRate = (roundf(currentRatePlusNumberOfStars) - 0.5) / _numberOfStars;
            }
            break;
        case RHStarRateStyleAny:
            currentRate = currentRate;
            break;
        default:
            break;
    }
    
    self.currentRate = currentRate;
    
    if (self.rateChangedBlock) {
        self.rateChangedBlock(currentRate);
    }
}

- (void)handleTapGestureRecognizer:(UITapGestureRecognizer *)gestureRecognizer {
    [self p_setCurrentRate:gestureRecognizer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = self.bounds;
    _numberOfStars = (int)frame.size.width / (int)frame.size.height;
    frame.size.width = frame.size.height * _numberOfStars;
    _starBackgroundView.frame = frame;
    frame.size.width = frame.size.width * _currentRate;
    _starForgroundView.frame = frame;
}

- (void)createSubviews {
    _starBackgroundView = [self getViewWithFrame:self.bounds imageName:@"star_gray"];
    _starForgroundView = [self getViewWithFrame:self.bounds imageName:@"star_yellow"];
}

- (UIView *)getViewWithFrame:(CGRect)frame imageName:(NSString *)imageName {
    _numberOfStars = (int)frame.size.width / (int)frame.size.height;
    frame.size.width = frame.size.height * _numberOfStars;
    
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:imageName]];
    [self addSubview:view];
    
    return view;
}

@end
