//
//  RHImageView.m
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/6.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHImageView.h"

@implementation RHImageView

- (UIImage *)clipAnyShapeImageAtPath:(NSMutableArray *)penPaths
                              atRect:(CGRect)rect {
//    rect = [self getDrawRect:rect];
    
    CGFloat width= self.frame.size.width;
    CGFloat rationScale = (width / self.image.size.width);
    CGFloat origX = (rect.origin.x - self.frame.origin.x) / rationScale;
    CGFloat origY = (rect.origin.y - self.frame.origin.y) / rationScale;
    CGFloat oriWidth = rect.size.width / rationScale;
    CGFloat oriHeight = rect.size.height / rationScale;
    
    if (origX < 0) {
        oriWidth = oriWidth + origX;
        origX = 0;
    }
    
    if (origY < 0) {
        oriHeight = oriHeight + origY;
        origY = 0;
    }
    
    CGRect myRect = CGRectMake(origX, origY, oriWidth, oriHeight);
    CGImageRef  imageRef = CGImageCreateWithImageInRect(self.image.CGImage, myRect);
    
    UIGraphicsBeginImageContextWithOptions(myRect.size, NO, self.image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, myRect, imageRef);
    UIImage * newImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    
    // clip any path
    for (int i = 0; i < penPaths.count; i++) {
        NSValue *valueI = penPaths[i];
        CGPoint pointI = [valueI CGPointValue];
        pointI.x -= myRect.origin.x;
        pointI.y -= myRect.origin.y;
        
        if (pointI.x < 0) {
            pointI.x = 0;
        }
        
        if (pointI.y < 0) {
            pointI.x = 0;
        }
        
        penPaths[i] = [NSValue valueWithCGPoint:pointI];
    }
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.image.scale);
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

- (UIImage *)clipRectangleImageAtRect:(CGRect)rect {
    CGImageRef  imageRef = CGImageCreateWithImageInRect(self.image.CGImage, rect);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, rect, imageRef);
    UIImage * image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    
    return image;
}

- (UIImage *)clipRoundImageAtRect:(CGRect)rect
                        roundRect:(CGRect)roundRect {
    CGRect drawRect = rect;//[self getDrawRect:rect];
    CGImageRef  imageRef = CGImageCreateWithImageInRect(self.image.CGImage, drawRect);
    
    UIGraphicsBeginImageContextWithOptions(drawRect.size, NO, self.image.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawImage(context, drawRect, imageRef);
    UIImage * image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    UIGraphicsEndImageContext();
    
    UIGraphicsBeginImageContextWithOptions(drawRect.size, NO, self.image.scale);
    context = UIGraphicsGetCurrentContext();
    [image drawInRect:drawRect];

    if (CGRectEqualToRect(rect, roundRect)) {
        CGRect drawRoundRect = CGRectMake(0, 0, roundRect.size.width, roundRect.size.height);
        CGContextAddEllipseInRect(context, drawRoundRect);
    } else {
        CGPoint center = CGPointMake(CGRectGetMidX(roundRect), CGRectGetMidY(roundRect));
        CGFloat radius = (CGRectGetMaxY(rect) - CGRectGetMinY(rect)) / 2;
        //center.x -= rect.origin.x;
        //center.y -= rect.origin.y;
        CGContextAddArc(context, center.x, center.y, radius, 0, M_PI * 2, 0);
        CGContextClosePath(context);
    }

    CGContextClip(context);
    [image drawInRect:drawRect];
    CGContextDrawPath(context, kCGPathFill);
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
