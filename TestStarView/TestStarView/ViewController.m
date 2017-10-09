//
//  ViewController.m
//  TestStarView
//
//  Created by DaFenQI on 2017/9/22.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "ViewController.h"
#import "RHStarView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIView *imageView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 40)];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"star_yellow@2x.png" ofType:nil];
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:path];
    imageView.backgroundColor = [UIColor cyanColor];
    UIColor *colorPattern1 = [[UIColor alloc] initWithPatternImage:image];
    [imageView setBackgroundColor:colorPattern1];
    [self.view addSubview:imageView];
    
    RHStarView *starView = [[RHStarView alloc] initWithFrame:CGRectMake(100, 300, 230, 40)];
    starView.currentRate = 0.6;
    starView.backgroundColor = [UIColor clearColor];
    starView.starRateStyle = RHStarRateStyleHalf;
    starView.starRateStyle = RHStarRateStyleWhole;
    [self.view addSubview:starView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
