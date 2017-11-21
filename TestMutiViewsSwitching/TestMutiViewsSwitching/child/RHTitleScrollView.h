//
//  RHTitleScrollView.h
//  TestMutiViewsSwitching
//
//  Created by DaFenQI on 2017/11/21.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RHTitleScrollView;

@protocol RHTitleScrollViewDelegate <NSObject>

- (void)titleScrollView:(RHTitleScrollView *)titleScrollView didSelectTitle:(NSString *)title atIndex:(NSInteger)index;

@end

@interface RHTitleScrollView : UIView

@property(nonatomic, strong) NSMutableArray *titlesArray;

- (void)selectIndex:(NSInteger)index;
- (void)selectTitle:(NSString *)title;

@end
