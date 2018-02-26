//
//  RHCutImageView.h
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/6.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHBaseShapeViewFactory.h"

@interface RHCutImageView : UIImageView

@property(nonatomic, assign) kCutType cutType;
- (UIImage *)cutImage;
- (UIImage *)rotateImageView;

@property(nonatomic, strong) UIImage *contentImage;

@end
