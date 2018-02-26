//
//  RHImageProcessView.h
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/6.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^kRHProcessFinishedBlock)(UIImage *destImage);

@interface RHImageProcessView : UIView

+ (RHImageProcessView *)imageProcessViewWithFrame:(CGRect)frame;

@property(nonatomic, assign) UIImage *image;
@property(nonatomic, assign) UIImage *destImage;

@end
