//
//  RHCarouseCell.m
//  TestCarouselImageView
//
//  Created by DaFenQI on 2017/9/1.
//  Copyright © 2017年 DaFenQi. All rights reserved.
//

#import "RHCarouseCell.h"

#define kLabelFrame CGRectMake(0, self.bounds.size.height - 22 - 8, self.bounds.size.width, 22)
#define kDefaultFont [UIFont systemFontOfSize:16]
#define kDefaultColor [UIColor blackColor]

@interface RHCarouseCell () {
    UIImageView *_imageView;
    UILabel *_titleLabel;
}

@end

@implementation RHCarouseCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self p_initSubviews];
    }
    return self;
}

- (void)p_initSubviews {
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:kLabelFrame];
    _titleLabel.font = kDefaultFont;
    _titleLabel.textColor = kDefaultColor;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_titleLabel];
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _imageView.frame = self.bounds;
    _titleLabel.frame = kLabelFrame;
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageView.image = _image;
}

- (void)setTitle:(NSString *)title {
    _title = title;
    _titleLabel.text = _title;
}

- (void)setTitleFont:(UIFont *)titleFont {
    _titleFont = titleFont;
    _titleLabel.font = _titleFont;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    _titleLabel.textColor = titleColor;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
