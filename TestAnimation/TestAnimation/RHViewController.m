//
//  RHViewController.m
//  TestAnimation
//
//  Created by DaFenQI on 2017/10/12.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHViewController.h"
#import "RHTransitionAnimationViewController.h"

@interface RHViewController ()

@end

@implementation RHViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testAction:(id)sender {
    RHTransitionAnimationViewController *trans = [[RHTransitionAnimationViewController alloc] init];
    [self.navigationController pushViewController:trans animated:YES];
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
