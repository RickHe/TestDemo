//
//  RHBaseShapeView.m
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/7.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHBaseShapeView.h"
#import "RHRoundView.h"
#import "UIView+DFCLayerCorner.h"

typedef NS_ENUM(NSUInteger, kRHTranslationType) {
    kRHTranslationTypeX,
    kRHTranslationTypeY,
    kRHTranslationTypeXY,
};

@interface RHBaseShapeView () {
    CGPoint _startPoint;
    CGPoint _endPoint;
}

@end

@implementation RHBaseShapeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_createSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    NSLog(@"%s", __func__);
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    if (width == 0 && height == 0) {
        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (i == 1 && j == 1) {
                    continue;
                }
                NSInteger tag = kRHBaseTag + i * 3 + j;
                UIView *subview = [self viewWithTag:tag];
                subview.center = CGPointMake(-100, -100);
            }
        }
        return;
    }
    
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if (i == 1 && j == 1) {
                continue;
            }
            NSInteger tag = kRHBaseTag + i * 3 + j;
            UIView *subview = [self viewWithTag:tag];
            subview.center = CGPointMake(j * width / 2, i * height / 2);
        }
    }
}

- (void)p_createSubviews {
//    self.layer.cornerRadius = 15;
//    self.layer.borderColor = [[UIColor blackColor] CGColor];
//    self.layer.borderWidth = 1;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            if (i == 1 && j == 1) {
                continue;
            }
            UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
            subview.tag = kRHBaseTag + i * 3 + j;
            [subview DFC_setLayerCorner];
            subview.layer.cornerRadius = 10;
            subview.backgroundColor = [UIColor whiteColor];
            [subview addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)]];
            [self addSubview:subview];
        }
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        for (UIView *subView in self.subviews.reverseObjectEnumerator) {
            CGPoint tp = [subView convertPoint:point fromView:self];
            if (CGRectContainsPoint(subView.bounds, tp)) {
                view = subView;
            }
        }
    }
    return view;
}

- (kRHTranslationType)isCornerSubview:(UIView *)view {
    kRHTranslationType translationType;
    if (
        view.tag == kRHBaseTag + 0 ||
        view.tag == kRHBaseTag + 2 ||
        view.tag == kRHBaseTag + 6 ||
        view.tag == kRHBaseTag + 8
        ) {
        translationType = kRHTranslationTypeXY;
    } else if (
               view.tag == kRHBaseTag + 1 ||
               view.tag == kRHBaseTag + 7
               ) {
        translationType = kRHTranslationTypeY;
    } else {
        translationType = kRHTranslationTypeX;
    }
    return translationType;
}

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer {
    NSLog(@"%s", __func__);
    CGPoint translation = [gestureRecognizer translationInView:self];
    
    switch ([self isCornerSubview:gestureRecognizer.view]) {
        case kRHTranslationTypeX:
            translation.y = 0;
            break;
        case kRHTranslationTypeY:
            translation.x = 0;
            break;
        default:
            break;
    }
    
    CGRect frame = self.frame;
    if (gestureRecognizer.view.tag == kRHBaseTag + 0 ||
        gestureRecognizer.view.tag == kRHBaseTag + 1 ||
        gestureRecognizer.view.tag == kRHBaseTag + 3 ) {
        frame.origin.x += translation.x;
        frame.origin.y += translation.y;
        frame.size.width -= translation.x;
        frame.size.height -= translation.y;
    } else if (gestureRecognizer.view.tag == kRHBaseTag + 2 ||
               gestureRecognizer.view.tag == kRHBaseTag + 5 ) {
        frame.origin.y += translation.y;
        frame.size.width += translation.x;
        frame.size.height -= translation.y;
    } else if (gestureRecognizer.view.tag == kRHBaseTag + 3 ||
               gestureRecognizer.view.tag == kRHBaseTag + 6 ) {
        frame.origin.x += translation.x;
        frame.size.width -= translation.x;
        frame.size.height += translation.y;
    } else {
        frame.size.width += translation.x;
        frame.size.height += translation.y;
    }
    self.frame = frame;
    NSLog(@"%@", NSStringFromCGPoint(translation));
    
    [gestureRecognizer setTranslation:CGPointZero inView:self];
    [self.superview setNeedsDisplay];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
}

@end
