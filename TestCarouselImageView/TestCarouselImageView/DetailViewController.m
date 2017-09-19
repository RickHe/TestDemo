//
//  DetailViewController.m
//  Test_carouselImageView
//
//  Created by DaFenQI on 2017/9/1.
//  Copyright © 2017年 DaFenQi. All rights reserved.
//

#import "DetailViewController.h"
#import "RHCarouselImageView.h"

@interface DetailViewController () {
    RHCarouselImageView *_carousel;
}

@end

@implementation DetailViewController

- (void)dealloc {
    NSLog(@"%s", __func__);
    [_carousel removeTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _carousel = [[RHCarouselImageView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300) dataSource:@[@"1.jpg", @"2.jpg", @"3.jpg"] mainImageWidthRatio:0.6 minimumInteritemSpacing:10];
    _carousel.backgroundColor = [UIColor blackColor];
    _carousel.topInset = 5;
    _carousel.bottomInset = 5;
    _carousel.titles = [NSMutableArray arrayWithArray:@[@"第一页", @"第二页", @"第三页"]];
    [self.view addSubview:_carousel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
