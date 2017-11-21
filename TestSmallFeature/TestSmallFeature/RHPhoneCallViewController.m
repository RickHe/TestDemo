//
//  RHPhoneCallViewController.m
//  TestSmallFeature
//
//  Created by DaFenQI on 2017/11/13.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHPhoneCallViewController.h"

@interface RHPhoneCallViewController () {
    UIWebView *_webview;
}
@end

@implementation RHPhoneCallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)phoneCallAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case 1: {
            // 一般 API
            NSURL *url = [NSURL URLWithString:@"tel://10086"];
            [self openUrl:url];
            break;
        }
        case 2: {
            // 私有 API
            NSURL *url = [NSURL URLWithString:@"telprompt://10086"];
            [self openUrl:url];
            break;
        }
        case 3: {
            // 通过 webview 打开
            if (!_webview) {
                _webview = [[UIWebView alloc] initWithFrame:CGRectZero];
                [self.view addSubview:_webview];
            }
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://10086"]];
            [_webview loadRequest:request];
            break;
        }
        default:
            break;
    }
    
    if (!_webview) {
        _webview = [[UIWebView alloc] initWithFrame:CGRectZero];
        [self.view addSubview:_webview];
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"tel://10086"]];
    [_webview loadRequest:request];
}

@end
