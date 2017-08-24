//
//  SecondViewController.m
//  Timer retain cycle
//
//  Created by hmy2015 on 16/8/28.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "SecondViewController.h"
#import "NSTimer+BlockTimer.h"

@interface SecondViewController () {
    NSTimer *timer;
}

@end

@implementation SecondViewController

- (void)dealloc {
    [timer invalidate];
    NSLog(@"%s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 内存泄露
    //timer = [NSTimer scheduledTimerWithTimeInterval:1.0
//                                     target:self
//                                   selector:@selector(timerAction:)
//                                   userInfo:nil
//                                    repeats:YES];
    // 使用 block
    __block int i = 0;
    timer = [NSTimer HMYScheduledTimerWithTimeInterval:1.0 repeats:YES timerBlock:^{
        NSLog(@"out put %i", i++);
    }];
}

- (void)timerAction:(NSTimer *)timer {
    static int i = 0;
    NSLog(@"out put %i", i++);
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
