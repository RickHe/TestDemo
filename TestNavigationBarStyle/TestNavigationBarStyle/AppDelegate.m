//
//  AppDelegate.m
//  TestNavigationBarStyle
//
//  Created by DaFenQI on 2017/9/19.
//  Copyright © 2017年 DaFenQi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UINavigationBar *itemBar =  [UINavigationBar appearance];
    // navigation bar color
    itemBar.tintColor = [UIColor redColor];
    // navigation background color
    [itemBar setBarTintColor:[UIColor yellowColor]];
    
    [itemBar setTitleTextAttributes:@{
                                      NSForegroundColorAttributeName : [UIColor redColor]
                                      }];
    
    // navigation background color
    UIImage *colorImage = [AppDelegate imageWithColor:[UIColor greenColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)];
    [itemBar setBackgroundImage:colorImage forBarMetrics:UIBarMetricsDefault];
    
    // navigationbar 分割线 color
    [itemBar setShadowImage:[AppDelegate imageWithColor:[UIColor redColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)]];
    
    // 设置为白色
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    if ([self.window.rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabbarVC = (UITabBarController *)self.window.rootViewController;
        [tabbarVC.tabBar setBackgroundImage:[AppDelegate imageWithColor:[UIColor clearColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)]];
        [tabbarVC.tabBar setShadowImage:[AppDelegate imageWithColor:[UIColor redColor] size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 0.5)]];
    }
    
    return YES;
}

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


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
