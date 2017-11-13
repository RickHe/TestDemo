//
//  RHBaseViewController.m
//  TestSmallFeature
//
//  Created by DaFenQI on 2017/11/13.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHBaseViewController.h"

@interface RHBaseViewController ()

@end

@implementation RHBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)openUrl:(NSURL *)url {
    if ([[UIApplication sharedApplication] respondsToSelector:@selector(openURL:options:completionHandler:)]) {
        [[UIApplication sharedApplication] openURL:url
                                           options:@{}
                                 completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:url];
    }
}

@end
