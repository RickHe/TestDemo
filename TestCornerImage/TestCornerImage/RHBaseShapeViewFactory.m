//
//  RHBaseShapeViewFactory.m
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/7.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHBaseShapeViewFactory.h"
#import "RHRectangleView.h"
#import "RHRoundView.h"

@implementation RHBaseShapeViewFactory

+ (RHBaseShapeView *)shapeViewWithType:(kCutType)cutType {
    RHBaseShapeView *baseShapeView = nil;
    switch (cutType) {
        case kCutTypeRound:
            baseShapeView = [[RHRoundView alloc] initWithFrame:CGRectZero];
            break;
        case kCutTypeRectangle:
            baseShapeView = [[RHRectangleView alloc] initWithFrame:CGRectZero];
            break;
        default:
            break;
    }
    return baseShapeView;
}

@end
