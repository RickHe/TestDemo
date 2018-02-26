//
//  RHImageView.h
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/6.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHImageView : UIImageView

- (UIImage *)clipRectangleImageAtRect:(CGRect)rect;
- (UIImage *)clipRoundImageAtRect:(CGRect)rect
                        roundRect:(CGRect)roundRect;
- (UIImage *)clipAnyShapeImageAtPath:(NSMutableArray *)penPaths
                              atRect:(CGRect)rect;

@end
