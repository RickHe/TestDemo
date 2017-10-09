//
//  ViewController.m
//  TestWebView
//
//  Created by DaFenQI on 2017/9/29.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "ViewController.h"
#import "RHWebView.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet RHWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _webView.url = @"http://news.sina.com.cn/china/xlxw/2017-09-28/doc-ifymkwwk6809404.shtml";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
