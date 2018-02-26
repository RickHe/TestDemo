//
//  RHCutImageView.m
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/6.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHCutImageView.h"
#import "RHCutView.h"
#import "RHImageView.h"
#import "RHAnyShapeView.h"
#import "UIImage+DFCRotate.h"

@interface RHCutImageView () {
    CGPoint _startPoint;
    CGPoint _endPoint;
    BOOL _canAddCutView;
}

@property(nonatomic, strong) RHImageView *imageView;
@property(nonatomic, strong) RHCutView *cutView;
@property(nonatomic, strong) RHAnyShapeView *anyShapeView;

@end

@implementation RHCutImageView

- (void)setCutType:(kCutType)cutType {
    _cutType = cutType;
    _canAddCutView = YES;
    
    [_cutView removeFromSuperview];
    _cutView = nil;
    [_anyShapeView removeFromSuperview];
    _anyShapeView = nil;
    
    if (cutType == kCutTypeAny) {
        self.anyShapeView.imageView = self.imageView;
    } else if (cutType == kCutTypeNone) {
        // nothing
    } else {
        self.cutView.cutType = _cutType;
    }
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self p_initAction];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_initAction];
    }
    return self;
}

- (void)p_initAction {
    self.userInteractionEnabled = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (!CGRectEqualToRect(self.cutView.frame, CGRectZero)) {
        self.cutView.frame = self.bounds;
    }
    self.imageView.center = self.center;
}

- (UIImage *)rotateImageView {
    UIImage *image = [self.imageView.image imageRotatedByRadians:-M_PI_2];
    self.contentImage = image;
    return image;
}

- (UIImage *)cutImage {
    CGRect frame = CGRectIntersection(self.imageView.frame, self.cutView.rectagleFrame);
    frame = [self.imageView convertRect:frame fromView:self];
    switch (_cutType) {
        case kCutTypeRectangle: {
            self.imageView.image = [self.imageView clipRectangleImageAtRect:frame];
            self.imageView.frame = frame;
            break;
        }
        case kCutTypeRound: {
//            CGRect roundRect = [self.imageView convertRect:self.cutView.rectagleFrame fromView:self];
//            self.imageView.image = [self.imageView clipRoundImageAtRect:frame
//                                                              roundRect:roundRect];
//            self.imageView.frame = frame;
            break;
        }
        case kCutTypeAny: {
            [self.anyShapeView insert];
            self.imageView.image = [self.imageView clipAnyShapeImageAtPath:self.anyShapeView.penPaths atRect:self.anyShapeView.drawRect];
            CGRect frame = [self convertRect:self.anyShapeView.drawRect toView:self];
            self.imageView.frame = frame;
            [_anyShapeView removeFromSuperview];
            _anyShapeView = nil;
        }
        default:
            break;
    }
    
    _canAddCutView = NO;
    [_cutView removeFromSuperview];
    _cutView = nil;
    return self.imageView.image;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[RHImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = [UIColor clearColor];
        //_imageView.contentMode = UIViewContentModeScaleToFill;
        [self addSubview:_imageView];
    }
    return _imageView;
}

- (RHCutView *)cutView {
    if (!_cutView) {
        _cutView = [[RHCutView alloc] initWithFrame:CGRectZero];
        [self addSubview:_cutView];
    }
    return _cutView;
}

- (RHAnyShapeView *)anyShapeView {
    if (!_anyShapeView) {
        _anyShapeView = [[RHAnyShapeView alloc] initWithFrame:self.bounds];
        _anyShapeView.backgroundColor = [UIColor clearColor];
        [self addSubview:_anyShapeView];
    }
    return _anyShapeView;
}

- (void)setContentImage:(UIImage *)contentImage {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    CGFloat width = contentImage.size.width / contentImage.scale;
    CGFloat height = contentImage.size.height / contentImage.scale;
    if (width > screenWidth) {
        width = screenWidth;
    }
    if (height > screenHeight) {
        height = screenHeight;
    }
    
    self.imageView.frame = CGRectMake(0, 0, width, height);
    self.imageView.center = self.center;
    self.imageView.image = contentImage;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_canAddCutView) {
        return;
    }
    
    if (_cutType == kCutTypeAny || _cutType == kCutTypeNone) {
        return;
    }
    
    CGPoint point = [[touches anyObject] locationInView:self];
    _startPoint = point;
    _endPoint = point;
    self.cutView.frame = self.bounds;
    self.cutView.rectagleFrame = [self getFrameFrom:_startPoint endPoint:_endPoint];
}

- (CGRect)getFrameFrom:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    CGFloat minX = MIN(startPoint.x, endPoint.x);
    CGFloat minY = MIN(startPoint.y, endPoint.y);
    CGFloat width = fabs(startPoint.x - endPoint.x);
    CGFloat height = fabs(startPoint.y - endPoint.y);
    return CGRectMake(minX, minY, width, height);
}

- (CGPoint)midPoint:(CGPoint)point1 point2:(CGPoint)point2 {
    return CGPointMake((point1.x + point2.x) * 0.5, (point1.y + point2.y) * 0.5);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (!_canAddCutView) {
        return;
    }
    
    if (_cutType == kCutTypeAny || _cutType == kCutTypeNone) {
        return;
    }
    
    CGPoint point = [[touches anyObject] locationInView:self];
    _endPoint = point;
    self.cutView.rectagleFrame = [self getFrameFrom:_startPoint endPoint:_endPoint];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (_cutType == kCutTypeAny || _cutType == kCutTypeNone) {
        return;
    }
    
    _canAddCutView = NO;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.cutView.frame = CGRectZero;
}

@end
