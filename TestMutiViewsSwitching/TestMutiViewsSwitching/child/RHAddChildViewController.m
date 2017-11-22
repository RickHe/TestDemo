//
//  RHAddChildViewController.m
//  TestMutiViewsSwitching
//
//  Created by DaFenQI on 2017/11/20.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHAddChildViewController.h"
#import "RHTitleScrollView.h"
#import "RHContentViewController.h"

#define kRHScreenWidth [UIScreen mainScreen].bounds.size.width
#define kRHScreenHeight [UIScreen mainScreen].bounds.size.height

@interface RHAddChildViewController () <RHTitleScrollViewDelegate, UIScrollViewDelegate> {
    UIScrollView *_contentScrollView;
}

@property (weak, nonatomic) IBOutlet RHTitleScrollView *titleScrollView;
@property(nonatomic, strong) NSMutableArray *titlesArray;

@end

@implementation RHAddChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    
    [self creatSubviews];
}

- (void)creatSubviews {
    CGFloat y  = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect  = CGRectMake(0, y, kRHScreenWidth, kRHScreenHeight - y);
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:rect];
    
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.showsHorizontalScrollIndicator  = NO;
    _contentScrollView.delegate = self;
    [self.view addSubview:_contentScrollView];
    
    self.titlesArray = [@[@"体育", @"彩票", @"新闻", @"体育", @"彩票", @"新闻"] mutableCopy];
    self.titleScrollView.titlesArray = self.titlesArray;
    self.titleScrollView.delegate = self;
    [self addChildVC];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat y  = CGRectGetMaxY(self.titleScrollView.frame);
    CGRect rect  = CGRectMake(0, y, kRHScreenWidth, kRHScreenHeight - y);
    _contentScrollView.frame = rect;
}

- (void)titleScrollView:(RHTitleScrollView *)titleScrollView didSelectTitle:(NSString *)title atIndex:(NSInteger)index {
    [self jumpToChildViewController:index];
}

- (void)jumpToChildViewController:(NSInteger)index {
    _contentScrollView.contentOffset = CGPointMake(index * kRHScreenWidth, 0);
}

- (void)addChildVC {
    for (int i = 0; i < self.titlesArray.count; i++) {
        RHContentViewController *contentVC = [[RHContentViewController alloc] init];
        contentVC.contentTitle = self.titlesArray[i];
        [self addChildViewController:contentVC];
        
        contentVC.view.frame = CGRectMake(i * kRHScreenWidth, 0, kRHScreenWidth, kRHScreenHeight - _contentScrollView.frame.origin.y);
        [_contentScrollView addSubview:contentVC.view];
    }
    _contentScrollView.contentSize = CGSizeMake(self.titlesArray.count * kRHScreenWidth, 0);
}

- (void)setVCFrame:(UIViewController *)vc {
    vc.view.frame = CGRectMake(0, 0, 200, 200);
    vc.view.center = self.view.center;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index  = _contentScrollView.contentOffset.x / kRHScreenWidth;
    
    [self.titleScrollView selectIndex:index];
    [self jumpToChildViewController:index];
}

@end
