//
//  RHContentViewController.m
//  TestMutiViewsSwitching
//
//  Created by DaFenQI on 2017/11/22.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHContentViewController.h"

@interface RHContentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation RHContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        int red = arc4random() % 255;
        int green = arc4random() % 255;
        int blue = arc4random() % 255;

        self.view.backgroundColor = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:1.0];
    }
    return self;
}

- (void)setContentTitle:(NSString *)contentTitle {
    _titleLabel.text = contentTitle;
}

@end
