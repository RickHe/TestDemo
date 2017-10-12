//
//  RHSpringAnimationViewController.m
//  TestAnimation
//
//  Created by DaFenQI on 2017/10/12.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHSpringAnimationViewController.h"
#import "POP.h"

static CGFloat const kBottomOriginY = 100;

@interface RHSpringAnimationViewController ()

@end

@implementation RHSpringAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // UIKit 弹簧动画
    UILabel *springLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    springLabel.text = @"UIKit";
    springLabel.backgroundColor = [UIColor redColor];
    springLabel.textAlignment = NSTextAlignmentCenter;
    springLabel.userInteractionEnabled = YES;
    [self.view addSubview:springLabel];
    
    UIGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTranistion:)];
    [springLabel addGestureRecognizer:tap];
    
    // POP 弹簧动画
    UILabel *popSpringLabel = [[UILabel alloc] initWithFrame:CGRectMake(400, 100, 200, 200)];
    popSpringLabel.text = @"POP";
    popSpringLabel.backgroundColor = [UIColor redColor];
    popSpringLabel.textAlignment = NSTextAlignmentCenter;
    popSpringLabel.userInteractionEnabled = YES;
    [self.view addSubview:popSpringLabel];
    
    UIGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTranistion:)];
    [popSpringLabel addGestureRecognizer:tap1];
}

- (void)tapTranistion:(UITapGestureRecognizer *)tap {
    CGRect frame = tap.view.frame;
    BOOL isGoDown = (frame.origin.y == kBottomOriginY);
    
    if (isGoDown) {
        frame.origin.y = self.view.bounds.size.height - kBottomOriginY - frame.size.height;
    }
    else {
        frame.origin.y = kBottomOriginY;
    }
    
    if (tap.view) {
        [UIView animateWithDuration:1.f     /* 动画时长 */
                              delay:0.f     /* 延时 */
             usingSpringWithDamping:0.3f    /* 弹性 */
              initialSpringVelocity:0.3f    /* 初始速度 */
                            options:kNilOptions animations:^{
                                tap.view.frame = frame;
                            }
                         completion:^(BOOL finished) {
                             
                         }];
    } else {
        POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        spring.toValue = [NSValue valueWithCGRect:frame];
        spring.springBounciness = 15;
        spring.springSpeed = 20;
        
        [tap.view pop_addAnimation:spring forKey:@"spring"];
    }
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
