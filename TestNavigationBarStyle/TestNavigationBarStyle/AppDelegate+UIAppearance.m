//
//  AppDelegate+UIAppearance.m
//  UIAppearance
//
//  Created by virusbee on 16/7/7.
//  Copyright © 2016年 Meeno. All rights reserved.
//

#import "AppDelegate+UIAppearance.h"

@implementation AppDelegate (UIAppearance)

- (void)setAppearance {
    //导航标题文字颜色
    [UINavigationBar appearance].titleTextAttributes = @{
                                                         NSForegroundColorAttributeName:[UIColor whiteColor],
                                                         NSFontAttributeName : [UIFont systemFontOfSize:15]
                                                         };
    
    //导航条颜色
    [UINavigationBar appearance].barTintColor = [UIColor orangeColor];
    // 效果同上
    // [[UINavigationBar appearance] setBackgroundImage:[AppDelegate imageWithColor:[UIColor clearColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)] forBarMetrics:UIBarMetricsDefault];

    //导航项的文字颜色
    [UINavigationBar appearance].tintColor = [UIColor cyanColor];
    
    // 导航栏分割线颜色
    [[UINavigationBar appearance] setShadowImage:[AppDelegate imageWithColor:[UIColor blackColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)]];
    
    // 设置导航栏不透明 从64开始
    // 若不设置 从0开始
    [UINavigationBar appearance].translucent = NO;
    
    // 标签条颜色
    [UITabBar appearance].barTintColor = [UIColor greenColor];
    // 效果同上
    // [[UITabBar appearance] setBackgroundImage:[AppDelegate imageWithColor:[UIColor clearColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)]];

    //标签栏选中的文字＋图片颜色
    [UITabBar appearance].tintColor = [UIColor orangeColor];
    //标签栏未选中的文字＋图片颜色
    [UITabBar appearance].unselectedItemTintColor = [UIColor blackColor];
    
    // 标签栏分割线颜色
    [[UITabBar appearance] setShadowImage:[AppDelegate imageWithColor:[UIColor blackColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)]];
    
    // 设置标签栏不透明 底部从 tabbar的 top开始算
    // 若不设置 底部从 tabbar的 bottom开始计算
    [UITabBar appearance].translucent = NO;
}

// 获取一张颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    if (!color || size.width <= 0 || size.height <= 0) {
        return nil;
    }
    
    CGRect rect = {CGPointZero, size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context =UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
