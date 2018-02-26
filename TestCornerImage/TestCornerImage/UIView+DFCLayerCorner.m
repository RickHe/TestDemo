
//
//  UIView+DFCLayerCorner.m
//  planByGodWin
//
//  Created by DaFenQi on 16/11/21.
//  Copyright © 2016年 DFC. All rights reserved.
//

#import "UIView+DFCLayerCorner.h"

@implementation UIView (DFCLayerCorner)

#define kUIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

- (void)DFC_setLayerCorner {
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [kUIColorFromRGB(0xcdcdcd) CGColor];
    self.layer.borderWidth = 0.5f;
}

@end
