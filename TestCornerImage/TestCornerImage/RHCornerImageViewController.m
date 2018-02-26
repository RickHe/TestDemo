//
//  RHCornerImageViewController.m
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/6.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHCornerImageViewController.h"
#import "UIImage+RHCornerImage.h"

@interface RHCornerImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation RHCornerImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"1.jpg"];
    self.imageView1.image = [UIImage rh_getCornerImage:image
                                          cornerRadius:80];
    
    self.imageView2.image = [UIImage rh_bezierPathClip:image
                                          cornerRadius:80];
    
    self.imageView.image = image;
    self.imageView.layer.cornerRadius = 20;
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.borderWidth = 0;
}

@end
