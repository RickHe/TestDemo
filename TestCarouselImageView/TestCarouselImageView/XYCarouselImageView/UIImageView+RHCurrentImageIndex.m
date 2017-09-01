//
//  UIImageView+CurrentImageIndex.m
//  Carousel Image Effect
//
//  Created by hmy2015 on 16/3/9.
//  Copyright © 2016年 何米颖. All rights reserved.
//

#import "UIImageView+RHCurrentImageIndex.h"
#import <objc/runtime.h>

static void *RH_kCurrentImageIndexKey = @"RH_kCurrentImageIndexKey";

@implementation UIImageView (RHCurrentImageIndex)

- (void)setRh_currentImageIndex:(NSNumber *)rh_currentImageIndex {
    objc_setAssociatedObject(self, RH_kCurrentImageIndexKey, rh_currentImageIndex, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)rh_currentImageIndex {
    return objc_getAssociatedObject(self, RH_kCurrentImageIndexKey);

}

@end
