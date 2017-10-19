//
//  ViewController.m
//  TestNetworkRequest
//
//  Created by DaFenQI on 2017/10/18.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "ViewController.h"
#import "RHHttpRequestManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setObject:@"5b1328f8-20e1-4512-99c0-9a668545126e&questionId" forKey:@"classHomeWorkId"];
    [params setObject:@"254a8ea8-c5c9-4e6e-a5e3-2df4b381901b" forKey:@"questionId"];
    
    [[RHHttpRequestManager sharedManager] postRequestWithPath:@"wj/classHomeWorkCorrectResult"
                                                       params:params
                                                      success:^(id obj) {
                                                          NSLog(@"%@", obj);
    }
                                                      failure:^(id obj) {
                                                          NSLog(@"%@", obj);
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
