//
//  RHRootTargetViewController.m
//  TestMutiViewsSwitching
//
//  Created by DaFenQI on 2017/11/20.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHRootTargetViewController.h"
#import "RHTableViewController.h"

@interface RHRootTargetViewController ()

@end

@implementation RHRootTargetViewController

- (IBAction)backAction:(id)sender {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [main instantiateViewControllerWithIdentifier:@"main"];
    window.rootViewController = vc;
                                 
    [window makeKeyAndVisible];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

@end
