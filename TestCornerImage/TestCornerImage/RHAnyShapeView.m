//
//  RHAnyShapeView.m
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/7.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHAnyShapeView.h"

@interface RHAnyShapeView () {
    CGPoint _currentPoint;
    CGPoint _previousPoint;
    CGPoint _previousPreviousPoint;
    UIImage *_realImage;
    
    CGFloat _minX;
    CGFloat _minY;
    CGFloat _maxX;
    CGFloat _maxY;
}
@end

@implementation RHAnyShapeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        _penPaths = [NSMutableArray new];
        _minX = CGFLOAT_MAX;
        _minY = CGFLOAT_MAX;
        _maxX = CGFLOAT_MIN;
        _maxY = CGFLOAT_MIN;
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self draw:touches];
}

- (void)draw:(NSSet<UITouch *> *)touches {
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [[UIColor clearColor] setFill];
    UIRectFill(self.bounds);
    CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
    CGContextSetLineWidth(context, 5);
    CGContextSetLineCap(context, kCGLineCapRound);
    
    if (_realImage){
        [_realImage drawInRect:self.bounds];
    }
    
    _previousPreviousPoint = _previousPoint;
    _previousPoint = [[touches anyObject] previousLocationInView:self];
    
    if (_previousPreviousPoint.x == 0 &&
        _previousPreviousPoint.y == 0) {
        _previousPreviousPoint = _previousPoint;
    }
    
    _currentPoint = [[touches anyObject] locationInView:self];
    
    // get
    if (_minX > _currentPoint.x) {
        _minX = _currentPoint.x;
    }
    if (_minY > _currentPoint.y) {
        _minY = _currentPoint.y;
    }
    if (_maxX < _currentPoint.x) {
        _maxX = _currentPoint.x;
    }
    if (_maxY < _currentPoint.y) {
        _maxY = _currentPoint.y;
    }
    
    CGPoint pathPoint = [self convertPoint:_currentPoint toView:self.imageView];
    NSValue *value = [NSValue valueWithCGPoint:pathPoint];
    [_penPaths addObject:value];
    
    CGPoint midPoint1 = [self midPoint:_previousPreviousPoint point2:_previousPoint];
    CGPoint midPoint2 = [self midPoint:_previousPoint point2:_currentPoint];
    CGPoint previousPoint = _previousPoint;
    
    if (midPoint1.x == 0 && midPoint1.y == 0 &&
        midPoint2.x == 0 && midPoint2.y == 0 &&
        previousPoint.x == 0 && previousPoint.y == 0) {
        return;
    }
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, midPoint1.x, midPoint1.y);
    CGPathAddQuadCurveToPoint(path, NULL, previousPoint.x, previousPoint.y, midPoint2.x, midPoint2.y);
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    UIImage *sourceImage = UIGraphicsGetImageFromCurrentImageContext();
    _realImage =[UIImage imageWithCGImage:sourceImage.CGImage];
    self.image = _realImage;
    CGPathRelease(path);
    
    UIGraphicsEndImageContext();
}

- (CGPoint)midPoint:(CGPoint)point1 point2:(CGPoint)point2 {
    return CGPointMake((point1.x + point2.x) * 0.5, (point1.y + point2.y) * 0.5);
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self draw:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self draw:touches];
    
    _previousPoint = CGPointZero;
    _previousPreviousPoint = CGPointZero;
    _currentPoint = CGPointZero;
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (void)insert {
    CGRect frame = CGRectMake(_minX, _minY, _maxX - _minX, _maxY - _minY);
    _drawRect = frame;
}

- (UIImage *)clipAnyShapeImageAtPath:(NSMutableArray *)penPaths {
    CGRect rect = CGRectMake(_minX, _minY, _maxX - _minX, _maxY - _minY);
    CGFloat width= self.imageView.frame.size.width;
    CGFloat rationScale = (width / self.imageView.image.size.width);
    CGFloat origX = (rect.origin.x - self.imageView.frame.origin.x) / rationScale;
    CGFloat origY = (rect.origin.y - self.imageView.frame.origin.y) / rationScale;
    CGFloat oriWidth = rect.size.width / rationScale;
    CGFloat oriHeight = rect.size.height / rationScale;
    
    CGRect myRect = CGRectMake(origX, origY, oriWidth, oriHeight);
    CGImageRef  imageRef = CGImageCreateWithImageInRect(self.imageView.image.CGImage, myRect);
    
    UIGraphicsBeginImageContext(myRect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, myRect, imageRef);
    UIImage * newImage = [UIImage imageWithCGImage:imageRef];
    UIGraphicsEndImageContext();
    
    // clip any path
    for (int i = 0; i < penPaths.count; i++) {
        NSValue *valueI = penPaths[i];
        CGPoint pointI = [valueI CGPointValue];
        pointI.x -= _minX;
        pointI.y -= _minY;
        penPaths[i] = [NSValue valueWithCGPoint:pointI];
    }
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    context = UIGraphicsGetCurrentContext();
    NSValue *value0 = penPaths[0];
    CGPoint point0 = [value0 CGPointValue];
    CGContextMoveToPoint(context, point0.x, point0.y);
    
    for (int i = 1; i < penPaths.count; i++) {
        NSValue *valueI = penPaths[i];
        CGPoint pointI = [valueI CGPointValue];
        CGContextAddLineToPoint(context, pointI.x, pointI.y);
    }
    CGContextAddLineToPoint(context, point0.x, point0.y);
    CGContextClip(context);
    [newImage drawInRect:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    CGContextDrawPath(context, kCGPathFill);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

