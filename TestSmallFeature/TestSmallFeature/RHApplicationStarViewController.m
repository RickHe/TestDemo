//
//  RHApplicationStarViewController.m
//  TestSmallFeature
//
//  Created by DaFenQI on 2017/11/13.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHApplicationStarViewController.h"

@interface RHApplicationStarViewController ()

@end

@implementation RHApplicationStarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// 评分
- (IBAction)openAppStore:(id)sender {
    // 上线时候每一个 app 会分配一个 appid
    NSString *appid = @"your appid";
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/cn/app/id%@?mt=8", appid]];
    [self openUrl:url];
}

@end
