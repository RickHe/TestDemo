//
//  ViewController.m
//  Timer retain cycle
//
//  Created by hmy2015 on 16/8/28.
//  Copyright © 2016年 何米颖大天才. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)jumpAction:(id)sender {
    SecondViewController *secondVC = [SecondViewController new];
//    [self presentViewController:secondVC animated:YES completion:nil];
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
