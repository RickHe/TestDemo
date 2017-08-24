//
//  ViewController.m
//  AssociatedObject
//
//  Created by hemiying on 15/12/23.
//  Copyright © 2015年 hemiying. All rights reserved.
//

#import "ViewController.h"
#import "UIAlertView+Block.h"
#import "DynamicBinding.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    DynamicBinding *dynamicBinding = [[DynamicBinding alloc] init];
    dynamicBinding.test = @"s";
    NSLog(@"%@", dynamicBinding.test);
}

- (IBAction)asda:(id)sender {
    [UIAlertView alertViewWithBlock:^(NSUInteger buttonIndex) {
        if (buttonIndex == 0) {
            NSLog(@"0");
        } else {
            NSLog(@"1");
        }
    } Title:@"提示" message:@"孙树生" cancelButtonTitle:@"cancel" otherButtonTitles:@"sss", nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
