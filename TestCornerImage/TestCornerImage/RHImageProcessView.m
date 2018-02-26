//
//  RHImageProcessView.m
//  TestCornerImage
//
//  Created by DaFenQI on 2017/12/6.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHImageProcessView.h"
#import "RHCutImageView.h"

@interface RHImageProcessView () {
    kCutType _cutType;
    UIImage *_originImage;
}

@property (weak, nonatomic) IBOutlet RHCutImageView *cutImageView;
@property (weak, nonatomic) IBOutlet UIView *buttonBackgroundView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *insertButton;

@end

@implementation RHImageProcessView

- (IBAction)cancelAction:(id)sender {
    self.cutImageView.cutType = kCutTypeNone;
    [self disableButton];
}

- (IBAction)insertImage:(id)sender {
    self.destImage = [self.cutImageView cutImage];
    [self disableButton];
    [self unSelectAll];
}

- (IBAction)anyShapeAction:(id)sender {
    self.cutImageView.cutType = kCutTypeAny;
    [self selectButton:sender];
}

- (void)enableButton {
    self.cancelButton.hidden = NO;
    self.insertButton.hidden = NO;
}

- (void)disableButton {
    self.cancelButton.hidden = YES;
    self.insertButton.hidden = YES;
}

- (IBAction)roundAction:(id)sender {
    self.cutImageView.cutType = kCutTypeNone;
    
    [self unSelectAll];
    [self disableButton];
    
    self.destImage = [self.cutImageView rotateImageView];
}

- (void)selectButton:(UIButton *)btn {
    [self enableButton];

    btn.selected = !btn.selected;
    BOOL selected = btn.selected;
    [self unSelectAll];
    btn.selected = selected;
}

- (void)unSelectAll {
    for (UIView *subView in self.buttonBackgroundView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *oButton = (UIButton *)subView;
            oButton.selected = NO;
        }
    }
}

- (IBAction)rectangleAction:(id)sender {
    [self enableButton];
    self.cutImageView.cutType = kCutTypeRectangle;
    [self selectButton:sender];
}

- (void)removeCutImageView {
    [_cutImageView removeFromSuperview];
    _cutImageView = nil;
}

- (IBAction)resetAction:(id)sender {
    self.cutImageView.cutType = kCutTypeNone;
    [self unSelectAll];
    self.cutImageView.contentImage = _originImage;
    [self disableButton];
    self.destImage = _originImage;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.buttonBackgroundView.layer.cornerRadius = 5.0f;
    self.buttonBackgroundView.layer.masksToBounds = YES;
    self.buttonBackgroundView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.buttonBackgroundView.layer.borderWidth = 0.6;
    
    self.insertButton.layer.cornerRadius = 5.0f;
    self.insertButton.layer.masksToBounds = YES;
    self.insertButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.insertButton.layer.borderWidth = 0.6;
    
    self.cancelButton.layer.cornerRadius = 5.0f;
    self.cancelButton.layer.masksToBounds = YES;
    self.cancelButton.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.cancelButton.layer.borderWidth = 0.6;
    
    [self disableButton];
    
    self.buttonBackgroundView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.8];
}

- (void)setImage:(UIImage *)image {
    _originImage = image;
    _destImage = image;
    self.cutImageView.contentImage = image;
}

+ (RHImageProcessView *)imageProcessViewWithFrame:(CGRect)frame {
    NSArray *arr = [[NSBundle mainBundle] loadNibNamed:@"RHImageProcessView"
                                                 owner:self
                                               options:nil];
    RHImageProcessView *view = [arr firstObject];
    view.frame = frame;
    return view;
}

@end
