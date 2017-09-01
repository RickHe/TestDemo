//
//  RHCarouseCell.h
//  TestCarouselImageView
//
//  Created by DaFenQI on 2017/9/1.
//  Copyright © 2017年 DaFenQi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RHCarouseCell : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSInteger currentImageIndex;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIColor *titleColor;

@end
