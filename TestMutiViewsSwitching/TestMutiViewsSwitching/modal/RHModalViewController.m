//
//  RHModalViewController.m
//  TestMutiViewsSwitching
//
//  Created by DaFenQI on 2017/11/20.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHModalViewController.h"
#import "RHModalTargetViewController.h"

@interface RHModalViewController ()

@end

@implementation RHModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)presentVC:(id)sender {
    RHModalTargetViewController *vc = [[RHModalTargetViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
