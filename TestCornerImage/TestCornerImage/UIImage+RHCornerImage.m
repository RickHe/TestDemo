//
//  UIImage+RHCornerImage.m
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/5.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "UIImage+RHCornerImage.h"

@implementation UIImage (RHCornerImage)

+ (UIImage *)rh_getCornerImage:(UIImage *)image
                  cornerRadius:(CGFloat)cornerRadius {
    UIImage *cornerImage = image;
    
    CGFloat width = image.size.width * image.scale;
    CGFloat height = image.size.height * image.scale;
    CGFloat radius = cornerRadius * image.scale;
    CGSize size = CGSizeMake(width, height);
    
    CGRect rect = (CGRect){CGPointZero, size};
    UIGraphicsBeginImageContextWithOptions(size, false, 1.0);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 0, radius);
    CGContextAddArcToPoint(context, 0, 0, radius, 0, radius);
    CGContextAddLineToPoint(context, width - radius, 0);
    CGContextAddArcToPoint(context, width, 0, width, radius, radius);
    CGContextAddLineToPoint(context, width, height - radius);
    CGContextAddArcToPoint(context, width, height, width - radius, height, radius);
    CGContextAddLineToPoint(context, radius, height);
    CGContextAddArcToPoint(context, 0, height, 0, height - radius, radius);
    CGContextAddLineToPoint(context, 0, radius);
    CGContextClosePath(context);
    
    CGContextClip(context);
    
    [image drawInRect:rect];       // 画图
    CGContextDrawPath(context, kCGPathFill);
    // CGContextDrawImage(context, rect, cornerImage.CGImage); // 同上
    
    cornerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return cornerImage;
}

// UIBezierPath 裁剪
+ (UIImage *)rh_bezierPathClip:(UIImage *)img
                  cornerRadius:(CGFloat)cornerRadius {
    int w = img.size.width * img.scale;
    int h = img.size.height * img.scale;
    CGRect rect = (CGRect){CGPointZero, CGSizeMake(w, h)};

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(w, h), false, 1.0);
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius] addClip];
    [img drawInRect:rect];
    UIImage *cornerImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return cornerImage;
}

@end
