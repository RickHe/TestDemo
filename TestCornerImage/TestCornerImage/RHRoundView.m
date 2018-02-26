//
//  RHRoundView.m
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/7.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHRoundView.h"

@implementation RHRoundView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (UIView *subview in self.subviews) {
            [subview removeFromSuperview];
        }
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddRect(context, rect);
    CGContextSetAlpha(context, 0.4);
    [[UIColor blackColor] setFill];
    CGContextFillPath(context);
    
    context = UIGraphicsGetCurrentContext();
    
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    CGContextClearRect(context, rect);
    [[UIColor clearColor] setFill];
    CGContextSetAlpha(context, 1);
    CGContextFillPath(context);
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
}

@end
