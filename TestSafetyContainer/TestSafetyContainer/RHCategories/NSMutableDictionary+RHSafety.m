//
//  NSMutableDictionary+RHSafety.m
//  TestSafetyContainer
//
//  Created by DaFenQI on 2018/4/10.
//  Copyright © 2018年 DaFenQI. All rights reserved.
//

#import "NSMutableDictionary+RHSafety.h"
#import <objc/runtime.h>
#import "RHExceptionHelper.h"

@implementation NSMutableDictionary (RHSafety)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzlingMethod];
    });
}

+ (void)swizzlingMethod {
    [self swizzlingSelector:@selector(setObject:forKeyedSubscript:) destSelector:@selector(rh_setObject:forKeyedSubscript:)];
    [self swizzlingSelector:@selector(setObject:forKey:) destSelector:@selector(rh_setObject:forKey:)];
}

+ (void)swizzlingSelector:(SEL)selector destSelector:(SEL)destSelector {
    Class class = NSClassFromString(@"__NSDictionaryM");
    Method originMethod = class_getInstanceMethod(class, selector);
    Method destMethod = class_getInstanceMethod(class, destSelector);
    method_exchangeImplementations(originMethod, destMethod);
}


- (void)rh_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (obj && key) {
        [self rh_setObject:obj forKeyedSubscript:key];
    } else {
        [RHExceptionHelper raiseException:@"setObjectForKey: object or key is nil"];
    }
}

- (void)rh_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (anObject && aKey) {
        [self rh_setObject:anObject forKey:aKey];
    } else {
        [RHExceptionHelper raiseException:@"setObjectForKey: object or key is nil"];
    }
}

@end
