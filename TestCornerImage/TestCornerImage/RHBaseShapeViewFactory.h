//
//  RHBaseShapeViewFactory.h
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/7.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RHBaseShapeView;

typedef NS_ENUM(NSUInteger, kCutType) {
    kCutTypeRectangle,
    kCutTypeRound,
    kCutTypeAny,
    kCutTypeNone
};

@interface RHBaseShapeViewFactory : NSObject

+ (RHBaseShapeView *)shapeViewWithType:(kCutType)cutType;

@end
