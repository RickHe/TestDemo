//
//  RHTitleScrollView.m
//  TestMutiViewsSwitching
//
//  Created by DaFenQI on 2017/11/21.
//  Copyright © 2017年 DaFenQI. All rights reserved.
//

#import "RHTitleScrollView.h"

@interface RHTitleScrollView () {
    UIScrollView *_scrollView;
}

@end

@implementation RHTitleScrollView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self createSubviews];
    }
    return self;
}

- (void)createSubviews {
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)selectIndex:(NSInteger)index {
    
}

- (void)selectTitle:(NSString *)title {
    
}

@end
