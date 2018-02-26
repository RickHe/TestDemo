//
//  RHImageProcessViewController.m
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/6.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHImageProcessViewController.h"
#import "RHImageProcessView.h"

@interface RHImageProcessViewController () {
    RHImageProcessView *_process;
}

@end

@implementation RHImageProcessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"图片编辑";
    //self.navigationController.
//    UIBarButtonItem *cacelBarButtonItem = [self.navigationController dfc_getNormalLeftBarButtonItem:@"取消"
//                                                                                             target:self
//                                                                                           selector:@selector(cancelAction:)];
//    self.navigationItem.leftBarButtonItem = cacelBarButtonItem;
//    
//    UIBarButtonItem *insertBarButtonItem = [self.navigationController dfc_getNormalRightBarButtonItem:@"插入"
//                                                                                               target:self
//                                                                                             selector:@selector(confirmAction:)];
//    self.navigationItem.rightBarButtonItems = @[insertBarButtonItem];
    
    
    self.image = [UIImage imageNamed:@"1.jpg"];
    _process = [RHImageProcessView imageProcessViewWithFrame:self.view.bounds];
    _process.image = self.image;
    [self.view addSubview:_process];
}

- (void)cancelAction:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)confirmAction:(id)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    if (self.processFinishedBlock) {
        self.processFinishedBlock(_process.destImage);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
