//
//  RHImageProcessViewController.h
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/6.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHImageProcessView.h"

@interface RHImageProcessViewController : UIViewController

@property(nonatomic, copy) kRHProcessFinishedBlock processFinishedBlock;
@property(nonatomic, strong) UIImage *image;

@end
