//
//  RHRootViewController.m
//  TestMutiViewsSwitching
//
//  Created by DaFenQI on 2017/11/20.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHRootViewController.h"
#import "RHRootTargetViewController.h"

@interface RHRootViewController ()

@end

@implementation RHRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)rootAction:(id)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[RHRootTargetViewController alloc] init];
    [window makeKeyAndVisible];
}

@end
