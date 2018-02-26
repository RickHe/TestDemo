//
//  RHRectangleCutView.m
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/6.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHCutView.h"
#import "RHRectangleView.h"
#import "RHRoundView.h"

@interface RHCutView () {
    RHBaseShapeView *_baseShapeView;
    CGRect _rectagleFrame;
}

@end

@implementation RHCutView
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self p_createSubviews];
//    }
//    return self;
//}
//
//- (instancetype)initWithCoder:(NSCoder *)coder
//{
//    self = [super initWithCoder:coder];
//    if (self) {
//        [self p_createSubviews];
//    }
//    return self;
//}

- (void)setCutType:(kCutType)cutType {
    _cutType = cutType;
    [self p_createSubviews];
}

- (void)p_createSubviews {
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
    _baseShapeView = [RHBaseShapeViewFactory shapeViewWithType:_cutType];
    [self addSubview:_baseShapeView];
    
    [_baseShapeView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestureRecognizer:)]];
    [_baseShapeView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView:)]];
}

- (void)handlePanGestureRecognizer:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer translationInView:self];
    CGPoint center = _baseShapeView.center;
    center.x += translation.x;
    center.y += translation.y;
    _baseShapeView.center = center;
    [gestureRecognizer setTranslation:CGPointZero inView:self];
    
    [self setNeedsDisplay];
}

- (void)pinchView:(UIPinchGestureRecognizer *)pinchGestureRecognizer {
    UIView *view = pinchGestureRecognizer.view;
    view.transform = CGAffineTransformScale(view.transform, pinchGestureRecognizer.scale, pinchGestureRecognizer.scale);
    pinchGestureRecognizer.scale = 1;
    
    [self setNeedsDisplay];
}

- (void)setRectagleFrame:(CGRect)rectagleFrame {
    if ([_baseShapeView isKindOfClass:[RHRoundView class]]) {
        if (rectagleFrame.size.width < rectagleFrame.size.height) {
            rectagleFrame.size.width = rectagleFrame.size.height;
        } else {
            rectagleFrame.size.height = rectagleFrame.size.width;
        }
    }
    
    _rectagleFrame = rectagleFrame;
    _baseShapeView.backgroundColor = [UIColor clearColor];
    _baseShapeView.frame = rectagleFrame;
    [_baseShapeView setNeedsDisplay];
    [self setNeedsDisplay];
}

- (CGRect)rectagleFrame {
    _rectagleFrame = _baseShapeView.frame;
    return _rectagleFrame;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect frame = _baseShapeView.frame;
    
    CGFloat height = frame.size.height;
    CGFloat selfWidth = self.frame.size.width;
    CGFloat selfHeight = self.frame.size.height;
    
    CGRect rect1 = CGRectMake(0, 0, selfWidth, CGRectGetMinY(frame));
    CGRect rect2 = CGRectMake(0, CGRectGetMinY(frame), CGRectGetMinX(frame), height);
    CGRect rect3 = CGRectMake(0, CGRectGetMaxY(frame), selfWidth, selfHeight - CGRectGetMaxY(frame));
    CGRect rect4 = CGRectMake(CGRectGetMaxX(frame), CGRectGetMinY(frame), selfWidth - CGRectGetMaxX(frame), height);

    CGContextAddRect(context, rect1);
    CGContextAddRect(context, rect2);
    CGContextAddRect(context, rect3);
    CGContextAddRect(context, rect4);

    CGContextSetAlpha(context, 0.4);
    CGContextFillPath(context);
}

@end
