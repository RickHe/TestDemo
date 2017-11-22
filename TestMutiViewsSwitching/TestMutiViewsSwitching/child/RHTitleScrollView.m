//
//  RHTitleScrollView.m
//  TestMutiViewsSwitching
//
//  Created by DaFenQI on 2017/11/21.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHTitleScrollView.h"

#define kRHMinItemWidth 88
#define kRHSelectedScale 1.1

#define kRHSelfHeight self.bounds.size.height
#define kRHSelfWidth self.bounds.size.width
#define kRHBaseTag 100

@interface RHTitleScrollView () {
    UIScrollView *_scrollView;
    UIImageView *_tipImageView;
    UIButton *_selectedButton;
}

@end

@implementation RHTitleScrollView

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}

- (void)createSubviews {
    CGFloat itemWidth = kRHSelfWidth / _titlesArray.count;
    if (itemWidth < kRHMinItemWidth) {
        itemWidth = kRHMinItemWidth;
    }
    
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator  = NO;
    _scrollView.showsVerticalScrollIndicator  = NO;
    [self addSubview:_scrollView];
    
    _scrollView.contentSize = CGSizeMake(itemWidth * _titlesArray.count, kRHSelfHeight);
    
    for (int i = 0; i < _titlesArray.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i * itemWidth, 0, itemWidth, kRHSelfHeight);
        btn.tag = i + kRHBaseTag;
        [btn setTitle:_titlesArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
        
        if (i == 0) {
            _selectedButton = btn;
            [self buttonAction:btn];
        }
    }
    
    _tipImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, kRHSelfHeight - 3, itemWidth, 3)];
    _tipImageView.backgroundColor = [UIColor redColor];
    [_scrollView addSubview:_tipImageView];
}

- (void)buttonAction:(UIButton *)btn {
    _selectedButton.selected = NO;
    _selectedButton.transform = CGAffineTransformIdentity;
    
    btn.transform = CGAffineTransformMakeScale(kRHSelectedScale, kRHSelectedScale);
    btn.selected = YES;
    
    _selectedButton = btn;
    
    CGRect frame = _tipImageView.frame;
    frame.origin.x = (btn.tag - kRHBaseTag) * frame.size.width;
    _tipImageView.frame = frame;
    
    [self setScrollOffset:btn];
    
    if ([self.delegate respondsToSelector:@selector(titleScrollView:didSelectTitle:atIndex:)]) {
        [self.delegate titleScrollView:self didSelectTitle:_titlesArray[btn.tag - kRHBaseTag] atIndex:btn.tag - kRHBaseTag];
    }
}

- (void)setScrollOffset:(UIButton *)btn {
    if (_scrollView.contentSize.width <= kRHSelfWidth) {
        return;
    }
    
    CGFloat offset = btn.center.x - kRHSelfWidth * 0.5;
    if (offset < 0) {
        offset = 0;
    }
    
    CGFloat maxOffset  = _scrollView.contentSize.width - kRHSelfWidth;
    if (offset > maxOffset) {
        offset = maxOffset;
    }
    
    [_scrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

- (void)setTitlesArray:(NSMutableArray *)titlesArray {
    _titlesArray = titlesArray;
    [self createSubviews];
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)selectIndex:(NSInteger)index {
    UIButton *btn = [_scrollView viewWithTag:index + kRHBaseTag];
    [self buttonAction:btn];
}

- (void)selectTitle:(NSString *)title {
    if ([_titlesArray containsObject:title]) {
        UIButton *btn = [_scrollView viewWithTag:[_titlesArray indexOfObject:title] + kRHBaseTag];
        [self buttonAction:btn];
    }
}

@end
