//
//  RHStarView.h
//  TestStarView
//
//  Created by DaFenQI on 2017/9/22.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^kRHRateChangedBlock)(CGFloat currentRate);

typedef NS_ENUM(NSUInteger, RHStarRateStyle) {
    RHStarRateStyleWhole,   /* 整个 star 变化*/
    RHStarRateStyleHalf,    /* half star 变化 */
    RHStarRateStyleAny,     /* 随便变化 */
};

@interface RHStarView : UIView

/* 0 ~ 1 */
@property (nonatomic, assign) CGFloat currentRate;
/* 需要 star 的长宽相等，numberOfStars 由(int)frame.size.width / (int)frame.size.height计算得到 */
@property (nonatomic, readonly, assign) CGFloat numberOfStars;
/* 点击改变 star rate 回调 */
@property (nonatomic, copy) kRHRateChangedBlock rateChangedBlock;
/* 默认有动画 */
@property (nonatomic, assign) BOOL needAnimation;
/* 默认随便变化 */
@property (nonatomic, assign) RHStarRateStyle starRateStyle;

@end
