//
//  RHJumpToApplicationViewController.m
//  TestSmallFeature
//
//  Created by DaFenQI on 2017/11/13.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHJumpToApplicationViewController.h"

@interface RHJumpToApplicationViewController ()

@end

@implementation RHJumpToApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)jumpTo:(UIButton *)sender {
    // 如何查找 url schemes
    // 1：下载他人的应用 ipa
    // 2：修改后缀名为 zip
    // 3：解压，打开 payload 文件夹
    // 4：右键 payload 文件夹 下的文件，显示包内容
    // 5：打开 info.plist 文件
    // 6：url types 的 item0 的 url schemes
    NSURL *url = [NSURL URLWithString:@"weixin://"];
    [self openUrl:url];
}

@end
