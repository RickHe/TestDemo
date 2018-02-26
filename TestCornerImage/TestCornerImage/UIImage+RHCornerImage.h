//
//  UIImage+RHCornerImage.h
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/5.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//
// 两种获取圆角图片的方式
// 1: rh_getCornerImage:cornerRadius: 使用CGContextClip，为图片添加圆角路径
// 2: rh_bezierPathClip:cornerRadius: 使用贝塞尔曲线的addClip方法

#import <UIKit/UIKit.h>

@interface UIImage (RHCornerImage)

// tip: cornerRadius = layer.cornerRadius * 4
+ (UIImage *)rh_getCornerImage:(UIImage *)image
                  cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)rh_bezierPathClip:(UIImage *)img
                  cornerRadius:(CGFloat)cornerRadius;

@end
