//
//  RHCutView.h
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/6.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RHBaseShapeViewFactory.h"

@interface RHCutView : UIView

@property(nonatomic, assign) CGRect rectagleFrame;
@property(nonatomic, assign) kCutType cutType;

@end
