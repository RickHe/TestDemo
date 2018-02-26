//
//  RHAnyShapeView.h
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/7.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHImageView.h"

@interface RHAnyShapeView : UIImageView

@property(nonatomic, strong) NSMutableArray *penPaths;
@property(nonatomic, assign) CGRect drawRect;
@property(nonatomic, strong) UIImageView *imageView;

- (void)insert;

@end
